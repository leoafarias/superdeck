// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'style_spec.dart';

// **************************************************************************
// MixableClassUtilityGenerator
// **************************************************************************

/// {@template table_column_width_utility}
/// A utility class for creating [Attribute] instances from [TableColumnWidth] values.
///
/// This class extends [MixUtility] and provides methods to create [Attribute] instances
/// from predefined [TableColumnWidth] values.
/// {@endtemplate}
mixin _$TableColumnWidthUtility<T extends Attribute>
    on MixUtility<T, TableColumnWidth> {
  /// Creates an [Attribute] instance with the specified TableColumnWidth value.
  T call(TableColumnWidth value) => builder(value);
}

/// {@template table_border_utility}
/// A utility class for creating [Attribute] instances from [TableBorder] values.
///
/// This class extends [MixUtility] and provides methods to create [Attribute] instances
/// from predefined [TableBorder] values.
/// {@endtemplate}
mixin _$TableBorderUtility<T extends Attribute> on MixUtility<T, TableBorder> {
  /// Creates an [Attribute] instance using the [TableBorder.all] constructor.
  T all(
      {Color color = const Color(0xFF000000),
      double width = 1.0,
      BorderStyle style = BorderStyle.solid,
      BorderRadius borderRadius = BorderRadius.zero}) {
    return builder(TableBorder.all(
        color: color, width: width, style: style, borderRadius: borderRadius));
  }

  /// Creates an [Attribute] instance using the [TableBorder.symmetric] constructor.
  T symmetric(
      {BorderSide inside = BorderSide.none,
      BorderSide outside = BorderSide.none,
      BorderRadius borderRadius = BorderRadius.zero}) {
    return builder(TableBorder.symmetric(
        inside: inside, outside: outside, borderRadius: borderRadius));
  }

  /// Creates an [Attribute] instance with the specified TableBorder value.
  T call(TableBorder value) => builder(value);
}

// **************************************************************************
// MixableEnumUtilityGenerator
// **************************************************************************

/// {@template markdown_alternating_utility}
/// A utility class for creating [Attribute] instances from [MarkdownAlternating] values.
///
/// This class extends [MixUtility] and provides methods to create [Attribute] instances
/// from predefined [MarkdownAlternating] values.
/// {@endtemplate}
mixin _$MarkdownAlternatingUtility<T extends Attribute>
    on MixUtility<T, MarkdownAlternating> {
  /// Creates an [Attribute] instance with [MarkdownAlternating.odd] value.
  T odd() => builder(MarkdownAlternating.odd);

  /// Creates an [Attribute] instance with [MarkdownAlternating.even] value.
  T even() => builder(MarkdownAlternating.even);
}

// **************************************************************************
// MixableSpecGenerator
// **************************************************************************

// ignore_for_file: deprecated_member_use_from_same_package

mixin _$MdDivider on Spec<MdDivider> {
  static MdDivider from(MixData mix) {
    return mix.attributeOf<MdDividerAttribute>()?.resolve(mix) ??
        const MdDivider();
  }

  /// {@template md_divider_of}
  /// Retrieves the [MdDivider] from the nearest [Mix] ancestor in the widget tree.
  ///
  /// This method uses [Mix.of] to obtain the [Mix] instance associated with the
  /// given [BuildContext], and then retrieves the [MdDivider] from that [Mix].
  /// If no ancestor [Mix] is found, this method returns an empty [MdDivider].
  ///
  /// Example:
  ///
  /// ```dart
  /// final mdDivider = MdDivider.of(context);
  /// ```
  /// {@endtemplate}
  static MdDivider of(BuildContext context) {
    return _$MdDivider.from(Mix.of(context));
  }

  /// Creates a copy of this [MdDivider] but with the given fields
  /// replaced with the new values.
  @override
  MdDivider copyWith({
    double? dividerHeight,
    Color? dividerColor,
    double? dividerThickness,
  }) {
    return MdDivider(
      dividerHeight: dividerHeight ?? _$this.dividerHeight,
      dividerColor: dividerColor ?? _$this.dividerColor,
      dividerThickness: dividerThickness ?? _$this.dividerThickness,
    );
  }

  /// Linearly interpolates between this [MdDivider] and another [MdDivider] based on the given parameter [t].
  ///
  /// The parameter [t] represents the interpolation factor, typically ranging from 0.0 to 1.0.
  /// When [t] is 0.0, the current [MdDivider] is returned. When [t] is 1.0, the [other] [MdDivider] is returned.
  /// For values of [t] between 0.0 and 1.0, an interpolated [MdDivider] is returned.
  ///
  /// If [other] is null, this method returns the current [MdDivider] instance.
  ///
  /// The interpolation is performed on each property of the [MdDivider] using the appropriate
  /// interpolation method:
  ///
  /// - [MixHelpers.lerpDouble] for [dividerHeight] and [dividerThickness].
  /// - [Color.lerp] for [dividerColor].

  /// For , the interpolation is performed using a step function.
  /// If [t] is less than 0.5, the value from the current [MdDivider] is used. Otherwise, the value
  /// from the [other] [MdDivider] is used.
  ///
  /// This method is typically used in animations to smoothly transition between
  /// different [MdDivider] configurations.
  @override
  MdDivider lerp(MdDivider? other, double t) {
    if (other == null) return _$this;

    return MdDivider(
      dividerHeight:
          MixHelpers.lerpDouble(_$this.dividerHeight, other.dividerHeight, t),
      dividerColor: Color.lerp(_$this.dividerColor, other.dividerColor, t),
      dividerThickness: MixHelpers.lerpDouble(
          _$this.dividerThickness, other.dividerThickness, t),
    );
  }

  /// The list of properties that constitute the state of this [MdDivider].
  ///
  /// This property is used by the [==] operator and the [hashCode] getter to
  /// compare two [MdDivider] instances for equality.
  @override
  List<Object?> get props => [
        _$this.dividerHeight,
        _$this.dividerColor,
        _$this.dividerThickness,
      ];

  MdDivider get _$this => this as MdDivider;
}

/// Represents the attributes of a [MdDivider].
///
/// This class encapsulates properties defining the layout and
/// appearance of a [MdDivider].
///
/// Use this class to configure the attributes of a [MdDivider] and pass it to
/// the [MdDivider] constructor.
final class MdDividerAttribute extends SpecAttribute<MdDivider> {
  final double? dividerHeight;
  final ColorDto? dividerColor;
  final double? dividerThickness;

  const MdDividerAttribute({
    this.dividerHeight,
    this.dividerColor,
    this.dividerThickness,
  });

  /// Resolves to [MdDivider] using the provided [MixData].
  ///
  /// If a property is null in the [MixData], it falls back to the
  /// default value defined in the `defaultValue` for that property.
  ///
  /// ```dart
  /// final mdDivider = MdDividerAttribute(...).resolve(mix);
  /// ```
  @override
  MdDivider resolve(MixData mix) {
    return MdDivider(
      dividerHeight: dividerHeight,
      dividerColor: dividerColor?.resolve(mix),
      dividerThickness: dividerThickness,
    );
  }

  /// Merges the properties of this [MdDividerAttribute] with the properties of [other].
  ///
  /// If [other] is null, returns this instance unchanged. Otherwise, returns a new
  /// [MdDividerAttribute] with the properties of [other] taking precedence over
  /// the corresponding properties of this instance.
  ///
  /// Properties from [other] that are null will fall back
  /// to the values from this instance.
  @override
  MdDividerAttribute merge(MdDividerAttribute? other) {
    if (other == null) return this;

    return MdDividerAttribute(
      dividerHeight: other.dividerHeight ?? dividerHeight,
      dividerColor:
          dividerColor?.merge(other.dividerColor) ?? other.dividerColor,
      dividerThickness: other.dividerThickness ?? dividerThickness,
    );
  }

  /// The list of properties that constitute the state of this [MdDividerAttribute].
  ///
  /// This property is used by the [==] operator and the [hashCode] getter to
  /// compare two [MdDividerAttribute] instances for equality.
  @override
  List<Object?> get props => [
        dividerHeight,
        dividerColor,
        dividerThickness,
      ];
}

/// Utility class for configuring [MdDividerAttribute] properties.
///
/// This class provides methods to set individual properties of a [MdDividerAttribute].
/// Use the methods of this class to configure specific properties of a [MdDividerAttribute].
class MdDividerUtility<T extends Attribute>
    extends SpecUtility<T, MdDividerAttribute> {
  /// Utility for defining [MdDividerAttribute.dividerHeight]
  late final height = DoubleUtility((v) => only(dividerHeight: v));

  /// Utility for defining [MdDividerAttribute.dividerColor]
  late final color = ColorUtility((v) => only(dividerColor: v));

  /// Utility for defining [MdDividerAttribute.dividerThickness]
  late final thickness = DoubleUtility((v) => only(dividerThickness: v));

  MdDividerUtility(super.builder);

  static final self = MdDividerUtility((v) => v);

  /// Returns a new [MdDividerAttribute] with the specified properties.
  @override
  T only({
    double? dividerHeight,
    ColorDto? dividerColor,
    double? dividerThickness,
  }) {
    return builder(MdDividerAttribute(
      dividerHeight: dividerHeight,
      dividerColor: dividerColor,
      dividerThickness: dividerThickness,
    ));
  }
}

