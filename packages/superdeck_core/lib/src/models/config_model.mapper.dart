// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'config_model.dart';

class SlideOptionsMapper extends ClassMapperBase<SlideOptions> {
  SlideOptionsMapper._();

  static SlideOptionsMapper? _instance;
  static SlideOptionsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SlideOptionsMapper._());
      ConfigMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SlideOptions';

  static String? _$title(SlideOptions v) => v.title;
  static const Field<SlideOptions, String> _f$title =
      Field('title', _$title, opt: true);
  static String? _$background(SlideOptions v) => v.background;
  static const Field<SlideOptions, String> _f$background =
      Field('background', _$background, opt: true);
  static String? _$style(SlideOptions v) => v.style;
  static const Field<SlideOptions, String> _f$style =
      Field('style', _$style, opt: true);
  static Map<String, Object?> _$args(SlideOptions v) => v.args;
  static const Field<SlideOptions, Map<String, Object?>> _f$args =
      Field('args', _$args, opt: true, def: const {});

  @override
  final MappableFields<SlideOptions> fields = const {
    #title: _f$title,
    #background: _f$background,
    #style: _f$style,
    #args: _f$args,
  };
  @override
  final bool ignoreNull = true;

  @override
  final MappingHook hook = const UnmappedPropertiesHook('args');
  static SlideOptions _instantiate(DecodingData data) {
    return SlideOptions(
        title: data.dec(_f$title),
        background: data.dec(_f$background),
        style: data.dec(_f$style),
        args: data.dec(_f$args));
  }

  @override
  final Function instantiate = _instantiate;

  static SlideOptions fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SlideOptions>(map);
  }

  static SlideOptions fromJson(String json) {
    return ensureInitialized().decodeJson<SlideOptions>(json);
  }
}

mixin SlideOptionsMappable {
  String toJson() {
    return SlideOptionsMapper.ensureInitialized()
        .encodeJson<SlideOptions>(this as SlideOptions);
  }

  Map<String, dynamic> toMap() {
    return SlideOptionsMapper.ensureInitialized()
        .encodeMap<SlideOptions>(this as SlideOptions);
  }

  SlideOptionsCopyWith<SlideOptions, SlideOptions, SlideOptions> get copyWith =>
      _SlideOptionsCopyWithImpl(this as SlideOptions, $identity, $identity);
  @override
  String toString() {
    return SlideOptionsMapper.ensureInitialized()
        .stringifyValue(this as SlideOptions);
  }

  @override
  bool operator ==(Object other) {
    return SlideOptionsMapper.ensureInitialized()
        .equalsValue(this as SlideOptions, other);
  }

  @override
  int get hashCode {
    return SlideOptionsMapper.ensureInitialized()
        .hashValue(this as SlideOptions);
  }
}

extension SlideOptionsValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SlideOptions, $Out> {
  SlideOptionsCopyWith<$R, SlideOptions, $Out> get $asSlideOptions =>
      $base.as((v, t, t2) => _SlideOptionsCopyWithImpl(v, t, t2));
}

