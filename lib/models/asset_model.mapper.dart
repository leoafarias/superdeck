// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'asset_model.dart';

class SlideAssetMapper extends ClassMapperBase<SlideAsset> {
  SlideAssetMapper._();

  static SlideAssetMapper? _instance;
  static SlideAssetMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SlideAssetMapper._());
      MapperContainer.globals.useAll([Uint8ListMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'SlideAsset';

  static Uint8List _$bytes(SlideAsset v) => v.bytes;
  static const Field<SlideAsset, Uint8List> _f$bytes = Field('bytes', _$bytes);
  static double _$width(SlideAsset v) => v.width;
  static const Field<SlideAsset, double> _f$width = Field('width', _$width);
  static double _$height(SlideAsset v) => v.height;
  static const Field<SlideAsset, double> _f$height = Field('height', _$height);
  static String _$path(SlideAsset v) => v.path;
  static const Field<SlideAsset, String> _f$path = Field('path', _$path);

  @override
  final MappableFields<SlideAsset> fields = const {
    #bytes: _f$bytes,
    #width: _f$width,
    #height: _f$height,
    #path: _f$path,
  };
  @override
  final bool ignoreNull = true;

  static SlideAsset _instantiate(DecodingData data) {
    return SlideAsset(
        bytes: data.dec(_f$bytes),
        width: data.dec(_f$width),
        height: data.dec(_f$height),
        path: data.dec(_f$path));
  }

  @override
  final Function instantiate = _instantiate;

  static SlideAsset fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SlideAsset>(map);
  }

  static SlideAsset fromJson(String json) {
    return ensureInitialized().decodeJson<SlideAsset>(json);
  }
}

mixin SlideAssetMappable {
  String toJson() {
    return SlideAssetMapper.ensureInitialized()
        .encodeJson<SlideAsset>(this as SlideAsset);
  }

  Map<String, dynamic> toMap() {
    return SlideAssetMapper.ensureInitialized()
        .encodeMap<SlideAsset>(this as SlideAsset);
  }

  SlideAssetCopyWith<SlideAsset, SlideAsset, SlideAsset> get copyWith =>
      _SlideAssetCopyWithImpl(this as SlideAsset, $identity, $identity);
  @override
  String toString() {
    return SlideAssetMapper.ensureInitialized()
        .stringifyValue(this as SlideAsset);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            SlideAssetMapper.ensureInitialized()
                .isValueEqual(this as SlideAsset, other));
  }

  @override
  int get hashCode {
    return SlideAssetMapper.ensureInitialized().hashValue(this as SlideAsset);
  }
}

extension SlideAssetValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SlideAsset, $Out> {
  SlideAssetCopyWith<$R, SlideAsset, $Out> get $asSlideAsset =>
      $base.as((v, t, t2) => _SlideAssetCopyWithImpl(v, t, t2));
}

abstract class SlideAssetCopyWith<$R, $In extends SlideAsset, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({Uint8List? bytes, double? width, double? height, String? path});
  SlideAssetCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SlideAssetCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SlideAsset, $Out>
    implements SlideAssetCopyWith<$R, SlideAsset, $Out> {
  _SlideAssetCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SlideAsset> $mapper =
      SlideAssetMapper.ensureInitialized();
  @override
  $R call({Uint8List? bytes, double? width, double? height, String? path}) =>
      $apply(FieldCopyWithData({
        if (bytes != null) #bytes: bytes,
        if (width != null) #width: width,
        if (height != null) #height: height,
        if (path != null) #path: path
      }));
  @override
  SlideAsset $make(CopyWithData data) => SlideAsset(
      bytes: data.get(#bytes, or: $value.bytes),
      width: data.get(#width, or: $value.width),
      height: data.get(#height, or: $value.height),
      path: data.get(#path, or: $value.path));

  @override
  SlideAssetCopyWith<$R2, SlideAsset, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _SlideAssetCopyWithImpl($value, $cast, t);
}