/// A tween that interpolates between two [MdDivider] instances.
///
/// This class can be used in animations to smoothly transition between
/// different [MdDivider] specifications.
class MdDividerTween extends Tween<MdDivider?> {
  MdDividerTween({
    super.begin,
    super.end,
  });

  @override
  MdDivider lerp(double t) {
    if (begin == null && end == null) return const MdDivider();
    if (begin == null) return end!;

    return begin!.lerp(end!, t);
  }
}

// ignore_for_file: deprecated_member_use_from_same_package

mixin _$MdTextStyle on Spec<MdTextStyle> {
  static MdTextStyle from(MixData mix) {
    return mix.attributeOf<MdTextStyleAttribute>()?.resolve(mix) ??
        const MdTextStyle();
  }

  /// {@template md_text_style_of}
  /// Retrieves the [MdTextStyle] from the nearest [Mix] ancestor in the widget tree.
  ///
  /// This method uses [Mix.of] to obtain the [Mix] instance associated with the
  /// given [BuildContext], and then retrieves the [MdTextStyle] from that [Mix].
  /// If no ancestor [Mix] is found, this method returns an empty [MdTextStyle].
  ///
  /// Example:
  ///
  /// ```dart
  /// final mdTextStyle = MdTextStyle.of(context);
  /// ```
  /// {@endtemplate}
  static MdTextStyle of(BuildContext context) {
    return _$MdTextStyle.from(Mix.of(context));
  }

  /// Creates a copy of this [MdTextStyle] but with the given fields
  /// replaced with the new values.
  @override
  MdTextStyle copyWith({
    TextStyle? textStyle,
    EdgeInsets? padding,
  }) {
    return MdTextStyle(
      textStyle: textStyle ?? _$this.textStyle,
      padding: padding ?? _$this.padding,
    );
  }

  /// Linearly interpolates between this [MdTextStyle] and another [MdTextStyle] based on the given parameter [t].
  ///
  /// The parameter [t] represents the interpolation factor, typically ranging from 0.0 to 1.0.
  /// When [t] is 0.0, the current [MdTextStyle] is returned. When [t] is 1.0, the [other] [MdTextStyle] is returned.
  /// For values of [t] between 0.0 and 1.0, an interpolated [MdTextStyle] is returned.
  ///
  /// If [other] is null, this method returns the current [MdTextStyle] instance.
  ///
  /// The interpolation is performed on each property of the [MdTextStyle] using the appropriate
  /// interpolation method:
  ///
  /// - [MixHelpers.lerpTextStyle] for [textStyle].
  /// - [EdgeInsets.lerp] for [padding].

  /// For , the interpolation is performed using a step function.
  /// If [t] is less than 0.5, the value from the current [MdTextStyle] is used. Otherwise, the value
  /// from the [other] [MdTextStyle] is used.
  ///
  /// This method is typically used in animations to smoothly transition between
  /// different [MdTextStyle] configurations.
  @override
  MdTextStyle lerp(MdTextStyle? other, double t) {
    if (other == null) return _$this;

    return MdTextStyle(
      textStyle: MixHelpers.lerpTextStyle(_$this.textStyle, other.textStyle, t),
      padding: EdgeInsets.lerp(_$this.padding, other.padding, t),
    );
  }

  /// The list of properties that constitute the state of this [MdTextStyle].
  ///
  /// This property is used by the [==] operator and the [hashCode] getter to
  /// compare two [MdTextStyle] instances for equality.
  @override
  List<Object?> get props => [
        _$this.textStyle,
        _$this.padding,
      ];

  MdTextStyle get _$this => this as MdTextStyle;
}

/// Represents the attributes of a [MdTextStyle].
///
/// This class encapsulates properties defining the layout and
/// appearance of a [MdTextStyle].
///
/// Use this class to configure the attributes of a [MdTextStyle] and pass it to
/// the [MdTextStyle] constructor.
final class MdTextStyleAttribute extends SpecAttribute<MdTextStyle> {
  final TextStyleDto? textStyle;
  final EdgeInsetsDto? padding;

  const MdTextStyleAttribute({
    this.textStyle,
    this.padding,
  });

  /// Resolves to [MdTextStyle] using the provided [MixData].
  ///
  /// If a property is null in the [MixData], it falls back to the
  /// default value defined in the `defaultValue` for that property.
  ///
  /// ```dart
  /// final mdTextStyle = MdTextStyleAttribute(...).resolve(mix);
  /// ```
  @override
  MdTextStyle resolve(MixData mix) {
    return MdTextStyle(
      textStyle: textStyle?.resolve(mix),
      padding: padding?.resolve(mix),
    );
  }

  /// Merges the properties of this [MdTextStyleAttribute] with the properties of [other].
  ///
  /// If [other] is null, returns this instance unchanged. Otherwise, returns a new
  /// [MdTextStyleAttribute] with the properties of [other] taking precedence over
  /// the corresponding properties of this instance.
  ///
  /// Properties from [other] that are null will fall back
  /// to the values from this instance.
  @override
  MdTextStyleAttribute merge(MdTextStyleAttribute? other) {
    if (other == null) return this;

    return MdTextStyleAttribute(
      textStyle: textStyle?.merge(other.textStyle) ?? other.textStyle,
      padding: padding?.merge(other.padding) ?? other.padding,
    );
  }

  /// The list of properties that constitute the state of this [MdTextStyleAttribute].
  ///
  /// This property is used by the [==] operator and the [hashCode] getter to
  /// compare two [MdTextStyleAttribute] instances for equality.
  @override
  List<Object?> get props => [
        textStyle,
        padding,
      ];
}

/// Utility class for configuring [MdTextStyleAttribute] properties.
///
/// This class provides methods to set individual properties of a [MdTextStyleAttribute].
/// Use the methods of this class to configure specific properties of a [MdTextStyleAttribute].
class MdTextStyleUtility<T extends Attribute>
    extends SpecUtility<T, MdTextStyleAttribute> {
  /// Utility for defining [MdTextStyleAttribute.textStyle]
  late final textStyle = TextStyleUtility((v) => only(textStyle: v));

  /// Utility for defining [MdTextStyleAttribute.padding]
  late final padding = EdgeInsetsUtility((v) => only(padding: v));

  MdTextStyleUtility(super.builder);

  static final self = MdTextStyleUtility((v) => v);

  /// Returns a new [MdTextStyleAttribute] with the specified properties.
  @override
  T only({
    TextStyleDto? textStyle,
    EdgeInsetsDto? padding,
  }) {
    return builder(MdTextStyleAttribute(
      textStyle: textStyle,
      padding: padding,
    ));
  }
}

/// A tween that interpolates between two [MdTextStyle] instances.
///
/// This class can be used in animations to smoothly transition between
/// different [MdTextStyle] specifications.
class MdTextStyleTween extends Tween<MdTextStyle?> {
  MdTextStyleTween({
    super.begin,
    super.end,
  });

  @override
  MdTextStyle lerp(double t) {
    if (begin == null && end == null) return const MdTextStyle();
    if (begin == null) return end!;

    return begin!.lerp(end!, t);
  }
}

// ignore_for_file: deprecated_member_use_from_same_package