abstract class SlideOptionsCopyWith<$R, $In extends SlideOptions, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? background, String? style});
  SlideOptionsCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SlideOptionsCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SlideOptions, $Out>
    implements SlideOptionsCopyWith<$R, SlideOptions, $Out> {
  _SlideOptionsCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SlideOptions> $mapper =
      SlideOptionsMapper.ensureInitialized();
  @override
  $R call({Object? background = $none, Object? style = $none}) =>
      $apply(FieldCopyWithData({
        if (background != $none) #background: background,
        if (style != $none) #style: style
      }));
  @override
  SlideOptions $make(CopyWithData data) => SlideOptions(
      title: data.get(#title, or: $value.title),
      background: data.get(#background, or: $value.background),
      style: data.get(#style, or: $value.style),
      args: data.get(#args, or: $value.args));

  @override
  SlideOptionsCopyWith<$R2, SlideOptions, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _SlideOptionsCopyWithImpl($value, $cast, t);
}

class ConfigMapper extends ClassMapperBase<Config> {
  ConfigMapper._();

  static ConfigMapper? _instance;
  static ConfigMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ConfigMapper._());
      SlideOptionsMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Config';

  static String? _$background(Config v) => v.background;
  static const Field<Config, String> _f$background =
      Field('background', _$background);
  static String? _$style(Config v) => v.style;
  static const Field<Config, String> _f$style = Field('style', _$style);
  static bool? _$cacheRemoteAssets(Config v) => v.cacheRemoteAssets;
  static const Field<Config, bool> _f$cacheRemoteAssets = Field(
      'cacheRemoteAssets', _$cacheRemoteAssets,
      key: 'cache_remote_assets', opt: true);
  static String? _$title(Config v) => v.title;
  static const Field<Config, String> _f$title =
      Field('title', _$title, mode: FieldMode.member);
  static Map<String, Object?> _$args(Config v) => v.args;
  static const Field<Config, Map<String, Object?>> _f$args =
      Field('args', _$args, mode: FieldMode.member);

  @override
  final MappableFields<Config> fields = const {
    #background: _f$background,
    #style: _f$style,
    #cacheRemoteAssets: _f$cacheRemoteAssets,
    #title: _f$title,
    #args: _f$args,
  };
  @override
  final bool ignoreNull = true;

  @override
  final MappingHook superHook = const UnmappedPropertiesHook('args');

  static Config _instantiate(DecodingData data) {
    return Config(
        background: data.dec(_f$background),
        style: data.dec(_f$style),
        cacheRemoteAssets: data.dec(_f$cacheRemoteAssets));
  }

  @override
  final Function instantiate = _instantiate;

  static Config fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Config>(map);
  }

  static Config fromJson(String json) {
    return ensureInitialized().decodeJson<Config>(json);
  }
}

mixin ConfigMappable {
  String toJson() {
    return ConfigMapper.ensureInitialized().encodeJson<Config>(this as Config);
  }

  Map<String, dynamic> toMap() {
    return ConfigMapper.ensureInitialized().encodeMap<Config>(this as Config);
  }

  ConfigCopyWith<Config, Config, Config> get copyWith =>
      _ConfigCopyWithImpl(this as Config, $identity, $identity);
  @override
  String toString() {
    return ConfigMapper.ensureInitialized().stringifyValue(this as Config);
  }

  @override
  bool operator ==(Object other) {
    return ConfigMapper.ensureInitialized().equalsValue(this as Config, other);
  }

  @override
  int get hashCode {
    return ConfigMapper.ensureInitialized().hashValue(this as Config);
  }
}

extension ConfigValueCopy<$R, $Out> on ObjectCopyWith<$R, Config, $Out> {
  ConfigCopyWith<$R, Config, $Out> get $asConfig =>
      $base.as((v, t, t2) => _ConfigCopyWithImpl(v, t, t2));
}

abstract class ConfigCopyWith<$R, $In extends Config, $Out>
    implements SlideOptionsCopyWith<$R, $In, $Out> {
  @override
  $R call({String? background, String? style, bool? cacheRemoteAssets});
  ConfigCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ConfigCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Config, $Out>
    implements ConfigCopyWith<$R, Config, $Out> {
  _ConfigCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Config> $mapper = ConfigMapper.ensureInitialized();
  @override
  $R call(
          {Object? background = $none,
          Object? style = $none,
          Object? cacheRemoteAssets = $none}) =>
      $apply(FieldCopyWithData({
        if (background != $none) #background: background,
        if (style != $none) #style: style,
        if (cacheRemoteAssets != $none) #cacheRemoteAssets: cacheRemoteAssets
      }));
  @override
  Config $make(CopyWithData data) => Config(
      background: data.get(#background, or: $value.background),
      style: data.get(#style, or: $value.style),
      cacheRemoteAssets:
          data.get(#cacheRemoteAssets, or: $value.cacheRemoteAssets));

  @override
  ConfigCopyWith<$R2, Config, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ConfigCopyWithImpl($value, $cast, t);
}
