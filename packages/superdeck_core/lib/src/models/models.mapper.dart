// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'models.dart';

class SlideAssetMapper extends ClassMapperBase<SlideAsset> {
  SlideAssetMapper._();

  static SlideAssetMapper? _instance;
  static SlideAssetMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SlideAssetMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'SlideAsset';

  static String _$path(SlideAsset v) => v.path;
  static const Field<SlideAsset, String> _f$path = Field('path', _$path);
  static int _$width(SlideAsset v) => v.width;
  static const Field<SlideAsset, int> _f$width = Field('width', _$width);
  static int _$height(SlideAsset v) => v.height;
  static const Field<SlideAsset, int> _f$height = Field('height', _$height);
  static String? _$reference(SlideAsset v) => v.reference;
  static const Field<SlideAsset, String> _f$reference =
      Field('reference', _$reference);

  @override
  final MappableFields<SlideAsset> fields = const {
    #path: _f$path,
    #width: _f$width,
    #height: _f$height,
    #reference: _f$reference,
  };
  @override
  final bool ignoreNull = true;

  static SlideAsset _instantiate(DecodingData data) {
    return SlideAsset(
        path: data.dec(_f$path),
        width: data.dec(_f$width),
        height: data.dec(_f$height),
        reference: data.dec(_f$reference));
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
    return SlideAssetMapper.ensureInitialized()
        .equalsValue(this as SlideAsset, other);
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
  $R call({String? path, int? width, int? height, String? reference});
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
  $R call({String? path, int? width, int? height, Object? reference = $none}) =>
      $apply(FieldCopyWithData({
        if (path != null) #path: path,
        if (width != null) #width: width,
        if (height != null) #height: height,
        if (reference != $none) #reference: reference
      }));
  @override
  SlideAsset $make(CopyWithData data) => SlideAsset(
      path: data.get(#path, or: $value.path),
      width: data.get(#width, or: $value.width),
      height: data.get(#height, or: $value.height),
      reference: data.get(#reference, or: $value.reference));

  @override
  SlideAssetCopyWith<$R2, SlideAsset, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _SlideAssetCopyWithImpl($value, $cast, t);
}

class BlockTypeMapper extends EnumMapper<BlockType> {
  BlockTypeMapper._();

  static BlockTypeMapper? _instance;
  static BlockTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BlockTypeMapper._());
    }
    return _instance!;
  }

  static BlockType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  BlockType decode(dynamic value) {
    switch (value) {
      case 'section':
        return BlockType.section;
      case 'column':
        return BlockType.column;
      case 'image':
        return BlockType.image;
      case 'widget':
        return BlockType.widget;
      case 'dartpad':
        return BlockType.dartpad;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(BlockType self) {
    switch (self) {
      case BlockType.section:
        return 'section';
      case BlockType.column:
        return 'column';
      case BlockType.image:
        return 'image';
      case BlockType.widget:
        return 'widget';
      case BlockType.dartpad:
        return 'dartpad';
    }
  }
}

extension BlockTypeMapperExtension on BlockType {
  String toValue() {
    BlockTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<BlockType>(this) as String;
  }
}

class DartPadThemeMapper extends EnumMapper<DartPadTheme> {
  DartPadThemeMapper._();

  static DartPadThemeMapper? _instance;
  static DartPadThemeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DartPadThemeMapper._());
    }
    return _instance!;
  }

  static DartPadTheme fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  DartPadTheme decode(dynamic value) {
    switch (value) {
      case 'dark':
        return DartPadTheme.dark;
      case 'light':
        return DartPadTheme.light;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(DartPadTheme self) {
    switch (self) {
      case DartPadTheme.dark:
        return 'dark';
      case DartPadTheme.light:
        return 'light';
    }
  }
}

extension DartPadThemeMapperExtension on DartPadTheme {
  String toValue() {
    DartPadThemeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<DartPadTheme>(this) as String;
  }
}

class ImageFitMapper extends EnumMapper<ImageFit> {
  ImageFitMapper._();

  static ImageFitMapper? _instance;
  static ImageFitMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ImageFitMapper._());
    }
    return _instance!;
  }

  static ImageFit fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  ImageFit decode(dynamic value) {
    switch (value) {
      case 'fill':
        return ImageFit.fill;
      case 'contain':
        return ImageFit.contain;
      case 'cover':
        return ImageFit.cover;
      case 'fit_width':
        return ImageFit.fitWidth;
      case 'fit_height':
        return ImageFit.fitHeight;
      case 'none':
        return ImageFit.none;
      case 'scale_down':
        return ImageFit.scaleDown;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(ImageFit self) {
    switch (self) {
      case ImageFit.fill:
        return 'fill';
      case ImageFit.contain:
        return 'contain';
      case ImageFit.cover:
        return 'cover';
      case ImageFit.fitWidth:
        return 'fit_width';
      case ImageFit.fitHeight:
        return 'fit_height';
      case ImageFit.none:
        return 'none';
      case ImageFit.scaleDown:
        return 'scale_down';
    }
  }
}

extension ImageFitMapperExtension on ImageFit {
  String toValue() {
    ImageFitMapper.ensureInitialized();
    return MapperContainer.globals.toValue<ImageFit>(this) as String;
  }
}

class ContentAlignmentMapper extends EnumMapper<ContentAlignment> {
  ContentAlignmentMapper._();

  static ContentAlignmentMapper? _instance;
  static ContentAlignmentMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ContentAlignmentMapper._());
    }
    return _instance!;
  }