mixin _$MdList on Spec<MdList> {
  static MdList from(MixData mix) {
    return mix.attributeOf<MdListAttribute>()?.resolve(mix) ?? const MdList();
  }

  /// {@template md_list_of}
  /// Retrieves the [MdList] from the nearest [Mix] ancestor in the widget tree.
  ///
  /// This method uses [Mix.of] to obtain the [Mix] instance associated with the
  /// given [BuildContext], and then retrieves the [MdList] from that [Mix].
  /// If no ancestor [Mix] is found, this method returns an empty [MdList].
  ///
  /// Example:
  ///
  /// ```dart
  /// final mdList = MdList.of(context);
  /// ```
  /// {@endtemplate}
  static MdList of(BuildContext context) {
    return _$MdList.from(Mix.of(context));
  }

  /// Creates a copy of this [MdList] but with the given fields
  /// replaced with the new values.
  @override
  MdList copyWith({
    TextStyle? list,
    TextStyle? listItem,
    TextStyle? listItemMarker,
    double? listItemMarkerTrailingSpace,
    double? listItemMinIndent,
  }) {
    return MdList(
      list: list ?? _$this.list,
      listItem: listItem ?? _$this.listItem,
      listItemMarker: listItemMarker ?? _$this.listItemMarker,
      listItemMarkerTrailingSpace:
          listItemMarkerTrailingSpace ?? _$this.listItemMarkerTrailingSpace,
      listItemMinIndent: listItemMinIndent ?? _$this.listItemMinIndent,
    );
  }

  /// Linearly interpolates between this [MdList] and another [MdList] based on the given parameter [t].
  ///
  /// The parameter [t] represents the interpolation factor, typically ranging from 0.0 to 1.0.
  /// When [t] is 0.0, the current [MdList] is returned. When [t] is 1.0, the [other] [MdList] is returned.
  /// For values of [t] between 0.0 and 1.0, an interpolated [MdList] is returned.
  ///
  /// If [other] is null, this method returns the current [MdList] instance.
  ///
  /// The interpolation is performed on each property of the [MdList] using the appropriate
  /// interpolation method:
  ///
  /// - [MixHelpers.lerpTextStyle] for [list] and [listItem] and [listItemMarker].
  /// - [MixHelpers.lerpDouble] for [listItemMarkerTrailingSpace] and [listItemMinIndent].

  /// For , the interpolation is performed using a step function.
  /// If [t] is less than 0.5, the value from the current [MdList] is used. Otherwise, the value
  /// from the [other] [MdList] is used.
  ///
  /// This method is typically used in animations to smoothly transition between
  /// different [MdList] configurations.
  @override
  MdList lerp(MdList? other, double t) {
    if (other == null) return _$this;

    return MdList(
      list: MixHelpers.lerpTextStyle(_$this.list, other.list, t),
      listItem: MixHelpers.lerpTextStyle(_$this.listItem, other.listItem, t),
      listItemMarker: MixHelpers.lerpTextStyle(
          _$this.listItemMarker, other.listItemMarker, t),
      listItemMarkerTrailingSpace: MixHelpers.lerpDouble(
          _$this.listItemMarkerTrailingSpace,
          other.listItemMarkerTrailingSpace,
          t),
      listItemMinIndent: MixHelpers.lerpDouble(
          _$this.listItemMinIndent, other.listItemMinIndent, t),
    );
  }

  /// The list of properties that constitute the state of this [MdList].
  ///
  /// This property is used by the [==] operator and the [hashCode] getter to
  /// compare two [MdList] instances for equality.
  @override
  List<Object?> get props => [
        _$this.list,
        _$this.listItem,
        _$this.listItemMarker,
        _$this.listItemMarkerTrailingSpace,
        _$this.listItemMinIndent,
      ];

  MdList get _$this => this as MdList;
}

/// Represents the attributes of a [MdList].
///
/// This class encapsulates properties defining the layout and
/// appearance of a [MdList].
///
/// Use this class to configure the attributes of a [MdList] and pass it to
/// the [MdList] constructor.
final class MdListAttribute extends SpecAttribute<MdList> {
  final TextStyleDto? list;
  final TextStyleDto? listItem;
  final TextStyleDto? listItemMarker;
  final double? listItemMarkerTrailingSpace;
  final double? listItemMinIndent;

  const MdListAttribute({
    this.list,
    this.listItem,
    this.listItemMarker,
    this.listItemMarkerTrailingSpace,
    this.listItemMinIndent,
  });

  /// Resolves to [MdList] using the provided [MixData].
  ///
  /// If a property is null in the [MixData], it falls back to the
  /// default value defined in the `defaultValue` for that property.
  ///
  /// ```dart
  /// final mdList = MdListAttribute(...).resolve(mix);
  /// ```
  @override
  MdList resolve(MixData mix) {
    return MdList(
      list: list?.resolve(mix),
      listItem: listItem?.resolve(mix),
      listItemMarker: listItemMarker?.resolve(mix),
      listItemMarkerTrailingSpace: listItemMarkerTrailingSpace,
      listItemMinIndent: listItemMinIndent,
    );
  }

  /// Merges the properties of this [MdListAttribute] with the properties of [other].
  ///
  /// If [other] is null, returns this instance unchanged. Otherwise, returns a new
  /// [MdListAttribute] with the properties of [other] taking precedence over
  /// the corresponding properties of this instance.
  ///
  /// Properties from [other] that are null will fall back
  /// to the values from this instance.
  @override
  MdListAttribute merge(MdListAttribute? other) {
    if (other == null) return this;

    return MdListAttribute(
      list: list?.merge(other.list) ?? other.list,
      listItem: listItem?.merge(other.listItem) ?? other.listItem,
      listItemMarker:
          listItemMarker?.merge(other.listItemMarker) ?? other.listItemMarker,
      listItemMarkerTrailingSpace:
          other.listItemMarkerTrailingSpace ?? listItemMarkerTrailingSpace,
      listItemMinIndent: other.listItemMinIndent ?? listItemMinIndent,
    );
  }

  /// The list of properties that constitute the state of this [MdListAttribute].
  ///
  /// This property is used by the [==] operator and the [hashCode] getter to
  /// compare two [MdListAttribute] instances for equality.
  @override
  List<Object?> get props => [
        list,
        listItem,
        listItemMarker,
        listItemMarkerTrailingSpace,
        listItemMinIndent,
      ];
}

/// Utility class for configuring [MdListAttribute] properties.
///
/// This class provides methods to set individual properties of a [MdListAttribute].
/// Use the methods of this class to configure specific properties of a [MdListAttribute].
class MdListUtility<T extends Attribute>
    extends SpecUtility<T, MdListAttribute> {
  /// Utility for defining [MdListAttribute.list]
  late final textStyle = TextStyleUtility((v) => only(list: v));

  /// Utility for defining [MdListAttribute.listItem]
  late final itemTextStyle = TextStyleUtility((v) => only(listItem: v));

  /// Utility for defining [MdListAttribute.listItemMarker]
  late final itemMarkerTextStyle =
      TextStyleUtility((v) => only(listItemMarker: v));

  /// Utility for defining [MdListAttribute.listItemMarkerTrailingSpace]
  late final itemMarkerTrailingSpace =
      DoubleUtility((v) => only(listItemMarkerTrailingSpace: v));

  /// Utility for defining [MdListAttribute.listItemMinIndent]
  late final itemMinIndent = DoubleUtility((v) => only(listItemMinIndent: v));

  MdListUtility(super.builder);

  static final self = MdListUtility((v) => v);

  /// Returns a new [MdListAttribute] with the specified properties.
  @override
  T only({
    TextStyleDto? list,
    TextStyleDto? listItem,
    TextStyleDto? listItemMarker,
    double? listItemMarkerTrailingSpace,
    double? listItemMinIndent,
  }) {
    return builder(MdListAttribute(
      list: list,
      listItem: listItem,
      listItemMarker: listItemMarker,
      listItemMarkerTrailingSpace: listItemMarkerTrailingSpace,
      listItemMinIndent: listItemMinIndent,
    ));
  }
}

/// A tween that interpolates between two [MdList] instances.
///
/// This class can be used in animations to smoothly transition between
/// different [MdList] specifications.
class MdListTween extends Tween<MdList?> {
  MdListTween({
    super.begin,
    super.end,
  });

  @override
  MdList lerp(double t) {
    if (begin == null && end == null) return const MdList();
    if (begin == null) return end!;

    return begin!.lerp(end!, t);
  }
}

// ignore_for_file: deprecated_member_use_from_same_package

