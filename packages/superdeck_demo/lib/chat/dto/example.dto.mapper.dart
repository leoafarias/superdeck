// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'example.dto.dart';

class ExampleChatMapper extends ClassMapperBase<ExampleChat> {
  ExampleChatMapper._();

  static ExampleChatMapper? _instance;
  static ExampleChatMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ExampleChatMapper._());
      ChatMessageMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ExampleChat';

  static ChatMessage _$input(ExampleChat v) => v.input;
  static const Field<ExampleChat, ChatMessage> _f$input =
      Field('input', _$input);
  static ChatMessage _$output(ExampleChat v) => v.output;
  static const Field<ExampleChat, ChatMessage> _f$output =
      Field('output', _$output);

  @override
  final Map<Symbol, Field<ExampleChat, dynamic>> fields = const {
    #input: _f$input,
    #output: _f$output,
  };

  static ExampleChat _instantiate(DecodingData data) {
    return ExampleChat(input: data.dec(_f$input), output: data.dec(_f$output));
  }

  @override
  final Function instantiate = _instantiate;

  static ExampleChat fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ExampleChat>(map);
  }

  static ExampleChat fromJson(String json) {
    return ensureInitialized().decodeJson<ExampleChat>(json);
  }
}

mixin ExampleChatMappable {
  String toJson() {
    return ExampleChatMapper.ensureInitialized()
        .encodeJson<ExampleChat>(this as ExampleChat);
  }

  Map<String, dynamic> toMap() {
    return ExampleChatMapper.ensureInitialized()
        .encodeMap<ExampleChat>(this as ExampleChat);
  }

  ExampleChatCopyWith<ExampleChat, ExampleChat, ExampleChat> get copyWith =>
      _ExampleChatCopyWithImpl(this as ExampleChat, $identity, $identity);
  @override
  String toString() {
    return ExampleChatMapper.ensureInitialized()
        .stringifyValue(this as ExampleChat);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            ExampleChatMapper.ensureInitialized()
                .isValueEqual(this as ExampleChat, other));
  }

  @override
  int get hashCode {
    return ExampleChatMapper.ensureInitialized().hashValue(this as ExampleChat);
  }
}

extension ExampleChatValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ExampleChat, $Out> {
  ExampleChatCopyWith<$R, ExampleChat, $Out> get $asExampleChat =>
      $base.as((v, t, t2) => _ExampleChatCopyWithImpl(v, t, t2));
}

abstract class ExampleChatCopyWith<$R, $In extends ExampleChat, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ChatMessageCopyWith<$R, ChatMessage, ChatMessage> get input;
  ChatMessageCopyWith<$R, ChatMessage, ChatMessage> get output;
  $R call({ChatMessage? input, ChatMessage? output});
  ExampleChatCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ExampleChatCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ExampleChat, $Out>
    implements ExampleChatCopyWith<$R, ExampleChat, $Out> {
  _ExampleChatCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ExampleChat> $mapper =
      ExampleChatMapper.ensureInitialized();
  @override
  ChatMessageCopyWith<$R, ChatMessage, ChatMessage> get input =>
      $value.input.copyWith.$chain((v) => call(input: v));
  @override
  ChatMessageCopyWith<$R, ChatMessage, ChatMessage> get output =>
      $value.output.copyWith.$chain((v) => call(output: v));
  @override
  $R call({ChatMessage? input, ChatMessage? output}) =>
      $apply(FieldCopyWithData({
        if (input != null) #input: input,
        if (output != null) #output: output
      }));
  @override
  ExampleChat $make(CopyWithData data) => ExampleChat(
      input: data.get(#input, or: $value.input),
      output: data.get(#output, or: $value.output));

  @override
  ExampleChatCopyWith<$R2, ExampleChat, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ExampleChatCopyWithImpl($value, $cast, t);
}