  static ContentAlignment fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  ContentAlignment decode(dynamic value) {
    switch (value) {
      case 'top_left':
        return ContentAlignment.topLeft;
      case 'top_center':
        return ContentAlignment.topCenter;
      case 'top_right':
        return ContentAlignment.topRight;
      case 'center_left':
        return ContentAlignment.centerLeft;
      case 'center':
        return ContentAlignment.center;
      case 'center_right':
        return ContentAlignment.centerRight;
      case 'bottom_left':
        return ContentAlignment.bottomLeft;
      case 'bottom_center':
        return ContentAlignment.bottomCenter;
      case 'bottom_right':
        return ContentAlignment.bottomRight;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(ContentAlignment self) {
    switch (self) {
      case ContentAlignment.topLeft:
        return 'top_left';
      case ContentAlignment.topCenter:
        return 'top_center';
      case ContentAlignment.topRight:
        return 'top_right';
      case ContentAlignment.centerLeft:
        return 'center_left';
      case ContentAlignment.center:
        return 'center';
      case ContentAlignment.centerRight:
        return 'center_right';
      case ContentAlignment.bottomLeft:
        return 'bottom_left';
      case ContentAlignment.bottomCenter:
        return 'bottom_center';
      case ContentAlignment.bottomRight:
        return 'bottom_right';
    }
  }
}

extension ContentAlignmentMapperExtension on ContentAlignment {
  String toValue() {
    ContentAlignmentMapper.ensureInitialized();
    return MapperContainer.globals.toValue<ContentAlignment>(this) as String;
  }
}

class BlockMapper extends ClassMapperBase<Block> {
  BlockMapper._();

  static BlockMapper? _instance;
  static BlockMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BlockMapper._());
      SectionBlockMapper.ensureInitialized();
      ContentBlockMapper.ensureInitialized();
      ContentAlignmentMapper.ensureInitialized();
      BlockTypeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Block';

  static int? _$flex(Block v) => v.flex;
  static const Field<Block, int> _f$flex = Field('flex', _$flex, opt: true);
  static ContentAlignment? _$align(Block v) => v.align;
  static const Field<Block, ContentAlignment> _f$align =
      Field('align', _$align, opt: true);
  static String? _$tag(Block v) => v.tag;
  static const Field<Block, String> _f$tag = Field('tag', _$tag, opt: true);
  static BlockType _$type(Block v) => v.type;
  static const Field<Block, BlockType> _f$type = Field('type', _$type);

  @override
  final MappableFields<Block> fields = const {
    #flex: _f$flex,
    #align: _f$align,
    #tag: _f$tag,
    #type: _f$type,
  };
  @override
  final bool ignoreNull = true;

  static Block _instantiate(DecodingData data) {
    throw MapperException.missingSubclass(
        'Block', 'type', '${data.value['type']}');
  }

  @override
  final Function instantiate = _instantiate;

  static Block fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Block>(map);
  }

  static Block fromJson(String json) {
    return ensureInitialized().decodeJson<Block>(json);
  }
}

mixin BlockMappable {
  String toJson();
  Map<String, dynamic> toMap();
  BlockCopyWith<Block, Block, Block> get copyWith;
}

abstract class BlockCopyWith<$R, $In extends Block, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({int? flex, ContentAlignment? align, String? tag});
  BlockCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class SectionBlockMapper extends SubClassMapperBase<SectionBlock> {
  SectionBlockMapper._();

  static SectionBlockMapper? _instance;
  static SectionBlockMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SectionBlockMapper._());
      BlockMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals.useAll([NullIfEmptyBlock()]);
      ContentBlockMapper.ensureInitialized();
      ContentAlignmentMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SectionBlock';

  static List<ContentBlock> _$blocks(SectionBlock v) => v.blocks;
  static const Field<SectionBlock, List<ContentBlock>> _f$blocks =
      Field('blocks', _$blocks, opt: true, def: const []);
  static int? _$flex(SectionBlock v) => v.flex;
  static const Field<SectionBlock, int> _f$flex =
      Field('flex', _$flex, opt: true);
  static ContentAlignment? _$align(SectionBlock v) => v.align;
  static const Field<SectionBlock, ContentAlignment> _f$align =
      Field('align', _$align, opt: true);
  static String? _$tag(SectionBlock v) => v.tag;
  static const Field<SectionBlock, String> _f$tag =
      Field('tag', _$tag, opt: true);
  static BlockType _$type(SectionBlock v) => v.type;
  static const Field<SectionBlock, BlockType> _f$type =
      Field('type', _$type, mode: FieldMode.member);

  @override
  final MappableFields<SectionBlock> fields = const {
    #blocks: _f$blocks,
    #flex: _f$flex,
    #align: _f$align,
    #tag: _f$tag,
    #type: _f$type,
  };
  @override
  final bool ignoreNull = true;

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'SectionBlock';
  @override
  late final ClassMapperBase superMapper = BlockMapper.ensureInitialized();

  static SectionBlock _instantiate(DecodingData data) {
    return SectionBlock(
        blocks: data.dec(_f$blocks),
        flex: data.dec(_f$flex),
        align: data.dec(_f$align),
        tag: data.dec(_f$tag));
  }

  @override
  final Function instantiate = _instantiate;

  static SectionBlock fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SectionBlock>(map);
  }

  static SectionBlock fromJson(String json) {
    return ensureInitialized().decodeJson<SectionBlock>(json);
  }
}

mixin SectionBlockMappable {
  String toJson() {
    return SectionBlockMapper.ensureInitialized()
        .encodeJson<SectionBlock>(this as SectionBlock);
  }

  Map<String, dynamic> toMap() {
    return SectionBlockMapper.ensureInitialized()
        .encodeMap<SectionBlock>(this as SectionBlock);
  }

  SectionBlockCopyWith<SectionBlock, SectionBlock, SectionBlock> get copyWith =>
      _SectionBlockCopyWithImpl(this as SectionBlock, $identity, $identity);
  @override
  String toString() {
    return SectionBlockMapper.ensureInitialized()
        .stringifyValue(this as SectionBlock);
  }

  @override
  bool operator ==(Object other) {
    return SectionBlockMapper.ensureInitialized()
        .equalsValue(this as SectionBlock, other);
  }

  @override
  int get hashCode {
    return SectionBlockMapper.ensureInitialized()
        .hashValue(this as SectionBlock);
  }
}

extension SectionBlockValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SectionBlock, $Out> {
  SectionBlockCopyWith<$R, SectionBlock, $Out> get $asSectionBlock =>
      $base.as((v, t, t2) => _SectionBlockCopyWithImpl(v, t, t2));
}