mixin _$MdBlockQuote on Spec<MdBlockQuote> {
  static MdBlockQuote from(MixData mix) {
    return mix.attributeOf<MdBlockQuoteAttribute>()?.resolve(mix) ??
        const MdBlockQuote();
  }

  /// {@template md_block_quote_of}
  /// Retrieves the [MdBlockQuote] from the nearest [Mix] ancestor in the widget tree.
  ///
  /// This method uses [Mix.of] to obtain the [Mix] instance associated with the
  /// given [BuildContext], and then retrieves the [MdBlockQuote] from that [Mix].
  /// If no ancestor [Mix] is found, this method returns an empty [MdBlockQuote].
  ///
  /// Example:
  ///
  /// ```dart
  /// final mdBlockQuote = MdBlockQuote.of(context);
  /// ```
  /// {@endtemplate}
  static MdBlockQuote of(BuildContext context) {
    return _$MdBlockQuote.from(Mix.of(context));
  }

  /// Creates a copy of this [MdBlockQuote] but with the given fields
  /// replaced with the new values.
  @override
  MdBlockQuote copyWith({
    TextStyle? blockquote,
    BoxDecoration? blockquoteDecoration,
    EdgeInsets? blockquotePadding,
    EdgeInsets? blockquoteContentPadding,
  }) {
    return MdBlockQuote(
      blockquote: blockquote ?? _$this.blockquote,
      blockquoteDecoration: blockquoteDecoration ?? _$this.blockquoteDecoration,
      blockquotePadding: blockquotePadding ?? _$this.blockquotePadding,
      blockquoteContentPadding:
          blockquoteContentPadding ?? _$this.blockquoteContentPadding,
    );
  }

  /// Linearly interpolates between this [MdBlockQuote] and another [MdBlockQuote] based on the given parameter [t].
  ///
  /// The parameter [t] represents the interpolation factor, typically ranging from 0.0 to 1.0.
  /// When [t] is 0.0, the current [MdBlockQuote] is returned. When [t] is 1.0, the [other] [MdBlockQuote] is returned.
  /// For values of [t] between 0.0 and 1.0, an interpolated [MdBlockQuote] is returned.
  ///
  /// If [other] is null, this method returns the current [MdBlockQuote] instance.
  ///
  /// The interpolation is performed on each property of the [MdBlockQuote] using the appropriate
  /// interpolation method:
  ///
  /// - [MixHelpers.lerpTextStyle] for [blockquote].
  /// - [BoxDecoration.lerp] for [blockquoteDecoration].
  /// - [EdgeInsets.lerp] for [blockquotePadding] and [blockquoteContentPadding].

  /// For , the interpolation is performed using a step function.
  /// If [t] is less than 0.5, the value from the current [MdBlockQuote] is used. Otherwise, the value
  /// from the [other] [MdBlockQuote] is used.
  ///
  /// This method is typically used in animations to smoothly transition between
  /// different [MdBlockQuote] configurations.
  @override
  MdBlockQuote lerp(MdBlockQuote? other, double t) {
    if (other == null) return _$this;

    return MdBlockQuote(
      blockquote:
          MixHelpers.lerpTextStyle(_$this.blockquote, other.blockquote, t),
      blockquoteDecoration: BoxDecoration.lerp(
          _$this.blockquoteDecoration, other.blockquoteDecoration, t),
      blockquotePadding:
          EdgeInsets.lerp(_$this.blockquotePadding, other.blockquotePadding, t),
      blockquoteContentPadding: EdgeInsets.lerp(
          _$this.blockquoteContentPadding, other.blockquoteContentPadding, t),
    );
  }

  /// The list of properties that constitute the state of this [MdBlockQuote].
  ///
  /// This property is used by the [==] operator and the [hashCode] getter to
  /// compare two [MdBlockQuote] instances for equality.
  @override
  List<Object?> get props => [
        _$this.blockquote,
        _$this.blockquoteDecoration,
        _$this.blockquotePadding,
        _$this.blockquoteContentPadding,
      ];

  MdBlockQuote get _$this => this as MdBlockQuote;
}

/// Represents the attributes of a [MdBlockQuote].
///
/// This class encapsulates properties defining the layout and
/// appearance of a [MdBlockQuote].
///
/// Use this class to configure the attributes of a [MdBlockQuote] and pass it to
/// the [MdBlockQuote] constructor.
final class MdBlockQuoteAttribute extends SpecAttribute<MdBlockQuote> {
  final TextStyleDto? blockquote;
  final BoxDecorationDto? blockquoteDecoration;
  final EdgeInsetsDto? blockquotePadding;
  final EdgeInsetsDto? blockquoteContentPadding;

  const MdBlockQuoteAttribute({
    this.blockquote,
    this.blockquoteDecoration,
    this.blockquotePadding,
    this.blockquoteContentPadding,
  });

  /// Resolves to [MdBlockQuote] using the provided [MixData].
  ///
  /// If a property is null in the [MixData], it falls back to the
  /// default value defined in the `defaultValue` for that property.
  ///
  /// ```dart
  /// final mdBlockQuote = MdBlockQuoteAttribute(...).resolve(mix);
  /// ```
  @override
  MdBlockQuote resolve(MixData mix) {
    return MdBlockQuote(
      blockquote: blockquote?.resolve(mix),
      blockquoteDecoration: blockquoteDecoration?.resolve(mix),
      blockquotePadding: blockquotePadding?.resolve(mix),
      blockquoteContentPadding: blockquoteContentPadding?.resolve(mix),
    );
  }

  /// Merges the properties of this [MdBlockQuoteAttribute] with the properties of [other].
  ///
  /// If [other] is null, returns this instance unchanged. Otherwise, returns a new
  /// [MdBlockQuoteAttribute] with the properties of [other] taking precedence over
  /// the corresponding properties of this instance.
  ///
  /// Properties from [other] that are null will fall back
  /// to the values from this instance.
  @override
  MdBlockQuoteAttribute merge(MdBlockQuoteAttribute? other) {
    if (other == null) return this;

    return MdBlockQuoteAttribute(
      blockquote: blockquote?.merge(other.blockquote) ?? other.blockquote,
      blockquoteDecoration:
          blockquoteDecoration?.merge(other.blockquoteDecoration) ??
              other.blockquoteDecoration,
      blockquotePadding: blockquotePadding?.merge(other.blockquotePadding) ??
          other.blockquotePadding,
      blockquoteContentPadding:
          blockquoteContentPadding?.merge(other.blockquoteContentPadding) ??
              other.blockquoteContentPadding,
    );
  }

  /// The list of properties that constitute the state of this [MdBlockQuoteAttribute].
  ///
  /// This property is used by the [==] operator and the [hashCode] getter to
  /// compare two [MdBlockQuoteAttribute] instances for equality.
  @override
  List<Object?> get props => [
        blockquote,
        blockquoteDecoration,
        blockquotePadding,
        blockquoteContentPadding,
      ];
}

/// Utility class for configuring [MdBlockQuoteAttribute] properties.
///
/// This class provides methods to set individual properties of a [MdBlockQuoteAttribute].
/// Use the methods of this class to configure specific properties of a [MdBlockQuoteAttribute].
class MdBlockQuoteUtility<T extends Attribute>
    extends SpecUtility<T, MdBlockQuoteAttribute> {
  /// Utility for defining [MdBlockQuoteAttribute.blockquote]
  late final textStyle = TextStyleUtility((v) => only(blockquote: v));

  /// Utility for defining [MdBlockQuoteAttribute.blockquoteDecoration]
  late final decoration =
      BoxDecorationUtility((v) => only(blockquoteDecoration: v));

  /// Utility for defining [MdBlockQuoteAttribute.blockquotePadding]
  late final padding = EdgeInsetsUtility((v) => only(blockquotePadding: v));

  /// Utility for defining [MdBlockQuoteAttribute.blockquoteContentPadding]
  late final contentPadding =
      EdgeInsetsUtility((v) => only(blockquoteContentPadding: v));

  MdBlockQuoteUtility(super.builder);

  static final self = MdBlockQuoteUtility((v) => v);

  /// Returns a new [MdBlockQuoteAttribute] with the specified properties.
  @override
  T only({
    TextStyleDto? blockquote,
    BoxDecorationDto? blockquoteDecoration,
    EdgeInsetsDto? blockquotePadding,
    EdgeInsetsDto? blockquoteContentPadding,
  }) {
    return builder(MdBlockQuoteAttribute(
      blockquote: blockquote,
      blockquoteDecoration: blockquoteDecoration,
      blockquotePadding: blockquotePadding,
      blockquoteContentPadding: blockquoteContentPadding,
    ));
  }
}

/// A tween that interpolates between two [MdBlockQuote] instances.
///
/// This class can be used in animations to smoothly transition between
/// different [MdBlockQuote] specifications.
class MdBlockQuoteTween extends Tween<MdBlockQuote?> {
  MdBlockQuoteTween({
    super.begin,
    super.end,
  });

  @override
  MdBlockQuote lerp(double t) {
    if (begin == null && end == null) return const MdBlockQuote();
    if (begin == null) return end!;

    return begin!.lerp(end!, t);
  }
}

// ignore_for_file: deprecated_member_use_from_same_package

