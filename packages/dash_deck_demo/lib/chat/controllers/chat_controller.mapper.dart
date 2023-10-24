// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'chat_controller.dart';

class ChatStateMapper extends ClassMapperBase<ChatState> {
  ChatStateMapper._();

  static ChatStateMapper? _instance;
  static ChatStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ChatStateMapper._());
      ChatMessageMapper.ensureInitialized();
      ExampleChatMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ChatState';

  static String? _$context(ChatState v) => v.context;
  static const Field<ChatState, String> _f$context =
      Field('context', _$context, opt: true);
  static String? _$projectPath(ChatState v) => v.projectPath;
  static const Field<ChatState, String> _f$projectPath =
      Field('projectPath', _$projectPath, opt: true);
  static List<ChatMessage> _$chatMessages(ChatState v) => v.chatMessages;
  static const Field<ChatState, List<ChatMessage>> _f$chatMessages =
      Field('chatMessages', _$chatMessages, opt: true, def: const []);
  static List<ExampleChat> _$examples(ChatState v) => v.examples;
  static const Field<ChatState, List<ExampleChat>> _f$examples =
      Field('examples', _$examples, opt: true, def: const []);
  static bool _$waitingResponse(ChatState v) => v.waitingResponse;
  static const Field<ChatState, bool> _f$waitingResponse =
      Field('waitingResponse', _$waitingResponse, opt: true, def: false);

  @override
  final Map<Symbol, Field<ChatState, dynamic>> fields = const {
    #context: _f$context,
    #projectPath: _f$projectPath,
    #chatMessages: _f$chatMessages,
    #examples: _f$examples,
    #waitingResponse: _f$waitingResponse,
  };

  static ChatState _instantiate(DecodingData data) {
    return ChatState(
        context: data.dec(_f$context),
        projectPath: data.dec(_f$projectPath),
        chatMessages: data.dec(_f$chatMessages),
        examples: data.dec(_f$examples),
        waitingResponse: data.dec(_f$waitingResponse));
  }

  @override
  final Function instantiate = _instantiate;

  static ChatState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ChatState>(map);
  }

  static ChatState fromJson(String json) {
    return ensureInitialized().decodeJson<ChatState>(json);
  }
}

mixin ChatStateMappable {
  String toJson() {
    return ChatStateMapper.ensureInitialized()
        .encodeJson<ChatState>(this as ChatState);
  }

  Map<String, dynamic> toMap() {
    return ChatStateMapper.ensureInitialized()
        .encodeMap<ChatState>(this as ChatState);
  }

  ChatStateCopyWith<ChatState, ChatState, ChatState> get copyWith =>
      _ChatStateCopyWithImpl(this as ChatState, $identity, $identity);
  @override
  String toString() {
    return ChatStateMapper.ensureInitialized()
        .stringifyValue(this as ChatState);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            ChatStateMapper.ensureInitialized()
                .isValueEqual(this as ChatState, other));
  }

  @override
  int get hashCode {
    return ChatStateMapper.ensureInitialized().hashValue(this as ChatState);
  }
}

extension ChatStateValueCopy<$R, $Out> on ObjectCopyWith<$R, ChatState, $Out> {
  ChatStateCopyWith<$R, ChatState, $Out> get $asChatState =>
      $base.as((v, t, t2) => _ChatStateCopyWithImpl(v, t, t2));
}

abstract class ChatStateCopyWith<$R, $In extends ChatState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, ChatMessage,
      ChatMessageCopyWith<$R, ChatMessage, ChatMessage>> get chatMessages;
  ListCopyWith<$R, ExampleChat,
      ExampleChatCopyWith<$R, ExampleChat, ExampleChat>> get examples;
  $R call(
      {String? context,
      String? projectPath,
      List<ChatMessage>? chatMessages,
      List<ExampleChat>? examples,
      bool? waitingResponse});
  ChatStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ChatStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ChatState, $Out>
    implements ChatStateCopyWith<$R, ChatState, $Out> {
  _ChatStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ChatState> $mapper =
      ChatStateMapper.ensureInitialized();
  @override
  ListCopyWith<$R, ChatMessage,
          ChatMessageCopyWith<$R, ChatMessage, ChatMessage>>
      get chatMessages => ListCopyWith($value.chatMessages,
          (v, t) => v.copyWith.$chain(t), (v) => call(chatMessages: v));
  @override
  ListCopyWith<$R, ExampleChat,
          ExampleChatCopyWith<$R, ExampleChat, ExampleChat>>
      get examples => ListCopyWith($value.examples,
          (v, t) => v.copyWith.$chain(t), (v) => call(examples: v));
  @override
  $R call(
          {Object? context = $none,
          Object? projectPath = $none,
          List<ChatMessage>? chatMessages,
          List<ExampleChat>? examples,
          bool? waitingResponse}) =>
      $apply(FieldCopyWithData({
        if (context != $none) #context: context,
        if (projectPath != $none) #projectPath: projectPath,
        if (chatMessages != null) #chatMessages: chatMessages,
        if (examples != null) #examples: examples,
        if (waitingResponse != null) #waitingResponse: waitingResponse
      }));
  @override
  ChatState $make(CopyWithData data) => ChatState(
      context: data.get(#context, or: $value.context),
      projectPath: data.get(#projectPath, or: $value.projectPath),
      chatMessages: data.get(#chatMessages, or: $value.chatMessages),
      examples: data.get(#examples, or: $value.examples),
      waitingResponse: data.get(#waitingResponse, or: $value.waitingResponse));

  @override
  ChatStateCopyWith<$R2, ChatState, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ChatStateCopyWithImpl($value, $cast, t);
}
