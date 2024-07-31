// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'config_model.dart';

class BaseConfigMapper extends ClassMapperBase<BaseConfig> {
  BaseConfigMapper._();

  static BaseConfigMapper? _instance;
  static BaseConfigMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BaseConfigMapper._());
      ConfigMapper.ensureInitialized();
      TransitionOptionsMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'BaseConfig';

  static String? _$background(BaseConfig v) => v.background;
  static const Field<BaseConfig, String> _f$background =
      Field('background', _$background);
  static String? _$style(BaseConfig v) => v.style;
  static const Field<BaseConfig, String> _f$style = Field('style', _$style);
  static TransitionOptions? _$transition(BaseConfig v) => v.transition;
  static const Field<BaseConfig, TransitionOptions> _f$transition =
      Field('transition', _$transition);

  @override
  final MappableFields<BaseConfig> fields = const {
    #background: _f$background,
    #style: _f$style,
    #transition: _f$transition,
  };
  @override
  final bool ignoreNull = true;

  static BaseConfig _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('BaseConfig');
  }

  @override
  final Function instantiate = _instantiate;

  static BaseConfig fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BaseConfig>(map);
  }

  static BaseConfig fromJson(String json) {
    return ensureInitialized().decodeJson<BaseConfig>(json);
  }
}

mixin BaseConfigMappable {
  String toJson();
  Map<String, dynamic> toMap();
  BaseConfigCopyWith<BaseConfig, BaseConfig, BaseConfig> get copyWith;
}

abstract class BaseConfigCopyWith<$R, $In extends BaseConfig, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  TransitionOptionsCopyWith<$R, TransitionOptions, TransitionOptions>?
      get transition;
  $R call({String? background, String? style, TransitionOptions? transition});
  BaseConfigCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class ConfigMapper extends ClassMapperBase<Config> {
  ConfigMapper._();

  static ConfigMapper? _instance;
  static ConfigMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ConfigMapper._());
      BaseConfigMapper.ensureInitialized();
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
  static bool? _$cacheRemoteAssets(Config v) => v.cacheRemoteAssets;
  static const Field<Config, bool> _f$cacheRemoteAssets = Field(
      'cacheRemoteAssets', _$cacheRemoteAssets,
      key: 'cache_remote_assets', opt: true);

  @override
  final MappableFields<Config> fields = const {
    #background: _f$background,
    #style: _f$style,
    #transition: _f$transition,
    #cacheRemoteAssets: _f$cacheRemoteAssets,
  };
  @override
  final bool ignoreNull = true;

  static Config _instantiate(DecodingData data) {
    return Config(
        background: data.dec(_f$background),
        style: data.dec(_f$style),
        transition: data.dec(_f$transition),
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
    implements BaseConfigCopyWith<$R, $In, $Out> {
  @override
  TransitionOptionsCopyWith<$R, TransitionOptions, TransitionOptions>?
      get transition;
  @override
  $R call(
      {String? background,
      String? style,
      TransitionOptions? transition,
      bool? cacheRemoteAssets});
  ConfigCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ConfigCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Config, $Out>
    implements ConfigCopyWith<$R, Config, $Out> {
  _ConfigCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Config> $mapper = ConfigMapper.ensureInitialized();
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
  Config $make(CopyWithData data) => Config(
      background: data.get(#background, or: $value.background),
      style: data.get(#style, or: $value.style),
      transition: data.get(#transition, or: $value.transition),
      cacheRemoteAssets:
          data.get(#cacheRemoteAssets, or: $value.cacheRemoteAssets));

  @override
  ConfigCopyWith<$R2, Config, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ConfigCopyWithImpl($value, $cast, t);
}