mixin _$MdTable on Spec<MdTable> {
  static MdTable from(MixData mix) {
    return mix.attributeOf<MdTableAttribute>()?.resolve(mix) ?? const MdTable();
  }

  /// {@template md_table_of}
  /// Retrieves the [MdTable] from the nearest [Mix] ancestor in the widget tree.
  ///
  /// This method uses [Mix.of] to obtain the [Mix] instance associated with the
  /// given [BuildContext], and then retrieves the [MdTable] from that [Mix].
  /// If no ancestor [Mix] is found, this method returns an empty [MdTable].
  ///
  /// Example:
  ///
  /// ```dart
  /// final mdTable = MdTable.of(context);
  /// ```
  /// {@endtemplate}
  static MdTable of(BuildContext context) {
    return _$MdTable.from(Mix.of(context));
  }

  /// Creates a copy of this [MdTable] but with the given fields
  /// replaced with the new values.
  @override
  MdTable copyWith({
    TextStyle? table,
    TextStyle? tableHead,
    TextStyle? tableBody,
    TableBorder? tableBorder,
    BoxDecoration? tableRowDecoration,
    MarkdownAlternating? tableRowDecorationAlternating,
    EdgeInsets? tableCellPadding,
    TableColumnWidth? tableColumnWidth,
  }) {
    return MdTable(
      table: table ?? _$this.table,
      tableHead: tableHead ?? _$this.tableHead,
      tableBody: tableBody ?? _$this.tableBody,
      tableBorder: tableBorder ?? _$this.tableBorder,
      tableRowDecoration: tableRowDecoration ?? _$this.tableRowDecoration,
      tableRowDecorationAlternating:
          tableRowDecorationAlternating ?? _$this.tableRowDecorationAlternating,
      tableCellPadding: tableCellPadding ?? _$this.tableCellPadding,
      tableColumnWidth: tableColumnWidth ?? _$this.tableColumnWidth,
    );
  }

  /// Linearly interpolates between this [MdTable] and another [MdTable] based on the given parameter [t].
  ///
  /// The parameter [t] represents the interpolation factor, typically ranging from 0.0 to 1.0.
  /// When [t] is 0.0, the current [MdTable] is returned. When [t] is 1.0, the [other] [MdTable] is returned.
  /// For values of [t] between 0.0 and 1.0, an interpolated [MdTable] is returned.
  ///
  /// If [other] is null, this method returns the current [MdTable] instance.
  ///
  /// The interpolation is performed on each property of the [MdTable] using the appropriate
  /// interpolation method:
  ///
  /// - [MixHelpers.lerpTextStyle] for [table] and [tableHead] and [tableBody].
  /// - [TableBorder.lerp] for [tableBorder].
  /// - [BoxDecoration.lerp] for [tableRowDecoration].
  /// - [EdgeInsets.lerp] for [tableCellPadding].

  /// For [tableRowDecorationAlternating] and [tableColumnWidth], the interpolation is performed using a step function.
  /// If [t] is less than 0.5, the value from the current [MdTable] is used. Otherwise, the value
  /// from the [other] [MdTable] is used.
  ///
  /// This method is typically used in animations to smoothly transition between
  /// different [MdTable] configurations.
  @override
  MdTable lerp(MdTable? other, double t) {
    if (other == null) return _$this;

    return MdTable(
      table: MixHelpers.lerpTextStyle(_$this.table, other.table, t),
      tableHead: MixHelpers.lerpTextStyle(_$this.tableHead, other.tableHead, t),
      tableBody: MixHelpers.lerpTextStyle(_$this.tableBody, other.tableBody, t),
      tableBorder: TableBorder.lerp(_$this.tableBorder, other.tableBorder, t),
      tableRowDecoration: BoxDecoration.lerp(
          _$this.tableRowDecoration, other.tableRowDecoration, t),
      tableRowDecorationAlternating: t < 0.5
          ? _$this.tableRowDecorationAlternating
          : other.tableRowDecorationAlternating,
      tableCellPadding:
          EdgeInsets.lerp(_$this.tableCellPadding, other.tableCellPadding, t),
      tableColumnWidth:
          t < 0.5 ? _$this.tableColumnWidth : other.tableColumnWidth,
    );
  }

  /// The list of properties that constitute the state of this [MdTable].
  ///
  /// This property is used by the [==] operator and the [hashCode] getter to
  /// compare two [MdTable] instances for equality.
  @override
  List<Object?> get props => [
        _$this.table,
        _$this.tableHead,
        _$this.tableBody,
        _$this.tableBorder,
        _$this.tableRowDecoration,
        _$this.tableRowDecorationAlternating,
        _$this.tableCellPadding,
        _$this.tableColumnWidth,
      ];

  MdTable get _$this => this as MdTable;
}

/// Represents the attributes of a [MdTable].
///
/// This class encapsulates properties defining the layout and
/// appearance of a [MdTable].
///
/// Use this class to configure the attributes of a [MdTable] and pass it to
/// the [MdTable] constructor.
final class MdTableAttribute extends SpecAttribute<MdTable> {
  final TextStyleDto? table;
  final TextStyleDto? tableHead;
  final TextStyleDto? tableBody;
  final TableBorder? tableBorder;
  final BoxDecorationDto? tableRowDecoration;
  final MarkdownAlternating? tableRowDecorationAlternating;
  final EdgeInsetsDto? tableCellPadding;
  final TableColumnWidth? tableColumnWidth;

  const MdTableAttribute({
    this.table,
    this.tableHead,
    this.tableBody,
    this.tableBorder,
    this.tableRowDecoration,
    this.tableRowDecorationAlternating,
    this.tableCellPadding,
    this.tableColumnWidth,
  });

  /// Resolves to [MdTable] using the provided [MixData].
  ///
  /// If a property is null in the [MixData], it falls back to the
  /// default value defined in the `defaultValue` for that property.
  ///
  /// ```dart
  /// final mdTable = MdTableAttribute(...).resolve(mix);
  /// ```
  @override
  MdTable resolve(MixData mix) {
    return MdTable(
      table: table?.resolve(mix),
      tableHead: tableHead?.resolve(mix),
      tableBody: tableBody?.resolve(mix),
      tableBorder: tableBorder,
      tableRowDecoration: tableRowDecoration?.resolve(mix),
      tableRowDecorationAlternating: tableRowDecorationAlternating,
      tableCellPadding: tableCellPadding?.resolve(mix),
      tableColumnWidth: tableColumnWidth,
    );
  }

  /// Merges the properties of this [MdTableAttribute] with the properties of [other].
  ///
  /// If [other] is null, returns this instance unchanged. Otherwise, returns a new
  /// [MdTableAttribute] with the properties of [other] taking precedence over
  /// the corresponding properties of this instance.
  ///
  /// Properties from [other] that are null will fall back
  /// to the values from this instance.
  @override
  MdTableAttribute merge(MdTableAttribute? other) {
    if (other == null) return this;

    return MdTableAttribute(
      table: table?.merge(other.table) ?? other.table,
      tableHead: tableHead?.merge(other.tableHead) ?? other.tableHead,
      tableBody: tableBody?.merge(other.tableBody) ?? other.tableBody,
      tableBorder: other.tableBorder ?? tableBorder,
      tableRowDecoration: tableRowDecoration?.merge(other.tableRowDecoration) ??
          other.tableRowDecoration,
      tableRowDecorationAlternating:
          other.tableRowDecorationAlternating ?? tableRowDecorationAlternating,
      tableCellPadding: tableCellPadding?.merge(other.tableCellPadding) ??
          other.tableCellPadding,
      tableColumnWidth: other.tableColumnWidth ?? tableColumnWidth,
    );
  }

  /// The list of properties that constitute the state of this [MdTableAttribute].
  ///
  /// This property is used by the [==] operator and the [hashCode] getter to
  /// compare two [MdTableAttribute] instances for equality.
  @override
  List<Object?> get props => [
        table,
        tableHead,
        tableBody,
        tableBorder,
        tableRowDecoration,
        tableRowDecorationAlternating,
        tableCellPadding,
        tableColumnWidth,
      ];
}

/// Utility class for configuring [MdTableAttribute] properties.
///
/// This class provides methods to set individual properties of a [MdTableAttribute].
/// Use the methods of this class to configure specific properties of a [MdTableAttribute].
class MdTableUtility<T extends Attribute>
    extends SpecUtility<T, MdTableAttribute> {
  /// Utility for defining [MdTableAttribute.table]
  late final textStyle = TextStyleUtility((v) => only(table: v));

  /// Utility for defining [MdTableAttribute.tableHead]
  late final headTextStyle = TextStyleUtility((v) => only(tableHead: v));

  /// Utility for defining [MdTableAttribute.tableBody]
  late final bodyTextStyle = TextStyleUtility((v) => only(tableBody: v));

  /// Utility for defining [MdTableAttribute.tableBorder]
  late final border = TableBorderUtility((v) => only(tableBorder: v));

  /// Utility for defining [MdTableAttribute.tableRowDecoration]
  late final rowDecoration =
      BoxDecorationUtility((v) => only(tableRowDecoration: v));

  /// Utility for defining [MdTableAttribute.tableRowDecorationAlternating]
  late final rowDecorationAlternating =
      MarkdownAlternatingUtility((v) => only(tableRowDecorationAlternating: v));

  /// Utility for defining [MdTableAttribute.tableCellPadding]
  late final cellPadding = EdgeInsetsUtility((v) => only(tableCellPadding: v));

  /// Utility for defining [MdTableAttribute.tableColumnWidth]
  late final columnWidth =
      TableColumnWidthUtility((v) => only(tableColumnWidth: v));

  MdTableUtility(super.builder);

  static final self = MdTableUtility((v) => v);

  /// Returns a new [MdTableAttribute] with the specified properties.
  @override
  T only({
    TextStyleDto? table,
    TextStyleDto? tableHead,
    TextStyleDto? tableBody,
    TableBorder? tableBorder,
    BoxDecorationDto? tableRowDecoration,
    MarkdownAlternating? tableRowDecorationAlternating,
    EdgeInsetsDto? tableCellPadding,
    TableColumnWidth? tableColumnWidth,
  }) {
    return builder(MdTableAttribute(
      table: table,
      tableHead: tableHead,
      tableBody: tableBody,
      tableBorder: tableBorder,
      tableRowDecoration: tableRowDecoration,
      tableRowDecorationAlternating: tableRowDecorationAlternating,
      tableCellPadding: tableCellPadding,
      tableColumnWidth: tableColumnWidth,
    ));
  }
}

