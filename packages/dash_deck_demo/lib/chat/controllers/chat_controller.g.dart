// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$waitingResponseHash() => r'886a191df801d5de13dda015bf6c847603a65803';

/// See also [waitingResponse].
@ProviderFor(waitingResponse)
final waitingResponseProvider = AutoDisposeProvider<bool>.internal(
  waitingResponse,
  name: r'waitingResponseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$waitingResponseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef WaitingResponseRef = AutoDisposeProviderRef<bool>;
String _$messagesHash() => r'42e5a578f31634f2cedc3b9085b96e57b85ae9e6';

/// See also [messages].
@ProviderFor(messages)
final messagesProvider = AutoDisposeProvider<List<ChatMessage>>.internal(
  messages,
  name: r'messagesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$messagesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef MessagesRef = AutoDisposeProviderRef<List<ChatMessage>>;
String _$chatControllerHash() => r'2a759da7be1601045d48221cc1da67653d66858a';

/// See also [ChatController].
@ProviderFor(ChatController)
final chatControllerProvider =
    AutoDisposeNotifierProvider<ChatController, ChatState>.internal(
  ChatController.new,
  name: r'chatControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$chatControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ChatController = AutoDisposeNotifier<ChatState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
