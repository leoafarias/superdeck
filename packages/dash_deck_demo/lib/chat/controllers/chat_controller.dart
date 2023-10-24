import 'dart:async';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:dash_deck_demo/chat/dto/assistant_message.dto.dart';
import 'package:dash_deck_demo/chat/dto/chat_message.dto.dart';
import 'package:dash_deck_demo/chat/dto/configuration.dto.dart';
import 'package:dash_deck_demo/chat/dto/example.dto.dart';
import 'package:dash_deck_demo/chat/dto/user_message.dto.dart';
import 'package:dash_deck_demo/chat/enum/chat_roles.enum.dart';
import 'package:dash_deck_demo/chat/helpers/localstorage.dart';
import 'package:dash_deck_demo/env/env.dart';
import 'package:palm_api/palm_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_controller.g.dart';
part 'chat_controller.mapper.dart';

@riverpod
bool waitingResponse(WaitingResponseRef ref) {
  return ref
      .watch(chatControllerProvider.select((value) => value.waitingResponse));
}

@riverpod
List<ChatMessage> messages(MessagesRef ref) {
  final messages =
      ref.watch(chatControllerProvider.select((value) => value.chatMessages));
  return messages.reversed.where((element) => element.hidden == false).toList();
}

// Define a state class to hold the data
@MappableClass()
class ChatState with ChatStateMappable {
  final String? context;
  final String? projectPath;
  final List<ChatMessage> chatMessages;

  final List<ExampleChat> examples;
  final bool waitingResponse;

  static const _storageKey = 'chat_state';

  ChatState({
    this.context,
    this.projectPath,
    this.chatMessages = const [],
    this.examples = const [],
    this.waitingResponse = false,
  });

  static const fromMap = ChatStateMapper.fromMap;
  static const fromJson = ChatStateMapper.fromJson;

  Future<void> save() async {
    await localStorage.setItem(_storageKey, toJson());
  }

  Future<void> clear() async {
    await localStorage.deleteItem(_storageKey);
  }

  static Future<ChatState> load() async {
    final json = await localStorage.getItem(_storageKey);
    if (json == null) {
      return ChatState();
    }
    return ChatState.fromJson(json);
  }
}

@riverpod
class ChatController extends _$ChatController {
  final _text = TextService(apiKey: Env.palmApiKey);

  @override
  ChatState build() {
    _load();
    return ChatState();
  }

  Future<void> _load() async {
    await Future.delayed(const Duration(milliseconds: 100));
    const welcomeMessage = AssistantMessage(
      content: 'Hi, I am your Flutter coding assistant. How can I help you?',
    );

    _addMessage(welcomeMessage);
  }

  void _addMessage(ChatMessage message) {
    state = ChatState(
      chatMessages: [...state.chatMessages, message],
      waitingResponse: state.waitingResponse,
      context: state.context,
      examples: state.examples,
    );
  }

  void _updateLastMessage(ChatMessage message) {
    final updatedMessages = List<ChatMessage>.from(state.chatMessages)
      ..removeLast()
      ..add(message);
    state = ChatState(
      chatMessages: updatedMessages,
      waitingResponse: state.waitingResponse,
      context: state.context,
      examples: state.examples,
    );
  }

  void _waitingResponse(bool value) {
    state = ChatState(
      chatMessages: state.chatMessages,
      waitingResponse: value,
      context: state.context,
      examples: state.examples,
    );
  }

  Future<String> sendPrompt({
    required String name,
    required String content,
  }) async {
    final prompt = TextPrompt(text: content);

    final assistantMessage = AssistantMessage(
      content: name,
      status: ResponseStatus.waitingResponse,
    );

    _addMessage(assistantMessage);

    try {
      final textResponse = await _text.generateText(
        prompt: prompt,
        model: PalmModel.textBison001.name,
      );

      final response = textResponse.candidates.first.output;

      _updateLastMessage(
        assistantMessage.copyWith(
          response: response,
          status: ResponseStatus.done,
        ),
      );
      return response;
    } catch (e) {
      // Remove the last message
      final updatedMessages = List<ChatMessage>.from(state.chatMessages)
        ..removeLast();
      state = ChatState(
        chatMessages: updatedMessages,
        waitingResponse: false,
      );
      rethrow;
    } finally {}
  }

  // Add message
  Future<void> sendMessage(
    String content, {
    Configuration? configuration,
    bool currentSlide = false,
  }) async {
    final message = UserMessage(content: content);
    _addMessage(message);
    _waitingResponse(true);

    final prompt = TextPrompt(text: message.content);

    try {
      final response = await _text.generateText(
        prompt: prompt,
        model: PalmModel.textBison001.name,
      );

      final messageResponse = AssistantMessage(
        content: response.candidates.first.output,
      );

      state = state.copyWith(
        chatMessages: [...state.chatMessages, messageResponse],
        waitingResponse: false,
      );
    } catch (e) {
      // Remove the last message
      final updatedMessages = List<ChatMessage>.from(state.chatMessages)
        ..removeLast();
      state = ChatState(
        chatMessages: updatedMessages,
        waitingResponse: false,
      );
      rethrow;
    } finally {}
  }

  void clearState() {
    state = ChatState()..clear();
  }

  ChatMessage _convertFromPalmMessage(Message message) {
    return ChatMessage.from(
      role: message.author == 'user' ? MessageRole.user : MessageRole.assistant,
      content: message.content,
      createAt: DateTime.now(),
      hidden: false,
    );
  }

  Message _convertToPalmMessage(ChatMessage message) {
    return Message(
      author: message.role == MessageRole.user ? 'user' : 'assistant',
      content: message.content,
    );
  }

  Example _convertToPalmExample(ExampleChat example) {
    return Example(
      input: _convertToPalmMessage(example.input),
      output: _convertToPalmMessage(example.output),
    );
  }
}