/// A tween that interpolates between two [MdTable] instances.
///
/// This class can be used in animations to smoothly transition between
/// different [MdTable] specifications.
class MdTableTween extends Tween<MdTable?> {
  MdTableTween({
    super.begin,
    super.end,
  });

  @override
  MdTable lerp(double t) {
    if (begin == null && end == null) return const MdTable();
    if (begin == null) return end!;

    return begin!.lerp(end!, t);
  }
}

// ignore_for_file: deprecated_member_use_from_same_package

mixin _$MdCode on Spec<MdCode> {
  static MdCode from(MixData mix) {
    return mix.attributeOf<MdCodeAttribute>()?.resolve(mix) ?? const MdCode();
  }

  /// {@template md_code_of}
  /// Retrieves the [MdCode] from the nearest [Mix] ancestor in the widget tree.
  ///
  /// This method uses [Mix.of] to obtain the [Mix] instance associated with the
  /// given [BuildContext], and then retrieves the [MdCode] from that [Mix].
  /// If no ancestor [Mix] is found, this method returns an empty [MdCode].
  ///
  /// Example:
  ///
  /// ```dart
  /// final mdCode = MdCode.of(context);
  /// ```
  /// {@endtemplate}
  static MdCode of(BuildContext context) {
    return _$MdCode.from(Mix.of(context));
  }

  /// Creates a copy of this [MdCode] but with the given fields
  /// replaced with the new values.
  @override
  MdCode copyWith({
    TextStyle? codeSpan,
    EdgeInsets? codeblockPadding,
    BoxDecoration? codeblockDecoration,
    Color? copyIconColor,
    TextStyle? codeBlock,
  }) {
    return MdCode(
      codeSpan: codeSpan ?? _$this.codeSpan,
      codeblockPadding: codeblockPadding ?? _$this.codeblockPadding,
      codeblockDecoration: codeblockDecoration ?? _$this.codeblockDecoration,
      copyIconColor: copyIconColor ?? _$this.copyIconColor,
      codeBlock: codeBlock ?? _$this.codeBlock,
    );
  }

  /// Linearly interpolates between this [MdCode] and another [MdCode] based on the given parameter [t].
  ///
  /// The parameter [t] represents the interpolation factor, typically ranging from 0.0 to 1.0.
  /// When [t] is 0.0, the current [MdCode] is returned. When [t] is 1.0, the [other] [MdCode] is returned.
  /// For values of [t] between 0.0 and 1.0, an interpolated [MdCode] is returned.
  ///
  /// If [other] is null, this method returns the current [MdCode] instance.
  ///
  /// The interpolation is performed on each property of the [MdCode] using the appropriate
  /// interpolation method:
  ///
  /// - [MixHelpers.lerpTextStyle] for [codeSpan] and [codeBlock].
  /// - [EdgeInsets.lerp] for [codeblockPadding].
  /// - [BoxDecoration.lerp] for [codeblockDecoration].
  /// - [Color.lerp] for [copyIconColor].

  /// For , the interpolation is performed using a step function.
  /// If [t] is less than 0.5, the value from the current [MdCode] is used. Otherwise, the value
  /// from the [other] [MdCode] is used.
  ///
  /// This method is typically used in animations to smoothly transition between
  /// different [MdCode] configurations.
  @override
  MdCode lerp(MdCode? other, double t) {
    if (other == null) return _$this;

    return MdCode(
      codeSpan: MixHelpers.lerpTextStyle(_$this.codeSpan, other.codeSpan, t),
      codeblockPadding:
          EdgeInsets.lerp(_$this.codeblockPadding, other.codeblockPadding, t),
      codeblockDecoration: BoxDecoration.lerp(
          _$this.codeblockDecoration, other.codeblockDecoration, t),
      copyIconColor: Color.lerp(_$this.copyIconColor, other.copyIconColor, t),
      codeBlock: MixHelpers.lerpTextStyle(_$this.codeBlock, other.codeBlock, t),
    );
  }

  /// The list of properties that constitute the state of this [MdCode].
  ///
  /// This property is used by the [==] operator and the [hashCode] getter to
  /// compare two [MdCode] instances for equality.
  @override
  List<Object?> get props => [
        _$this.codeSpan,
        _$this.codeblockPadding,
        _$this.codeblockDecoration,
        _$this.copyIconColor,
        _$this.codeBlock,
      ];

  MdCode get _$this => this as MdCode;
}

/// Represents the attributes of a [MdCode].
///
/// This class encapsulates properties defining the layout and
/// appearance of a [MdCode].
///
/// Use this class to configure the attributes of a [MdCode] and pass it to
/// the [MdCode] constructor.
final class MdCodeAttribute extends SpecAttribute<MdCode> {
  final TextStyleDto? codeSpan;
  final EdgeInsetsDto? codeblockPadding;
  final BoxDecorationDto? codeblockDecoration;
  final ColorDto? copyIconColor;
  final TextStyleDto? codeBlock;

  const MdCodeAttribute({
    this.codeSpan,
    this.codeblockPadding,
    this.codeblockDecoration,
    this.copyIconColor,
    this.codeBlock,
  });

  /// Resolves to [MdCode] using the provided [MixData].
  ///
  /// If a property is null in the [MixData], it falls back to the
  /// default value defined in the `defaultValue` for that property.
  ///
  /// ```dart
  /// final mdCode = MdCodeAttribute(...).resolve(mix);
  /// ```
  @override
  MdCode resolve(MixData mix) {
    return MdCode(
      codeSpan: codeSpan?.resolve(mix),
      codeblockPadding: codeblockPadding?.resolve(mix),
      codeblockDecoration: codeblockDecoration?.resolve(mix),
      copyIconColor: copyIconColor?.resolve(mix),
      codeBlock: codeBlock?.resolve(mix),
    );
  }

  /// Merges the properties of this [MdCodeAttribute] with the properties of [other].
  ///
  /// If [other] is null, returns this instance unchanged. Otherwise, returns a new
  /// [MdCodeAttribute] with the properties of [other] taking precedence over
  /// the corresponding properties of this instance.
  ///
  /// Properties from [other] that are null will fall back
  /// to the values from this instance.
  @override
  MdCodeAttribute merge(MdCodeAttribute? other) {
    if (other == null) return this;

    return MdCodeAttribute(
      codeSpan: codeSpan?.merge(other.codeSpan) ?? other.codeSpan,
      codeblockPadding: codeblockPadding?.merge(other.codeblockPadding) ??
          other.codeblockPadding,
      codeblockDecoration:
          codeblockDecoration?.merge(other.codeblockDecoration) ??
              other.codeblockDecoration,
      copyIconColor:
          copyIconColor?.merge(other.copyIconColor) ?? other.copyIconColor,
      codeBlock: codeBlock?.merge(other.codeBlock) ?? other.codeBlock,
    );
  }

  /// The list of properties that constitute the state of this [MdCodeAttribute].
  ///
  /// This property is used by the [==] operator and the [hashCode] getter to
  /// compare two [MdCodeAttribute] instances for equality.
  @override
  List<Object?> get props => [
        codeSpan,
        codeblockPadding,
        codeblockDecoration,
        copyIconColor,
        codeBlock,
      ];
}

/// Utility class for configuring [MdCodeAttribute] properties.
///
/// This class provides methods to set individual properties of a [MdCodeAttribute].
/// Use the methods of this class to configure specific properties of a [MdCodeAttribute].
class MdCodeUtility<T extends Attribute>
    extends SpecUtility<T, MdCodeAttribute> {
  /// Utility for defining [MdCodeAttribute.codeSpan]
  late final span = TextStyleUtility((v) => only(codeSpan: v));

  /// Utility for defining [MdCodeAttribute.codeblockPadding]
  late final padding = EdgeInsetsUtility((v) => only(codeblockPadding: v));

  /// Utility for defining [MdCodeAttribute.codeblockDecoration]
  late final decoration =
      BoxDecorationUtility((v) => only(codeblockDecoration: v));

  /// Utility for defining [MdCodeAttribute.copyIconColor]
  late final copyIconColor = ColorUtility((v) => only(copyIconColor: v));

  /// Utility for defining [MdCodeAttribute.codeBlock]
  late final block = TextStyleUtility((v) => only(codeBlock: v));

  MdCodeUtility(super.builder);

  static final self = MdCodeUtility((v) => v);

  /// Returns a new [MdCodeAttribute] with the specified properties.
  @override
  T only({
    TextStyleDto? codeSpan,
    EdgeInsetsDto? codeblockPadding,
    BoxDecorationDto? codeblockDecoration,
    ColorDto? copyIconColor,
    TextStyleDto? codeBlock,
  }) {
    return builder(MdCodeAttribute(
      codeSpan: codeSpan,
      codeblockPadding: codeblockPadding,
      codeblockDecoration: codeblockDecoration,
      copyIconColor: copyIconColor,
      codeBlock: codeBlock,
    ));
  }
}