abstract class SectionBlockCopyWith<$R, $In extends SectionBlock, $Out>
    implements BlockCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, ContentBlock,
      ContentBlockCopyWith<$R, ContentBlock, ContentBlock>> get blocks;
  @override
  $R call(
      {List<ContentBlock>? blocks,
      int? flex,
      ContentAlignment? align,
      String? tag});
  SectionBlockCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SectionBlockCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SectionBlock, $Out>
    implements SectionBlockCopyWith<$R, SectionBlock, $Out> {
  _SectionBlockCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SectionBlock> $mapper =
      SectionBlockMapper.ensureInitialized();
  @override
  ListCopyWith<$R, ContentBlock,
          ContentBlockCopyWith<$R, ContentBlock, ContentBlock>>
      get blocks => ListCopyWith($value.blocks, (v, t) => v.copyWith.$chain(t),
          (v) => call(blocks: v));
  @override
  $R call(
          {List<ContentBlock>? blocks,
          Object? flex = $none,
          Object? align = $none,
          Object? tag = $none}) =>
      $apply(FieldCopyWithData({
        if (blocks != null) #blocks: blocks,
        if (flex != $none) #flex: flex,
        if (align != $none) #align: align,
        if (tag != $none) #tag: tag
      }));
  @override
  SectionBlock $make(CopyWithData data) => SectionBlock(
      blocks: data.get(#blocks, or: $value.blocks),
      flex: data.get(#flex, or: $value.flex),
      align: data.get(#align, or: $value.align),
      tag: data.get(#tag, or: $value.tag));

  @override
  SectionBlockCopyWith<$R2, SectionBlock, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _SectionBlockCopyWithImpl($value, $cast, t);
}

class ContentBlockMapper extends SubClassMapperBase<ContentBlock> {
  ContentBlockMapper._();

  static ContentBlockMapper? _instance;
  static ContentBlockMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ContentBlockMapper._());
      BlockMapper.ensureInitialized().addSubMapper(_instance!);
      ColumnBlockMapper.ensureInitialized();
      ImageBlockMapper.ensureInitialized();
      WidgetBlockMapper.ensureInitialized();
      DartPadBlockMapper.ensureInitialized();
      ContentAlignmentMapper.ensureInitialized();
      BlockTypeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ContentBlock';

  static String _$content(ContentBlock v) => v.content;
  static const Field<ContentBlock, String> _f$content =
      Field('content', _$content, opt: true, def: '');
  static int? _$flex(ContentBlock v) => v.flex;
  static const Field<ContentBlock, int> _f$flex =
      Field('flex', _$flex, opt: true);
  static ContentAlignment? _$align(ContentBlock v) => v.align;
  static const Field<ContentBlock, ContentAlignment> _f$align =
      Field('align', _$align, opt: true);
  static String? _$tag(ContentBlock v) => v.tag;
  static const Field<ContentBlock, String> _f$tag =
      Field('tag', _$tag, opt: true);
  static BlockType _$type(ContentBlock v) => v.type;
  static const Field<ContentBlock, BlockType> _f$type = Field('type', _$type);

  @override
  final MappableFields<ContentBlock> fields = const {
    #content: _f$content,
    #flex: _f$flex,
    #align: _f$align,
    #tag: _f$tag,
    #type: _f$type,
  };
  @override
  final bool ignoreNull = true;

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'ContentBlock';
  @override
  late final ClassMapperBase superMapper = BlockMapper.ensureInitialized();

  static ContentBlock _instantiate(DecodingData data) {
    throw MapperException.missingSubclass(
        'ContentBlock', 'type', '${data.value['type']}');
  }

  @override
  final Function instantiate = _instantiate;

  static ContentBlock fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ContentBlock>(map);
  }

  static ContentBlock fromJson(String json) {
    return ensureInitialized().decodeJson<ContentBlock>(json);
  }
}

mixin ContentBlockMappable {
  String toJson();
  Map<String, dynamic> toMap();
  ContentBlockCopyWith<ContentBlock, ContentBlock, ContentBlock> get copyWith;
}

abstract class ContentBlockCopyWith<$R, $In extends ContentBlock, $Out>
    implements BlockCopyWith<$R, $In, $Out> {
  @override
  $R call({String? content, int? flex, ContentAlignment? align, String? tag});
  ContentBlockCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class ColumnBlockMapper extends SubClassMapperBase<ColumnBlock> {
  ColumnBlockMapper._();

  static ColumnBlockMapper? _instance;
  static ColumnBlockMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ColumnBlockMapper._());
      ContentBlockMapper.ensureInitialized().addSubMapper(_instance!);
      ContentAlignmentMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ColumnBlock';

  static int? _$flex(ColumnBlock v) => v.flex;
  static const Field<ColumnBlock, int> _f$flex =
      Field('flex', _$flex, opt: true);
  static ContentAlignment? _$align(ColumnBlock v) => v.align;
  static const Field<ColumnBlock, ContentAlignment> _f$align =
      Field('align', _$align, opt: true);
  static String? _$tag(ColumnBlock v) => v.tag;
  static const Field<ColumnBlock, String> _f$tag =
      Field('tag', _$tag, opt: true);
  static String _$content(ColumnBlock v) => v.content;
  static const Field<ColumnBlock, String> _f$content =
      Field('content', _$content, opt: true, def: '');
  static BlockType _$type(ColumnBlock v) => v.type;
  static const Field<ColumnBlock, BlockType> _f$type =
      Field('type', _$type, mode: FieldMode.member);

  @override
  final MappableFields<ColumnBlock> fields = const {
    #flex: _f$flex,
    #align: _f$align,
    #tag: _f$tag,
    #content: _f$content,
    #type: _f$type,
  };
  @override
  final bool ignoreNull = true;

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'column';
  @override
  late final ClassMapperBase superMapper =
      ContentBlockMapper.ensureInitialized();

  static ColumnBlock _instantiate(DecodingData data) {
    return ColumnBlock(
        flex: data.dec(_f$flex),
        align: data.dec(_f$align),
        tag: data.dec(_f$tag),
        content: data.dec(_f$content));
  }

  @override
  final Function instantiate = _instantiate;

  static ColumnBlock fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ColumnBlock>(map);
  }

  static ColumnBlock fromJson(String json) {
    return ensureInitialized().decodeJson<ColumnBlock>(json);
  }
}

mixin ColumnBlockMappable {
  String toJson() {
    return ColumnBlockMapper.ensureInitialized()
        .encodeJson<ColumnBlock>(this as ColumnBlock);
  }

  Map<String, dynamic> toMap() {
    return ColumnBlockMapper.ensureInitialized()
        .encodeMap<ColumnBlock>(this as ColumnBlock);
  }

  ColumnBlockCopyWith<ColumnBlock, ColumnBlock, ColumnBlock> get copyWith =>
      _ColumnBlockCopyWithImpl(this as ColumnBlock, $identity, $identity);
  @override
  String toString() {
    return ColumnBlockMapper.ensureInitialized()
        .stringifyValue(this as ColumnBlock);
  }

  @override
  bool operator ==(Object other) {
    return ColumnBlockMapper.ensureInitialized()
        .equalsValue(this as ColumnBlock, other);
  }

  @override
  int get hashCode {
    return ColumnBlockMapper.ensureInitialized().hashValue(this as ColumnBlock);
  }
}

extension ColumnBlockValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ColumnBlock, $Out> {
  ColumnBlockCopyWith<$R, ColumnBlock, $Out> get $asColumnBlock =>
      $base.as((v, t, t2) => _ColumnBlockCopyWithImpl(v, t, t2));
}

abstract class ColumnBlockCopyWith<$R, $In extends ColumnBlock, $Out>
    implements ContentBlockCopyWith<$R, $In, $Out> {
  @override
  $R call({int? flex, ContentAlignment? align, String? tag, String? content});
  ColumnBlockCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ColumnBlockCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ColumnBlock, $Out>
    implements ColumnBlockCopyWith<$R, ColumnBlock, $Out> {
  _ColumnBlockCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ColumnBlock> $mapper =
      ColumnBlockMapper.ensureInitialized();
  @override
  $R call(
          {Object? flex = $none,
          Object? align = $none,
          Object? tag = $none,
          String? content}) =>
      $apply(FieldCopyWithData({
        if (flex != $none) #flex: flex,
        if (align != $none) #align: align,
        if (tag != $none) #tag: tag,
        if (content != null) #content: content
      }));
  @override
  ColumnBlock $make(CopyWithData data) => ColumnBlock(
      flex: data.get(#flex, or: $value.flex),
      align: data.get(#align, or: $value.align),
      tag: data.get(#tag, or: $value.tag),
      content: data.get(#content, or: $value.content));

  @override
  ColumnBlockCopyWith<$R2, ColumnBlock, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ColumnBlockCopyWithImpl($value, $cast, t);
}

class ImageBlockMapper extends SubClassMapperBase<ImageBlock> {
  ImageBlockMapper._();

  static ImageBlockMapper? _instance;
  static ImageBlockMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ImageBlockMapper._());
      ContentBlockMapper.ensureInitialized().addSubMapper(_instance!);
      ImageFitMapper.ensureInitialized();
      ContentAlignmentMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ImageBlock';

  static String _$src(ImageBlock v) => v.src;
  static const Field<ImageBlock, String> _f$src = Field('src', _$src);
  static ImageFit? _$fit(ImageBlock v) => v.fit;
  static const Field<ImageBlock, ImageFit> _f$fit =
      Field('fit', _$fit, opt: true);
  static int? _$flex(ImageBlock v) => v.flex;
  static const Field<ImageBlock, int> _f$flex =
      Field('flex', _$flex, opt: true);
  static ContentAlignment? _$align(ImageBlock v) => v.align;
  static const Field<ImageBlock, ContentAlignment> _f$align =
      Field('align', _$align, opt: true);
  static String? _$tag(ImageBlock v) => v.tag;
  static const Field<ImageBlock, String> _f$tag =
      Field('tag', _$tag, opt: true);
  static String _$content(ImageBlock v) => v.content;
  static const Field<ImageBlock, String> _f$content =
      Field('content', _$content, opt: true, def: '');
  static BlockType _$type(ImageBlock v) => v.type;
  static const Field<ImageBlock, BlockType> _f$type =
      Field('type', _$type, mode: FieldMode.member);

  @override
  final MappableFields<ImageBlock> fields = const {
    #src: _f$src,
    #fit: _f$fit,
    #flex: _f$flex,
    #align: _f$align,
    #tag: _f$tag,
    #content: _f$content,
    #type: _f$type,
  };
  @override
  final bool ignoreNull = true;

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'image';
  @override
  late final ClassMapperBase superMapper =
      ContentBlockMapper.ensureInitialized();

  static ImageBlock _instantiate(DecodingData data) {
    return ImageBlock(
        src: data.dec(_f$src),
        fit: data.dec(_f$fit),
        flex: data.dec(_f$flex),
        align: data.dec(_f$align),
        tag: data.dec(_f$tag),
        content: data.dec(_f$content));
  }

  @override
  final Function instantiate = _instantiate;

  static ImageBlock fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ImageBlock>(map);
  }

  static ImageBlock fromJson(String json) {
    return ensureInitialized().decodeJson<ImageBlock>(json);
  }
}

mixin ImageBlockMappable {
  String toJson() {
    return ImageBlockMapper.ensureInitialized()
        .encodeJson<ImageBlock>(this as ImageBlock);
  }

  Map<String, dynamic> toMap() {
    return ImageBlockMapper.ensureInitialized()
        .encodeMap<ImageBlock>(this as ImageBlock);
  }

  ImageBlockCopyWith<ImageBlock, ImageBlock, ImageBlock> get copyWith =>
      _ImageBlockCopyWithImpl(this as ImageBlock, $identity, $identity);
  @override
  String toString() {
    return ImageBlockMapper.ensureInitialized()
        .stringifyValue(this as ImageBlock);
  }

  @override
  bool operator ==(Object other) {
    return ImageBlockMapper.ensureInitialized()
        .equalsValue(this as ImageBlock, other);
  }

  @override
  int get hashCode {
    return ImageBlockMapper.ensureInitialized().hashValue(this as ImageBlock);
  }
}

extension ImageBlockValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ImageBlock, $Out> {
  ImageBlockCopyWith<$R, ImageBlock, $Out> get $asImageBlock =>
      $base.as((v, t, t2) => _ImageBlockCopyWithImpl(v, t, t2));
}

abstract class ImageBlockCopyWith<$R, $In extends ImageBlock, $Out>
    implements ContentBlockCopyWith<$R, $In, $Out> {
  @override
  $R call(
      {String? src,
      ImageFit? fit,
      int? flex,
      ContentAlignment? align,
      String? tag,
      String? content});
  ImageBlockCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ImageBlockCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ImageBlock, $Out>
    implements ImageBlockCopyWith<$R, ImageBlock, $Out> {
  _ImageBlockCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ImageBlock> $mapper =
      ImageBlockMapper.ensureInitialized();
  @override
  $R call(
          {String? src,
          Object? fit = $none,
          Object? flex = $none,
          Object? align = $none,
          Object? tag = $none,
          String? content}) =>
      $apply(FieldCopyWithData({
        if (src != null) #src: src,
        if (fit != $none) #fit: fit,
        if (flex != $none) #flex: flex,
        if (align != $none) #align: align,
        if (tag != $none) #tag: tag,
        if (content != null) #content: content
      }));
  @override
  ImageBlock $make(CopyWithData data) => ImageBlock(
      src: data.get(#src, or: $value.src),
      fit: data.get(#fit, or: $value.fit),
      flex: data.get(#flex, or: $value.flex),
      align: data.get(#align, or: $value.align),
      tag: data.get(#tag, or: $value.tag),
      content: data.get(#content, or: $value.content));

  @override
  ImageBlockCopyWith<$R2, ImageBlock, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ImageBlockCopyWithImpl($value, $cast, t);
}

class WidgetBlockMapper extends SubClassMapperBase<WidgetBlock> {
  WidgetBlockMapper._();

  static WidgetBlockMapper? _instance;
  static WidgetBlockMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WidgetBlockMapper._());
      ContentBlockMapper.ensureInitialized().addSubMapper(_instance!);
      ContentAlignmentMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'WidgetBlock';

  static String _$name(WidgetBlock v) => v.name;
  static const Field<WidgetBlock, String> _f$name = Field('name', _$name);
  static Map<String, dynamic> _$args(WidgetBlock v) => v.args;
  static const Field<WidgetBlock, Map<String, dynamic>> _f$args =
      Field('args', _$args, opt: true, def: const {});
  static int? _$flex(WidgetBlock v) => v.flex;
  static const Field<WidgetBlock, int> _f$flex =
      Field('flex', _$flex, opt: true);
  static ContentAlignment? _$align(WidgetBlock v) => v.align;
  static const Field<WidgetBlock, ContentAlignment> _f$align =
      Field('align', _$align, opt: true);
  static String? _$tag(WidgetBlock v) => v.tag;
  static const Field<WidgetBlock, String> _f$tag =
      Field('tag', _$tag, opt: true);
  static String _$content(WidgetBlock v) => v.content;
  static const Field<WidgetBlock, String> _f$content =
      Field('content', _$content, opt: true, def: '');
  static BlockType _$type(WidgetBlock v) => v.type;
  static const Field<WidgetBlock, BlockType> _f$type =
      Field('type', _$type, mode: FieldMode.member);

  @override
  final MappableFields<WidgetBlock> fields = const {
    #name: _f$name,
    #args: _f$args,
    #flex: _f$flex,
    #align: _f$align,
    #tag: _f$tag,
    #content: _f$content,
    #type: _f$type,
  };
  @override
  final bool ignoreNull = true;

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'widget';
  @override
  late final ClassMapperBase superMapper =
      ContentBlockMapper.ensureInitialized();

  @override
  final MappingHook hook = const UnmappedPropertiesHook('args');
  static WidgetBlock _instantiate(DecodingData data) {
    return WidgetBlock(
        name: data.dec(_f$name),
        args: data.dec(_f$args),
        flex: data.dec(_f$flex),
        align: data.dec(_f$align),
        tag: data.dec(_f$tag),
        content: data.dec(_f$content));
  }

  @override
  final Function instantiate = _instantiate;

  static WidgetBlock fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WidgetBlock>(map);
  }

  static WidgetBlock fromJson(String json) {
    return ensureInitialized().decodeJson<WidgetBlock>(json);
  }
}

mixin WidgetBlockMappable {
  String toJson() {
    return WidgetBlockMapper.ensureInitialized()
        .encodeJson<WidgetBlock>(this as WidgetBlock);
  }

  Map<String, dynamic> toMap() {
    return WidgetBlockMapper.ensureInitialized()
        .encodeMap<WidgetBlock>(this as WidgetBlock);
  }

  WidgetBlockCopyWith<WidgetBlock, WidgetBlock, WidgetBlock> get copyWith =>
      _WidgetBlockCopyWithImpl(this as WidgetBlock, $identity, $identity);
  @override
  String toString() {
    return WidgetBlockMapper.ensureInitialized()
        .stringifyValue(this as WidgetBlock);
  }

  @override
  bool operator ==(Object other) {
    return WidgetBlockMapper.ensureInitialized()
        .equalsValue(this as WidgetBlock, other);
  }

  @override
  int get hashCode {
    return WidgetBlockMapper.ensureInitialized().hashValue(this as WidgetBlock);
  }
}

extension WidgetBlockValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WidgetBlock, $Out> {
  WidgetBlockCopyWith<$R, WidgetBlock, $Out> get $asWidgetBlock =>
      $base.as((v, t, t2) => _WidgetBlockCopyWithImpl(v, t, t2));
}

abstract class WidgetBlockCopyWith<$R, $In extends WidgetBlock, $Out>
    implements ContentBlockCopyWith<$R, $In, $Out> {
  MapCopyWith<$R, String, dynamic, ObjectCopyWith<$R, dynamic, dynamic>>
      get args;
  @override
  $R call(
      {String? name,
      Map<String, dynamic>? args,
      int? flex,
      ContentAlignment? align,
      String? tag,
      String? content});
  WidgetBlockCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _WidgetBlockCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WidgetBlock, $Out>
    implements WidgetBlockCopyWith<$R, WidgetBlock, $Out> {
  _WidgetBlockCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WidgetBlock> $mapper =
      WidgetBlockMapper.ensureInitialized();
  @override
  MapCopyWith<$R, String, dynamic, ObjectCopyWith<$R, dynamic, dynamic>>
      get args => MapCopyWith($value.args,
          (v, t) => ObjectCopyWith(v, $identity, t), (v) => call(args: v));
  @override
  $R call(
          {String? name,
          Map<String, dynamic>? args,
          Object? flex = $none,
          Object? align = $none,
          Object? tag = $none,
          String? content}) =>
      $apply(FieldCopyWithData({
        if (name != null) #name: name,
        if (args != null) #args: args,
        if (flex != $none) #flex: flex,
        if (align != $none) #align: align,
        if (tag != $none) #tag: tag,
        if (content != null) #content: content
      }));
  @override
  WidgetBlock $make(CopyWithData data) => WidgetBlock(
      name: data.get(#name, or: $value.name),
      args: data.get(#args, or: $value.args),
      flex: data.get(#flex, or: $value.flex),
      align: data.get(#align, or: $value.align),
      tag: data.get(#tag, or: $value.tag),
      content: data.get(#content, or: $value.content));

  @override
  WidgetBlockCopyWith<$R2, WidgetBlock, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _WidgetBlockCopyWithImpl($value, $cast, t);
}

class DartPadBlockMapper extends SubClassMapperBase<DartPadBlock> {
  DartPadBlockMapper._();

  static DartPadBlockMapper? _instance;
  static DartPadBlockMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DartPadBlockMapper._());
      ContentBlockMapper.ensureInitialized().addSubMapper(_instance!);
      DartPadThemeMapper.ensureInitialized();
      ContentAlignmentMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'DartPadBlock';

  static String _$id(DartPadBlock v) => v.id;
  static const Field<DartPadBlock, String> _f$id = Field('id', _$id);
  static DartPadTheme? _$theme(DartPadBlock v) => v.theme;
  static const Field<DartPadBlock, DartPadTheme> _f$theme =
      Field('theme', _$theme, opt: true);
  static int? _$flex(DartPadBlock v) => v.flex;
  static const Field<DartPadBlock, int> _f$flex =
      Field('flex', _$flex, opt: true);
  static String? _$tag(DartPadBlock v) => v.tag;
  static const Field<DartPadBlock, String> _f$tag =
      Field('tag', _$tag, opt: true);
  static String _$content(DartPadBlock v) => v.content;
  static const Field<DartPadBlock, String> _f$content =
      Field('content', _$content, opt: true, def: '');
  static ContentAlignment? _$align(DartPadBlock v) => v.align;
  static const Field<DartPadBlock, ContentAlignment> _f$align =
      Field('align', _$align, opt: true);
  static bool _$embed(DartPadBlock v) => v.embed;
  static const Field<DartPadBlock, bool> _f$embed =
      Field('embed', _$embed, opt: true, def: true);
  static BlockType _$type(DartPadBlock v) => v.type;
  static const Field<DartPadBlock, BlockType> _f$type =
      Field('type', _$type, mode: FieldMode.member);

  @override
  final MappableFields<DartPadBlock> fields = const {
    #id: _f$id,
    #theme: _f$theme,
    #flex: _f$flex,
    #tag: _f$tag,
    #content: _f$content,
    #align: _f$align,
    #embed: _f$embed,
    #type: _f$type,
  };
  @override
  final bool ignoreNull = true;

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'DartPadBlock';
  @override
  late final ClassMapperBase superMapper =
      ContentBlockMapper.ensureInitialized();

  static DartPadBlock _instantiate(DecodingData data) {
    return DartPadBlock(
        id: data.dec(_f$id),
        theme: data.dec(_f$theme),
        flex: data.dec(_f$flex),
        tag: data.dec(_f$tag),
        content: data.dec(_f$content),
        align: data.dec(_f$align),
        embed: data.dec(_f$embed));
  }

  @override
  final Function instantiate = _instantiate;

  static DartPadBlock fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DartPadBlock>(map);
  }

  static DartPadBlock fromJson(String json) {
    return ensureInitialized().decodeJson<DartPadBlock>(json);
  }
}

mixin DartPadBlockMappable {
  String toJson() {
    return DartPadBlockMapper.ensureInitialized()
        .encodeJson<DartPadBlock>(this as DartPadBlock);
  }

  Map<String, dynamic> toMap() {
    return DartPadBlockMapper.ensureInitialized()
        .encodeMap<DartPadBlock>(this as DartPadBlock);
  }

  DartPadBlockCopyWith<DartPadBlock, DartPadBlock, DartPadBlock> get copyWith =>
      _DartPadBlockCopyWithImpl(this as DartPadBlock, $identity, $identity);
  @override
  String toString() {
    return DartPadBlockMapper.ensureInitialized()
        .stringifyValue(this as DartPadBlock);
  }

  @override
  bool operator ==(Object other) {
    return DartPadBlockMapper.ensureInitialized()
        .equalsValue(this as DartPadBlock, other);
  }

  @override
  int get hashCode {
    return DartPadBlockMapper.ensureInitialized()
        .hashValue(this as DartPadBlock);
  }
}

extension DartPadBlockValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DartPadBlock, $Out> {
  DartPadBlockCopyWith<$R, DartPadBlock, $Out> get $asDartPadBlock =>
      $base.as((v, t, t2) => _DartPadBlockCopyWithImpl(v, t, t2));
}

abstract class DartPadBlockCopyWith<$R, $In extends DartPadBlock, $Out>
    implements ContentBlockCopyWith<$R, $In, $Out> {
  @override
  $R call(
      {String? id,
      DartPadTheme? theme,
      int? flex,
      String? tag,
      String? content,
      ContentAlignment? align,
      bool? embed});
  DartPadBlockCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _DartPadBlockCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DartPadBlock, $Out>
    implements DartPadBlockCopyWith<$R, DartPadBlock, $Out> {
  _DartPadBlockCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DartPadBlock> $mapper =
      DartPadBlockMapper.ensureInitialized();
  @override
  $R call(
          {String? id,
          Object? theme = $none,
          Object? flex = $none,
          Object? tag = $none,
          String? content,
          Object? align = $none,
          bool? embed}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (theme != $none) #theme: theme,
        if (flex != $none) #flex: flex,
        if (tag != $none) #tag: tag,
        if (content != null) #content: content,
        if (align != $none) #align: align,
        if (embed != null) #embed: embed
      }));
  @override
  DartPadBlock $make(CopyWithData data) => DartPadBlock(
      id: data.get(#id, or: $value.id),
      theme: data.get(#theme, or: $value.theme),
      flex: data.get(#flex, or: $value.flex),
      tag: data.get(#tag, or: $value.tag),
      content: data.get(#content, or: $value.content),
      align: data.get(#align, or: $value.align),
      embed: data.get(#embed, or: $value.embed));

  @override
  DartPadBlockCopyWith<$R2, DartPadBlock, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DartPadBlockCopyWithImpl($value, $cast, t);
}

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

class ReferenceDtoMapper extends ClassMapperBase<ReferenceDto> {
  ReferenceDtoMapper._();

  static ReferenceDtoMapper? _instance;
  static ReferenceDtoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ReferenceDtoMapper._());
      ConfigMapper.ensureInitialized();
      SlideMapper.ensureInitialized();
      SlideAssetMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ReferenceDto';

  static Config _$config(ReferenceDto v) => v.config;
  static const Field<ReferenceDto, Config> _f$config =
      Field('config', _$config);
  static List<Slide> _$slides(ReferenceDto v) => v.slides;
  static const Field<ReferenceDto, List<Slide>> _f$slides =
      Field('slides', _$slides);
  static List<SlideAsset> _$assets(ReferenceDto v) => v.assets;
  static const Field<ReferenceDto, List<SlideAsset>> _f$assets =
      Field('assets', _$assets);

  @override
  final MappableFields<ReferenceDto> fields = const {
    #config: _f$config,
    #slides: _f$slides,
    #assets: _f$assets,
  };
  @override
  final bool ignoreNull = true;

  static ReferenceDto _instantiate(DecodingData data) {
    return ReferenceDto(
        config: data.dec(_f$config),
        slides: data.dec(_f$slides),
        assets: data.dec(_f$assets));
  }

  @override
  final Function instantiate = _instantiate;

  static ReferenceDto fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ReferenceDto>(map);
  }

  static ReferenceDto fromJson(String json) {
    return ensureInitialized().decodeJson<ReferenceDto>(json);
  }
}

mixin ReferenceDtoMappable {
  String toJson() {
    return ReferenceDtoMapper.ensureInitialized()
        .encodeJson<ReferenceDto>(this as ReferenceDto);
  }

  Map<String, dynamic> toMap() {
    return ReferenceDtoMapper.ensureInitialized()
        .encodeMap<ReferenceDto>(this as ReferenceDto);
  }

  ReferenceDtoCopyWith<ReferenceDto, ReferenceDto, ReferenceDto> get copyWith =>
      _ReferenceDtoCopyWithImpl(this as ReferenceDto, $identity, $identity);
  @override
  String toString() {
    return ReferenceDtoMapper.ensureInitialized()
        .stringifyValue(this as ReferenceDto);
  }

  @override
  bool operator ==(Object other) {
    return ReferenceDtoMapper.ensureInitialized()
        .equalsValue(this as ReferenceDto, other);
  }

  @override
  int get hashCode {
    return ReferenceDtoMapper.ensureInitialized()
        .hashValue(this as ReferenceDto);
  }
}

extension ReferenceDtoValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ReferenceDto, $Out> {
  ReferenceDtoCopyWith<$R, ReferenceDto, $Out> get $asReferenceDto =>
      $base.as((v, t, t2) => _ReferenceDtoCopyWithImpl(v, t, t2));
}

abstract class ReferenceDtoCopyWith<$R, $In extends ReferenceDto, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ConfigCopyWith<$R, Config, Config> get config;
  ListCopyWith<$R, Slide, SlideCopyWith<$R, Slide, Slide>> get slides;
  ListCopyWith<$R, SlideAsset, SlideAssetCopyWith<$R, SlideAsset, SlideAsset>>
      get assets;
  $R call({Config? config, List<Slide>? slides, List<SlideAsset>? assets});
  ReferenceDtoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ReferenceDtoCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ReferenceDto, $Out>
    implements ReferenceDtoCopyWith<$R, ReferenceDto, $Out> {
  _ReferenceDtoCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ReferenceDto> $mapper =
      ReferenceDtoMapper.ensureInitialized();
  @override
  ConfigCopyWith<$R, Config, Config> get config =>
      $value.config.copyWith.$chain((v) => call(config: v));
  @override
  ListCopyWith<$R, Slide, SlideCopyWith<$R, Slide, Slide>> get slides =>
      ListCopyWith($value.slides, (v, t) => v.copyWith.$chain(t),
          (v) => call(slides: v));
  @override
  ListCopyWith<$R, SlideAsset, SlideAssetCopyWith<$R, SlideAsset, SlideAsset>>
      get assets => ListCopyWith($value.assets, (v, t) => v.copyWith.$chain(t),
          (v) => call(assets: v));
  @override
  $R call({Config? config, List<Slide>? slides, List<SlideAsset>? assets}) =>
      $apply(FieldCopyWithData({
        if (config != null) #config: config,
        if (slides != null) #slides: slides,
        if (assets != null) #assets: assets
      }));
  @override
  ReferenceDto $make(CopyWithData data) => ReferenceDto(
      config: data.get(#config, or: $value.config),
      slides: data.get(#slides, or: $value.slides),
      assets: data.get(#assets, or: $value.assets));

  @override
  ReferenceDtoCopyWith<$R2, ReferenceDto, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ReferenceDtoCopyWithImpl($value, $cast, t);
}

class SlideMapper extends ClassMapperBase<Slide> {
  SlideMapper._();

  static SlideMapper? _instance;
  static SlideMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SlideMapper._());
      SlideOptionsMapper.ensureInitialized();
      SectionBlockMapper.ensureInitialized();
      SlideNoteMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Slide';

  static String _$key(Slide v) => v.key;
  static const Field<Slide, String> _f$key = Field('key', _$key);
  static SlideOptions? _$options(Slide v) => v.options;
  static const Field<Slide, SlideOptions> _f$options =
      Field('options', _$options, opt: true);
  static String _$markdown(Slide v) => v.markdown;
  static const Field<Slide, String> _f$markdown = Field('markdown', _$markdown);
  static List<SectionBlock> _$sections(Slide v) => v.sections;
  static const Field<Slide, List<SectionBlock>> _f$sections =
      Field('sections', _$sections, opt: true, def: const []);
  static List<SlideNote> _$notes(Slide v) => v.notes;
  static const Field<Slide, List<SlideNote>> _f$notes =
      Field('notes', _$notes, opt: true, def: const []);

  @override
  final MappableFields<Slide> fields = const {
    #key: _f$key,
    #options: _f$options,
    #markdown: _f$markdown,
    #sections: _f$sections,
    #notes: _f$notes,
  };
  @override
  final bool ignoreNull = true;

  static Slide _instantiate(DecodingData data) {
    return Slide(
        key: data.dec(_f$key),
        options: data.dec(_f$options),
        markdown: data.dec(_f$markdown),
        sections: data.dec(_f$sections),
        notes: data.dec(_f$notes));
  }

  @override
  final Function instantiate = _instantiate;

  static Slide fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Slide>(map);
  }

  static Slide fromJson(String json) {
    return ensureInitialized().decodeJson<Slide>(json);
  }
}

mixin SlideMappable {
  String toJson() {
    return SlideMapper.ensureInitialized().encodeJson<Slide>(this as Slide);
  }

  Map<String, dynamic> toMap() {
    return SlideMapper.ensureInitialized().encodeMap<Slide>(this as Slide);
  }

  SlideCopyWith<Slide, Slide, Slide> get copyWith =>
      _SlideCopyWithImpl(this as Slide, $identity, $identity);
  @override
  String toString() {
    return SlideMapper.ensureInitialized().stringifyValue(this as Slide);
  }

  @override
  bool operator ==(Object other) {
    return SlideMapper.ensureInitialized().equalsValue(this as Slide, other);
  }

  @override
  int get hashCode {
    return SlideMapper.ensureInitialized().hashValue(this as Slide);
  }
}

extension SlideValueCopy<$R, $Out> on ObjectCopyWith<$R, Slide, $Out> {
  SlideCopyWith<$R, Slide, $Out> get $asSlide =>
      $base.as((v, t, t2) => _SlideCopyWithImpl(v, t, t2));
}

abstract class SlideCopyWith<$R, $In extends Slide, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  SlideOptionsCopyWith<$R, SlideOptions, SlideOptions>? get options;
  ListCopyWith<$R, SectionBlock,
      SectionBlockCopyWith<$R, SectionBlock, SectionBlock>> get sections;
  ListCopyWith<$R, SlideNote, SlideNoteCopyWith<$R, SlideNote, SlideNote>>
      get notes;
  $R call(
      {String? key,
      SlideOptions? options,
      String? markdown,
      List<SectionBlock>? sections,
      List<SlideNote>? notes});
  SlideCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SlideCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Slide, $Out>
    implements SlideCopyWith<$R, Slide, $Out> {
  _SlideCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Slide> $mapper = SlideMapper.ensureInitialized();
  @override
  SlideOptionsCopyWith<$R, SlideOptions, SlideOptions>? get options =>
      $value.options?.copyWith.$chain((v) => call(options: v));
  @override
  ListCopyWith<$R, SectionBlock,
          SectionBlockCopyWith<$R, SectionBlock, SectionBlock>>
      get sections => ListCopyWith($value.sections,
          (v, t) => v.copyWith.$chain(t), (v) => call(sections: v));
  @override
  ListCopyWith<$R, SlideNote, SlideNoteCopyWith<$R, SlideNote, SlideNote>>
      get notes => ListCopyWith(
          $value.notes, (v, t) => v.copyWith.$chain(t), (v) => call(notes: v));
  @override
  $R call(
          {String? key,
          Object? options = $none,
          String? markdown,
          List<SectionBlock>? sections,
          List<SlideNote>? notes}) =>
      $apply(FieldCopyWithData({
        if (key != null) #key: key,
        if (options != $none) #options: options,
        if (markdown != null) #markdown: markdown,
        if (sections != null) #sections: sections,
        if (notes != null) #notes: notes
      }));
  @override
  Slide $make(CopyWithData data) => Slide(
      key: data.get(#key, or: $value.key),
      options: data.get(#options, or: $value.options),
      markdown: data.get(#markdown, or: $value.markdown),
      sections: data.get(#sections, or: $value.sections),
      notes: data.get(#notes, or: $value.notes));

  @override
  SlideCopyWith<$R2, Slide, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _SlideCopyWithImpl($value, $cast, t);
}

class SlideNoteMapper extends ClassMapperBase<SlideNote> {
  SlideNoteMapper._();

  static SlideNoteMapper? _instance;
  static SlideNoteMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SlideNoteMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'SlideNote';

  static String _$content(SlideNote v) => v.content;
  static const Field<SlideNote, String> _f$content =
      Field('content', _$content);

  @override
  final MappableFields<SlideNote> fields = const {
    #content: _f$content,
  };
  @override
  final bool ignoreNull = true;

  static SlideNote _instantiate(DecodingData data) {
    return SlideNote(content: data.dec(_f$content));
  }

  @override
  final Function instantiate = _instantiate;

  static SlideNote fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SlideNote>(map);
  }

  static SlideNote fromJson(String json) {
    return ensureInitialized().decodeJson<SlideNote>(json);
  }
}

mixin SlideNoteMappable {
  String toJson() {
    return SlideNoteMapper.ensureInitialized()
        .encodeJson<SlideNote>(this as SlideNote);
  }

  Map<String, dynamic> toMap() {
    return SlideNoteMapper.ensureInitialized()
        .encodeMap<SlideNote>(this as SlideNote);
  }

  SlideNoteCopyWith<SlideNote, SlideNote, SlideNote> get copyWith =>
      _SlideNoteCopyWithImpl(this as SlideNote, $identity, $identity);
  @override
  String toString() {
    return SlideNoteMapper.ensureInitialized()
        .stringifyValue(this as SlideNote);
  }

  @override
  bool operator ==(Object other) {
    return SlideNoteMapper.ensureInitialized()
        .equalsValue(this as SlideNote, other);
  }

  @override
  int get hashCode {
    return SlideNoteMapper.ensureInitialized().hashValue(this as SlideNote);
  }
}

extension SlideNoteValueCopy<$R, $Out> on ObjectCopyWith<$R, SlideNote, $Out> {
  SlideNoteCopyWith<$R, SlideNote, $Out> get $asSlideNote =>
      $base.as((v, t, t2) => _SlideNoteCopyWithImpl(v, t, t2));
}

abstract class SlideNoteCopyWith<$R, $In extends SlideNote, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? content});
  SlideNoteCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SlideNoteCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SlideNote, $Out>
    implements SlideNoteCopyWith<$R, SlideNote, $Out> {
  _SlideNoteCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SlideNote> $mapper =
      SlideNoteMapper.ensureInitialized();
  @override
  $R call({String? content}) =>
      $apply(FieldCopyWithData({if (content != null) #content: content}));
  @override
  SlideNote $make(CopyWithData data) =>
      SlideNote(content: data.get(#content, or: $value.content));

  @override
  SlideNoteCopyWith<$R2, SlideNote, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _SlideNoteCopyWithImpl($value, $cast, t);
}
