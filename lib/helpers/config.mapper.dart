// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'config.dart';

class ConfigMapper extends ClassMapperBase<Config> {
  ConfigMapper._();

  static ConfigMapper? _instance;
  static ConfigMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ConfigMapper._());
      SDConfigMapper.ensureInitialized();
      TransitionOptionsMapper.ensureInitialized();
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
  static TransitionOptions? _$transition(Config v) => v.transition;
  static const Field<Config, TransitionOptions> _f$transition =
      Field('transition', _$transition);

  @override
  final MappableFields<Config> fields = const {
    #background: _f$background,
    #style: _f$style,
    #transition: _f$transition,
  };
  @override
  final bool ignoreNull = true;

  static Config _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('Config');
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
  String toJson();
  Map<String, dynamic> toMap();
  ConfigCopyWith<Config, Config, Config> get copyWith;
}

abstract class ConfigCopyWith<$R, $In extends Config, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  TransitionOptionsCopyWith<$R, TransitionOptions, TransitionOptions>?
      get transition;
  $R call({String? background, String? style, TransitionOptions? transition});
  ConfigCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class SDConfigMapper extends ClassMapperBase<SDConfig> {
  SDConfigMapper._();

  static SDConfigMapper? _instance;
  static SDConfigMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SDConfigMapper._());
      ConfigMapper.ensureInitialized();
      TransitionOptionsMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SDConfig';

  static String? _$background(SDConfig v) => v.background;
  static const Field<SDConfig, String> _f$background =
      Field('background', _$background);
  static String? _$style(SDConfig v) => v.style;
  static const Field<SDConfig, String> _f$style = Field('style', _$style);
  static TransitionOptions? _$transition(SDConfig v) => v.transition;
  static const Field<SDConfig, TransitionOptions> _f$transition =
      Field('transition', _$transition);
  static bool? _$cacheRemoteAssets(SDConfig v) => v.cacheRemoteAssets;
  static const Field<SDConfig, bool> _f$cacheRemoteAssets = Field(
      'cacheRemoteAssets', _$cacheRemoteAssets,
      key: 'cache_remote_assets', opt: true);

  @override
  final MappableFields<SDConfig> fields = const {
    #background: _f$background,
    #style: _f$style,
    #transition: _f$transition,
    #cacheRemoteAssets: _f$cacheRemoteAssets,
  };
  @override
  final bool ignoreNull = true;

  static SDConfig _instantiate(DecodingData data) {
    return SDConfig(
        background: data.dec(_f$background),
        style: data.dec(_f$style),
        transition: data.dec(_f$transition),
        cacheRemoteAssets: data.dec(_f$cacheRemoteAssets));
  }

  @override
  final Function instantiate = _instantiate;

  static SDConfig fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SDConfig>(map);
  }

  static SDConfig fromJson(String json) {
    return ensureInitialized().decodeJson<SDConfig>(json);
  }
}

mixin SDConfigMappable {
  String toJson() {
    return SDConfigMapper.ensureInitialized()
        .encodeJson<SDConfig>(this as SDConfig);
  }

  Map<String, dynamic> toMap() {
    return SDConfigMapper.ensureInitialized()
        .encodeMap<SDConfig>(this as SDConfig);
  }

  SDConfigCopyWith<SDConfig, SDConfig, SDConfig> get copyWith =>
      _SDConfigCopyWithImpl(this as SDConfig, $identity, $identity);
  @override
  String toString() {
    return SDConfigMapper.ensureInitialized().stringifyValue(this as SDConfig);
  }

  @override
  bool operator ==(Object other) {
    return SDConfigMapper.ensureInitialized()
        .equalsValue(this as SDConfig, other);
  }

  @override
  int get hashCode {
    return SDConfigMapper.ensureInitialized().hashValue(this as SDConfig);
  }
}

extension SDConfigValueCopy<$R, $Out> on ObjectCopyWith<$R, SDConfig, $Out> {
  SDConfigCopyWith<$R, SDConfig, $Out> get $asSDConfig =>
      $base.as((v, t, t2) => _SDConfigCopyWithImpl(v, t, t2));
}

abstract class SDConfigCopyWith<$R, $In extends SDConfig, $Out>
    implements ConfigCopyWith<$R, $In, $Out> {
  @override
  TransitionOptionsCopyWith<$R, TransitionOptions, TransitionOptions>?
      get transition;
  @override
  $R call(
      {String? background,
      String? style,
      TransitionOptions? transition,
      bool? cacheRemoteAssets});
  SDConfigCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SDConfigCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SDConfig, $Out>
    implements SDConfigCopyWith<$R, SDConfig, $Out> {
  _SDConfigCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SDConfig> $mapper =
      SDConfigMapper.ensureInitialized();
  @override
  TransitionOptionsCopyWith<$R, TransitionOptions, TransitionOptions>?
      get transition =>
          $value.transition?.copyWith.$chain((v) => call(transition: v));
  @override
  $R call(
          {Object? background = $none,
          Object? style = $none,
          Object? transition = $none,
          Object? cacheRemoteAssets = $none}) =>
      $apply(FieldCopyWithData({
        if (background != $none) #background: background,
        if (style != $none) #style: style,
        if (transition != $none) #transition: transition,
        if (cacheRemoteAssets != $none) #cacheRemoteAssets: cacheRemoteAssets
      }));
  @override
  SDConfig $make(CopyWithData data) => SDConfig(
      background: data.get(#background, or: $value.background),
      style: data.get(#style, or: $value.style),
      transition: data.get(#transition, or: $value.transition),
      cacheRemoteAssets:
          data.get(#cacheRemoteAssets, or: $value.cacheRemoteAssets));

  @override
  SDConfigCopyWith<$R2, SDConfig, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _SDConfigCopyWithImpl($value, $cast, t);
}