/// A tween that interpolates between two [MdCode] instances.
///
/// This class can be used in animations to smoothly transition between
/// different [MdCode] specifications.
class MdCodeTween extends Tween<MdCode?> {
  MdCodeTween({
    super.begin,
    super.end,
  });

  @override
  MdCode lerp(double t) {
    if (begin == null && end == null) return const MdCode();
    if (begin == null) return end!;

    return begin!.lerp(end!, t);
  }
}

// ignore_for_file: deprecated_member_use_from_same_package

mixin _$SlideSpec on Spec<SlideSpec> {
  static SlideSpec from(MixData mix) {
    return mix.attributeOf<SlideSpecAttribute>()?.resolve(mix) ??
        const SlideSpec();
  }

  /// {@template slide_spec_of}
  /// Retrieves the [SlideSpec] from the nearest [Mix] ancestor in the widget tree.
  ///
  /// This method uses [Mix.of] to obtain the [Mix] instance associated with the
  /// given [BuildContext], and then retrieves the [SlideSpec] from that [Mix].
  /// If no ancestor [Mix] is found, this method returns an empty [SlideSpec].
  ///
  /// Example:
  ///
  /// ```dart
  /// final slideSpec = SlideSpec.of(context);
  /// ```
  /// {@endtemplate}
  static SlideSpec of(BuildContext context) {
    return _$SlideSpec.from(Mix.of(context));
  }

  /// Creates a copy of this [SlideSpec] but with the given fields
  /// replaced with the new values.
  @override
  SlideSpec copyWith({
    MdTextStyle? headline1,
    MdTextStyle? headline2,
    MdTextStyle? headline3,
    MdTextStyle? headline4,
    MdTextStyle? headline5,
    MdTextStyle? headline6,
    MdTextStyle? paragraph,
    TextStyle? link,
    double? blockSpacing,
    MdDivider? divider,
    MdBlockQuote? blockquote,
    MdList? list,
    MdTable? table,
    MdCode? code,
    BoxSpec? innerContainer,
    BoxSpec? outerContainer,
    BoxSpec? contentContainer,
    ImageSpec? image,
    AnimatedData? animated,
  }) {
    return SlideSpec(
      headline1: headline1 ?? _$this.headline1,
      headline2: headline2 ?? _$this.headline2,
      headline3: headline3 ?? _$this.headline3,
      headline4: headline4 ?? _$this.headline4,
      headline5: headline5 ?? _$this.headline5,
      headline6: headline6 ?? _$this.headline6,
      paragraph: paragraph ?? _$this.paragraph,
      link: link ?? _$this.link,
      blockSpacing: blockSpacing ?? _$this.blockSpacing,
      divider: divider ?? _$this.divider,
      blockquote: blockquote ?? _$this.blockquote,
      list: list ?? _$this.list,
      table: table ?? _$this.table,
      code: code ?? _$this.code,
      innerContainer: innerContainer ?? _$this.innerContainer,
      outerContainer: outerContainer ?? _$this.outerContainer,
      contentContainer: contentContainer ?? _$this.contentContainer,
      image: image ?? _$this.image,
      animated: animated ?? _$this.animated,
    );
  }

  /// Linearly interpolates between this [SlideSpec] and another [SlideSpec] based on the given parameter [t].
  ///
  /// The parameter [t] represents the interpolation factor, typically ranging from 0.0 to 1.0.
  /// When [t] is 0.0, the current [SlideSpec] is returned. When [t] is 1.0, the [other] [SlideSpec] is returned.
  /// For values of [t] between 0.0 and 1.0, an interpolated [SlideSpec] is returned.
  ///
  /// If [other] is null, this method returns the current [SlideSpec] instance.
  ///
  /// The interpolation is performed on each property of the [SlideSpec] using the appropriate
  /// interpolation method:
  ///
  /// - [MixHelpers.lerpTextStyle] for [link].
  /// - [MixHelpers.lerpDouble] for [blockSpacing].
  /// - [BoxSpec.lerp] for [innerContainer] and [outerContainer] and [contentContainer].
  /// - [ImageSpec.lerp] for [image].

  /// For [headline1] and [headline2] and [headline3] and [headline4] and [headline5] and [headline6] and [paragraph] and [divider] and [blockquote] and [list] and [table] and [code] and [animated], the interpolation is performed using a step function.
  /// If [t] is less than 0.5, the value from the current [SlideSpec] is used. Otherwise, the value
  /// from the [other] [SlideSpec] is used.
  ///
  /// This method is typically used in animations to smoothly transition between
  /// different [SlideSpec] configurations.
  @override
  SlideSpec lerp(SlideSpec? other, double t) {
    if (other == null) return _$this;

    return SlideSpec(
      headline1: _$this.headline1?.lerp(other.headline1, t) ?? other.headline1,
      headline2: _$this.headline2?.lerp(other.headline2, t) ?? other.headline2,
      headline3: _$this.headline3?.lerp(other.headline3, t) ?? other.headline3,
      headline4: _$this.headline4?.lerp(other.headline4, t) ?? other.headline4,
      headline5: _$this.headline5?.lerp(other.headline5, t) ?? other.headline5,
      headline6: _$this.headline6?.lerp(other.headline6, t) ?? other.headline6,
      paragraph: _$this.paragraph?.lerp(other.paragraph, t) ?? other.paragraph,
      link: MixHelpers.lerpTextStyle(_$this.link, other.link, t),
      blockSpacing:
          MixHelpers.lerpDouble(_$this.blockSpacing, other.blockSpacing, t),
      divider: _$this.divider?.lerp(other.divider, t) ?? other.divider,
      blockquote:
          _$this.blockquote?.lerp(other.blockquote, t) ?? other.blockquote,
      list: _$this.list?.lerp(other.list, t) ?? other.list,
      table: _$this.table?.lerp(other.table, t) ?? other.table,
      code: _$this.code?.lerp(other.code, t) ?? other.code,
      innerContainer: _$this.innerContainer.lerp(other.innerContainer, t),
      outerContainer: _$this.outerContainer.lerp(other.outerContainer, t),
      contentContainer: _$this.contentContainer.lerp(other.contentContainer, t),
      image: _$this.image.lerp(other.image, t),
      animated: t < 0.5 ? _$this.animated : other.animated,
    );
  }

  /// The list of properties that constitute the state of this [SlideSpec].
  ///
  /// This property is used by the [==] operator and the [hashCode] getter to
  /// compare two [SlideSpec] instances for equality.
  @override
  List<Object?> get props => [
        _$this.headline1,
        _$this.headline2,
        _$this.headline3,
        _$this.headline4,
        _$this.headline5,
        _$this.headline6,
        _$this.paragraph,
        _$this.link,
        _$this.blockSpacing,
        _$this.divider,
        _$this.blockquote,
        _$this.list,
        _$this.table,
        _$this.code,
        _$this.innerContainer,
        _$this.outerContainer,
        _$this.contentContainer,
        _$this.image,
        _$this.animated,
      ];

  SlideSpec get _$this => this as SlideSpec;
}

/// Represents the attributes of a [SlideSpec].
///
/// This class encapsulates properties defining the layout and
/// appearance of a [SlideSpec].
///
/// Use this class to configure the attributes of a [SlideSpec] and pass it to
/// the [SlideSpec] constructor.
final class SlideSpecAttribute extends SpecAttribute<SlideSpec> {
  final MdTextStyleAttribute? headline1;
  final MdTextStyleAttribute? headline2;
  final MdTextStyleAttribute? headline3;
  final MdTextStyleAttribute? headline4;
  final MdTextStyleAttribute? headline5;
  final MdTextStyleAttribute? headline6;
  final MdTextStyleAttribute? paragraph;
  final TextStyleDto? link;
  final double? blockSpacing;
  final MdDividerAttribute? divider;
  final MdBlockQuoteAttribute? blockquote;
  final MdListAttribute? list;
  final MdTableAttribute? table;
  final MdCodeAttribute? code;
  final BoxSpecAttribute? innerContainer;
  final BoxSpecAttribute? outerContainer;
  final BoxSpecAttribute? contentContainer;
  final ImageSpecAttribute? image;

