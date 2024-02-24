import 'package:dart_mappable/dart_mappable.dart';

import 'chat_message.dto.dart';

part 'example.dto.mapper.dart';

@MappableClass()
class ExampleChat with ExampleChatMappable {
  final ChatMessage input;
  final ChatMessage output;

  const ExampleChat({
    required this.input,
    required this.output,
  });

  static const fromMap = ExampleChatMapper.fromMap;
  static const fromJson = ExampleChatMapper.fromJson;
}