  const SlideSpecAttribute({
    this.headline1,
    this.headline2,
    this.headline3,
    this.headline4,
    this.headline5,
    this.headline6,
    this.paragraph,
    this.link,
    this.blockSpacing,
    this.divider,
    this.blockquote,
    this.list,
    this.table,
    this.code,
    this.innerContainer,
    this.outerContainer,
    this.contentContainer,
    this.image,
    super.animated,
  });

  /// Resolves to [SlideSpec] using the provided [MixData].
  ///
  /// If a property is null in the [MixData], it falls back to the
  /// default value defined in the `defaultValue` for that property.
  ///
  /// ```dart
  /// final slideSpec = SlideSpecAttribute(...).resolve(mix);
  /// ```
  @override
  SlideSpec resolve(MixData mix) {
    return SlideSpec(
      headline1: headline1?.resolve(mix),
      headline2: headline2?.resolve(mix),
      headline3: headline3?.resolve(mix),
      headline4: headline4?.resolve(mix),
      headline5: headline5?.resolve(mix),
      headline6: headline6?.resolve(mix),
      paragraph: paragraph?.resolve(mix),
      link: link?.resolve(mix),
      blockSpacing: blockSpacing,
      divider: divider?.resolve(mix),
      blockquote: blockquote?.resolve(mix),
      list: list?.resolve(mix),
      table: table?.resolve(mix),
      code: code?.resolve(mix),
      innerContainer: innerContainer?.resolve(mix),
      outerContainer: outerContainer?.resolve(mix),
      contentContainer: contentContainer?.resolve(mix),
      image: image?.resolve(mix),
      animated: animated?.resolve(mix) ?? mix.animation,
    );
  }

  /// Merges the properties of this [SlideSpecAttribute] with the properties of [other].
  ///
  /// If [other] is null, returns this instance unchanged. Otherwise, returns a new
  /// [SlideSpecAttribute] with the properties of [other] taking precedence over
  /// the corresponding properties of this instance.
  ///
  /// Properties from [other] that are null will fall back
  /// to the values from this instance.
  @override
  SlideSpecAttribute merge(SlideSpecAttribute? other) {
    if (other == null) return this;

    return SlideSpecAttribute(
      headline1: headline1?.merge(other.headline1) ?? other.headline1,
      headline2: headline2?.merge(other.headline2) ?? other.headline2,
      headline3: headline3?.merge(other.headline3) ?? other.headline3,
      headline4: headline4?.merge(other.headline4) ?? other.headline4,
      headline5: headline5?.merge(other.headline5) ?? other.headline5,
      headline6: headline6?.merge(other.headline6) ?? other.headline6,
      paragraph: paragraph?.merge(other.paragraph) ?? other.paragraph,
      link: link?.merge(other.link) ?? other.link,
      blockSpacing: other.blockSpacing ?? blockSpacing,
      divider: divider?.merge(other.divider) ?? other.divider,
      blockquote: blockquote?.merge(other.blockquote) ?? other.blockquote,
      list: list?.merge(other.list) ?? other.list,
      table: table?.merge(other.table) ?? other.table,
      code: code?.merge(other.code) ?? other.code,
      innerContainer:
          innerContainer?.merge(other.innerContainer) ?? other.innerContainer,
      outerContainer:
          outerContainer?.merge(other.outerContainer) ?? other.outerContainer,
      contentContainer: contentContainer?.merge(other.contentContainer) ??
          other.contentContainer,
      image: image?.merge(other.image) ?? other.image,
      animated: animated?.merge(other.animated) ?? other.animated,
    );
  }

  /// The list of properties that constitute the state of this [SlideSpecAttribute].
  ///
  /// This property is used by the [==] operator and the [hashCode] getter to
  /// compare two [SlideSpecAttribute] instances for equality.
  @override
  List<Object?> get props => [
        headline1,
        headline2,
        headline3,
        headline4,
        headline5,
        headline6,
        paragraph,
        link,
        blockSpacing,
        divider,
        blockquote,
        list,
        table,
        code,
        innerContainer,
        outerContainer,
        contentContainer,
        image,
        animated,
      ];
}

/// Utility class for configuring [SlideSpecAttribute] properties.
///
/// This class provides methods to set individual properties of a [SlideSpecAttribute].
/// Use the methods of this class to configure specific properties of a [SlideSpecAttribute].
class SlideSpecUtility<T extends Attribute>
    extends SpecUtility<T, SlideSpecAttribute> {
  /// Utility for defining [SlideSpecAttribute.headline1]
  late final h1 = MdTextStyleUtility((v) => only(headline1: v));

  /// Utility for defining [SlideSpecAttribute.headline2]
  late final h2 = MdTextStyleUtility((v) => only(headline2: v));

  /// Utility for defining [SlideSpecAttribute.headline3]
  late final h3 = MdTextStyleUtility((v) => only(headline3: v));

  /// Utility for defining [SlideSpecAttribute.headline4]
  late final h4 = MdTextStyleUtility((v) => only(headline4: v));

  /// Utility for defining [SlideSpecAttribute.headline5]
  late final h5 = MdTextStyleUtility((v) => only(headline5: v));

  /// Utility for defining [SlideSpecAttribute.headline6]
  late final h6 = MdTextStyleUtility((v) => only(headline6: v));

  /// Utility for defining [SlideSpecAttribute.paragraph]
  late final paragraph = MdTextStyleUtility((v) => only(paragraph: v));

  /// Utility for defining [SlideSpecAttribute.link]
  late final link = TextStyleUtility((v) => only(link: v));

  /// Utility for defining [SlideSpecAttribute.blockSpacing]
  late final blockSpacing = DoubleUtility((v) => only(blockSpacing: v));

  /// Utility for defining [SlideSpecAttribute.divider]
  late final divider = MdDividerUtility((v) => only(divider: v));

  /// Utility for defining [SlideSpecAttribute.blockquote]
  late final blockquote = MdBlockQuoteUtility((v) => only(blockquote: v));

  /// Utility for defining [SlideSpecAttribute.list]
  late final list = MdListUtility((v) => only(list: v));

  /// Utility for defining [SlideSpecAttribute.table]
  late final table = MdTableUtility((v) => only(table: v));

  /// Utility for defining [SlideSpecAttribute.code]
  late final code = MdCodeUtility((v) => only(code: v));

  /// Utility for defining [SlideSpecAttribute.innerContainer]
  late final innerContainer = BoxSpecUtility((v) => only(innerContainer: v));

  /// Utility for defining [SlideSpecAttribute.outerContainer]
  late final outerContainer = BoxSpecUtility((v) => only(outerContainer: v));

  /// Utility for defining [SlideSpecAttribute.contentContainer]
  late final contentContainer =
      BoxSpecUtility((v) => only(contentContainer: v));

  /// Utility for defining [SlideSpecAttribute.image]
  late final image = ImageSpecUtility((v) => only(image: v));

  /// Utility for defining [SlideSpecAttribute.animated]
  late final animated = AnimatedUtility((v) => only(animated: v));

  SlideSpecUtility(super.builder);

  static final self = SlideSpecUtility((v) => v);

  /// Returns a new [SlideSpecAttribute] with the specified properties.
  @override
  T only({
    MdTextStyleAttribute? headline1,
    MdTextStyleAttribute? headline2,
    MdTextStyleAttribute? headline3,
    MdTextStyleAttribute? headline4,
    MdTextStyleAttribute? headline5,
    MdTextStyleAttribute? headline6,
    MdTextStyleAttribute? paragraph,
    TextStyleDto? link,
    double? blockSpacing,
    MdDividerAttribute? divider,
    MdBlockQuoteAttribute? blockquote,
    MdListAttribute? list,
    MdTableAttribute? table,
    MdCodeAttribute? code,
    BoxSpecAttribute? innerContainer,
    BoxSpecAttribute? outerContainer,
    BoxSpecAttribute? contentContainer,
    ImageSpecAttribute? image,
    AnimatedDataDto? animated,
  }) {
    return builder(SlideSpecAttribute(
      headline1: headline1,
      headline2: headline2,
      headline3: headline3,
      headline4: headline4,
      headline5: headline5,
      headline6: headline6,
      paragraph: paragraph,
      link: link,
      blockSpacing: blockSpacing,
      divider: divider,
      blockquote: blockquote,
      list: list,
      table: table,
      code: code,
      innerContainer: innerContainer,
      outerContainer: outerContainer,
      contentContainer: contentContainer,
      image: image,
      animated: animated,
    ));
  }
}

/// A tween that interpolates between two [SlideSpec] instances.
///
/// This class can be used in animations to smoothly transition between
/// different [SlideSpec] specifications.
class SlideSpecTween extends Tween<SlideSpec?> {
  SlideSpecTween({
    super.begin,
    super.end,
  });

  @override
  SlideSpec lerp(double t) {
    if (begin == null && end == null) return const SlideSpec();
    if (begin == null) return end!;

    return begin!.lerp(end!, t);
  }
}
