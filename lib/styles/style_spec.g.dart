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

/// {@template table_cell_vertical_alignment_utility}
/// A utility class for creating [Attribute] instances from [TableCellVerticalAlignment] values.
///
/// This class extends [MixUtility] and provides methods to create [Attribute] instances
/// from predefined [TableCellVerticalAlignment] values.
/// {@endtemplate}
mixin _$TableCellVerticalAlignmentUtility<T extends Attribute>
    on MixUtility<T, TableCellVerticalAlignment> {
  /// Creates an [Attribute] instance with [TableCellVerticalAlignment.top] value.
  T top() => builder(TableCellVerticalAlignment.top);

  /// Creates an [Attribute] instance with [TableCellVerticalAlignment.middle] value.
  T middle() => builder(TableCellVerticalAlignment.middle);

  /// Creates an [Attribute] instance with [TableCellVerticalAlignment.bottom] value.
  T bottom() => builder(TableCellVerticalAlignment.bottom);

  /// Creates an [Attribute] instance with [TableCellVerticalAlignment.baseline] value.
  T baseline() => builder(TableCellVerticalAlignment.baseline);

  /// Creates an [Attribute] instance with [TableCellVerticalAlignment.fill] value.
  T fill() => builder(TableCellVerticalAlignment.fill);

  /// Creates an [Attribute] instance with [TableCellVerticalAlignment.intrinsicHeight] value.
  T intrinsicHeight() => builder(TableCellVerticalAlignment.intrinsicHeight);

  /// Creates an [Attribute] instance with the specified TableCellVerticalAlignment value.
  T call(TableCellVerticalAlignment value) => builder(value);
}

// **************************************************************************
// MixableSpecGenerator
// **************************************************************************

mixin _$MdTextSpec on Spec<MdTextSpec> {
  static MdTextSpec from(MixData mix) {
    return mix.attributeOf<MdTextSpecAttribute>()?.resolve(mix) ??
        const MdTextSpec();
  }

  /// {@template md_text_spec_of}
  /// Retrieves the [MdTextSpec] from the nearest [Mix] ancestor in the widget tree.
  ///
  /// This method uses [Mix.of] to obtain the [Mix] instance associated with the
  /// given [BuildContext], and then retrieves the [MdTextSpec] from that [Mix].
  /// If no ancestor [Mix] is found, this method returns an empty [MdTextSpec].
  ///
  /// Example:
  ///
  /// ```dart
  /// final mdTextSpec = MdTextSpec.of(context);
  /// ```
  /// {@endtemplate}
  static MdTextSpec of(BuildContext context) {
    return _$MdTextSpec.from(Mix.of(context));
  }

  /// Creates a copy of this [MdTextSpec] but with the given fields
  /// replaced with the new values.
  @override
  MdTextSpec copyWith({
    TextStyle? textStyle,
    EdgeInsets? padding,
    WrapAlignment? alignment,
  }) {
    return MdTextSpec(
      textStyle: textStyle ?? _$this.textStyle,
      padding: padding ?? _$this.padding,
      alignment: alignment ?? _$this.alignment,
    );
  }

  /// Linearly interpolates between this [MdTextSpec] and another [MdTextSpec] based on the given parameter [t].
  ///
  /// The parameter [t] represents the interpolation factor, typically ranging from 0.0 to 1.0.
  /// When [t] is 0.0, the current [MdTextSpec] is returned. When [t] is 1.0, the [other] [MdTextSpec] is returned.
  /// For values of [t] between 0.0 and 1.0, an interpolated [MdTextSpec] is returned.
  ///
  /// If [other] is null, this method returns the current [MdTextSpec] instance.
  ///
  /// The interpolation is performed on each property of the [MdTextSpec] using the appropriate
  /// interpolation method:
  ///
  /// - [MixHelpers.lerpTextStyle] for [textStyle].
  /// - [EdgeInsets.lerp] for [padding].

  /// For [alignment], the interpolation is performed using a step function.
  /// If [t] is less than 0.5, the value from the current [MdTextSpec] is used. Otherwise, the value
  /// from the [other] [MdTextSpec] is used.
  ///
  /// This method is typically used in animations to smoothly transition between
  /// different [MdTextSpec] configurations.
  @override
  MdTextSpec lerp(MdTextSpec? other, double t) {
    if (other == null) return _$this;

    return MdTextSpec(
      textStyle: MixHelpers.lerpTextStyle(_$this.textStyle, other.textStyle, t),
      padding: EdgeInsets.lerp(_$this.padding, other.padding, t),
      alignment: t < 0.5 ? _$this.alignment : other.alignment,
    );
  }

  /// The list of properties that constitute the state of this [MdTextSpec].
  ///
  /// This property is used by the [==] operator and the [hashCode] getter to
  /// compare two [MdTextSpec] instances for equality.
  @override
  List<Object?> get props => [
        _$this.textStyle,
        _$this.padding,
        _$this.alignment,
      ];

  MdTextSpec get _$this => this as MdTextSpec;
}

/// Represents the attributes of a [MdTextSpec].
///
/// This class encapsulates properties defining the layout and
/// appearance of a [MdTextSpec].
///
/// Use this class to configure the attributes of a [MdTextSpec] and pass it to
/// the [MdTextSpec] constructor.
final class MdTextSpecAttribute extends SpecAttribute<MdTextSpec> {
  final TextStyleDto? textStyle;
  final EdgeInsetsDto? padding;
  final WrapAlignment? alignment;

  const MdTextSpecAttribute({
    this.textStyle,
    this.padding,
    this.alignment,
  });

  /// Resolves to [MdTextSpec] using the provided [MixData].
  ///
  /// If a property is null in the [MixData], it falls back to the
  /// default value defined in the `defaultValue` for that property.
  ///
  /// ```dart
  /// final mdTextSpec = MdTextSpecAttribute(...).resolve(mix);
  /// ```
  @override
  MdTextSpec resolve(MixData mix) {
    return MdTextSpec(
      textStyle: textStyle?.resolve(mix),
      padding: padding?.resolve(mix),
      alignment: alignment,
    );
  }

  /// Merges the properties of this [MdTextSpecAttribute] with the properties of [other].
  ///
  /// If [other] is null, returns this instance unchanged. Otherwise, returns a new
  /// [MdTextSpecAttribute] with the properties of [other] taking precedence over
  /// the corresponding properties of this instance.
  ///
  /// Properties from [other] that are null will fall back
  /// to the values from this instance.
  @override
  MdTextSpecAttribute merge(MdTextSpecAttribute? other) {
    if (other == null) return this;

    return MdTextSpecAttribute(
      textStyle: textStyle?.merge(other.textStyle) ?? other.textStyle,
      padding: padding?.merge(other.padding) ?? other.padding,
      alignment: other.alignment ?? alignment,
    );
  }

  /// The list of properties that constitute the state of this [MdTextSpecAttribute].
  ///
  /// This property is used by the [==] operator and the [hashCode] getter to
  /// compare two [MdTextSpecAttribute] instances for equality.
  @override
  List<Object?> get props => [
        textStyle,
        padding,
        alignment,
      ];
}

/// Utility class for configuring [MdTextSpecAttribute] properties.
///
/// This class provides methods to set individual properties of a [MdTextSpecAttribute].
/// Use the methods of this class to configure specific properties of a [MdTextSpecAttribute].
class MdTextSpecUtility<T extends Attribute>
    extends SpecUtility<T, MdTextSpecAttribute> {
  /// Utility for defining [MdTextSpecAttribute.textStyle]
  late final textStyle = TextStyleUtility((v) => only(textStyle: v));

  /// Utility for defining [MdTextSpecAttribute.padding]
  late final padding = EdgeInsetsUtility((v) => only(padding: v));

  /// Utility for defining [MdTextSpecAttribute.alignment]
  late final alignment = WrapAlignmentUtility((v) => only(alignment: v));

  MdTextSpecUtility(super.builder);

  static final self = MdTextSpecUtility((v) => v);

  /// Returns a new [MdTextSpecAttribute] with the specified properties.
  @override
  T only({
    TextStyleDto? textStyle,
    EdgeInsetsDto? padding,
    WrapAlignment? alignment,
  }) {
    return builder(MdTextSpecAttribute(
      textStyle: textStyle,
      padding: padding,
      alignment: alignment,
    ));
  }
}

/// A tween that interpolates between two [MdTextSpec] instances.
///
/// This class can be used in animations to smoothly transition between
/// different [MdTextSpec] specifications.
class MdTextSpecTween extends Tween<MdTextSpec?> {
  MdTextSpecTween({
    super.begin,
    super.end,
  });

  @override
  MdTextSpec lerp(double t) {
    if (begin == null && end == null) {
      return const MdTextSpec();
    }

    if (begin == null) {
      return end!;
    }

    return begin!.lerp(end!, t);
  }
}

mixin _$MdHeadingSpec on Spec<MdHeadingSpec> {
  static MdHeadingSpec from(MixData mix) {
    return mix.attributeOf<MdHeadingSpecAttribute>()?.resolve(mix) ??
        const MdHeadingSpec();
  }

  /// {@template md_heading_spec_of}
  /// Retrieves the [MdHeadingSpec] from the nearest [Mix] ancestor in the widget tree.
  ///
  /// This method uses [Mix.of] to obtain the [Mix] instance associated with the
  /// given [BuildContext], and then retrieves the [MdHeadingSpec] from that [Mix].
  /// If no ancestor [Mix] is found, this method returns an empty [MdHeadingSpec].
  ///
  /// Example:
  ///
  /// ```dart
  /// final mdHeadingSpec = MdHeadingSpec.of(context);
  /// ```
  /// {@endtemplate}
  static MdHeadingSpec of(BuildContext context) {
    return _$MdHeadingSpec.from(Mix.of(context));
  }

  /// Creates a copy of this [MdHeadingSpec] but with the given fields
  /// replaced with the new values.
  @override
  MdHeadingSpec copyWith({
    TextStyle? textStyle,
    EdgeInsets? padding,
    WrapAlignment? align,
  }) {
    return MdHeadingSpec(
      textStyle: textStyle ?? _$this.textStyle,
      padding: padding ?? _$this.padding,
      align: align ?? _$this.align,
    );
  }

  /// Linearly interpolates between this [MdHeadingSpec] and another [MdHeadingSpec] based on the given parameter [t].
  ///
  /// The parameter [t] represents the interpolation factor, typically ranging from 0.0 to 1.0.
  /// When [t] is 0.0, the current [MdHeadingSpec] is returned. When [t] is 1.0, the [other] [MdHeadingSpec] is returned.
  /// For values of [t] between 0.0 and 1.0, an interpolated [MdHeadingSpec] is returned.
  ///
  /// If [other] is null, this method returns the current [MdHeadingSpec] instance.
  ///
  /// The interpolation is performed on each property of the [MdHeadingSpec] using the appropriate
  /// interpolation method:
  ///
  /// - [MixHelpers.lerpTextStyle] for [textStyle].
  /// - [EdgeInsets.lerp] for [padding].

  /// For [align], the interpolation is performed using a step function.
  /// If [t] is less than 0.5, the value from the current [MdHeadingSpec] is used. Otherwise, the value
  /// from the [other] [MdHeadingSpec] is used.
  ///
  /// This method is typically used in animations to smoothly transition between
  /// different [MdHeadingSpec] configurations.
  @override
  MdHeadingSpec lerp(MdHeadingSpec? other, double t) {
    if (other == null) return _$this;

    return MdHeadingSpec(
      textStyle: MixHelpers.lerpTextStyle(_$this.textStyle, other.textStyle, t),
      padding: EdgeInsets.lerp(_$this.padding, other.padding, t),
      align: t < 0.5 ? _$this.align : other.align,
    );
  }

  /// The list of properties that constitute the state of this [MdHeadingSpec].
  ///
  /// This property is used by the [==] operator and the [hashCode] getter to
  /// compare two [MdHeadingSpec] instances for equality.
  @override
  List<Object?> get props => [
        _$this.textStyle,
        _$this.padding,
        _$this.align,
      ];

  MdHeadingSpec get _$this => this as MdHeadingSpec;
}

/// Represents the attributes of a [MdHeadingSpec].
///
/// This class encapsulates properties defining the layout and
/// appearance of a [MdHeadingSpec].
///
/// Use this class to configure the attributes of a [MdHeadingSpec] and pass it to
/// the [MdHeadingSpec] constructor.
final class MdHeadingSpecAttribute extends SpecAttribute<MdHeadingSpec> {
  final TextStyleDto? textStyle;
  final EdgeInsetsDto? padding;
  final WrapAlignment? align;

  const MdHeadingSpecAttribute({
    this.textStyle,
    this.padding,
    this.align,
  });

  /// Resolves to [MdHeadingSpec] using the provided [MixData].
  ///
  /// If a property is null in the [MixData], it falls back to the
  /// default value defined in the `defaultValue` for that property.
  ///
  /// ```dart
  /// final mdHeadingSpec = MdHeadingSpecAttribute(...).resolve(mix);
  /// ```
  @override
  MdHeadingSpec resolve(MixData mix) {
    return MdHeadingSpec(
      textStyle: textStyle?.resolve(mix),
      padding: padding?.resolve(mix),
      align: align,
    );
  }

  /// Merges the properties of this [MdHeadingSpecAttribute] with the properties of [other].
  ///
  /// If [other] is null, returns this instance unchanged. Otherwise, returns a new
  /// [MdHeadingSpecAttribute] with the properties of [other] taking precedence over
  /// the corresponding properties of this instance.
  ///
  /// Properties from [other] that are null will fall back
  /// to the values from this instance.
  @override
  MdHeadingSpecAttribute merge(MdHeadingSpecAttribute? other) {
    if (other == null) return this;

    return MdHeadingSpecAttribute(
      textStyle: textStyle?.merge(other.textStyle) ?? other.textStyle,
      padding: padding?.merge(other.padding) ?? other.padding,
      align: other.align ?? align,
    );
  }

  /// The list of properties that constitute the state of this [MdHeadingSpecAttribute].
  ///
  /// This property is used by the [==] operator and the [hashCode] getter to
  /// compare two [MdHeadingSpecAttribute] instances for equality.
  @override
  List<Object?> get props => [
        textStyle,
        padding,
        align,
      ];
}

/// Utility class for configuring [MdHeadingSpecAttribute] properties.
///
/// This class provides methods to set individual properties of a [MdHeadingSpecAttribute].
/// Use the methods of this class to configure specific properties of a [MdHeadingSpecAttribute].
class MdHeadingSpecUtility<T extends Attribute>
    extends SpecUtility<T, MdHeadingSpecAttribute> {
  /// Utility for defining [MdHeadingSpecAttribute.textStyle]
  late final textStyle = TextStyleUtility((v) => only(textStyle: v));

  /// Utility for defining [MdHeadingSpecAttribute.padding]
  late final padding = EdgeInsetsUtility((v) => only(padding: v));

  /// Utility for defining [MdHeadingSpecAttribute.align]
  late final align = WrapAlignmentUtility((v) => only(align: v));

  MdHeadingSpecUtility(super.builder);

  static final self = MdHeadingSpecUtility((v) => v);

  /// Returns a new [MdHeadingSpecAttribute] with the specified properties.
  @override
  T only({
    TextStyleDto? textStyle,
    EdgeInsetsDto? padding,
    WrapAlignment? align,
  }) {
    return builder(MdHeadingSpecAttribute(
      textStyle: textStyle,
      padding: padding,
      align: align,
    ));
  }
}

/// A tween that interpolates between two [MdHeadingSpec] instances.
///
/// This class can be used in animations to smoothly transition between
/// different [MdHeadingSpec] specifications.
class MdHeadingSpecTween extends Tween<MdHeadingSpec?> {
  MdHeadingSpecTween({
    super.begin,
    super.end,
  });

  @override
  MdHeadingSpec lerp(double t) {
    if (begin == null && end == null) {
      return const MdHeadingSpec();
    }

    if (begin == null) {
      return end!;
    }

    return begin!.lerp(end!, t);
  }
}

mixin _$MdParagraphSpec on Spec<MdParagraphSpec> {
  static MdParagraphSpec from(MixData mix) {
    return mix.attributeOf<MdParagraphSpecAttribute>()?.resolve(mix) ??
        const MdParagraphSpec();
  }

  /// {@template md_paragraph_spec_of}
  /// Retrieves the [MdParagraphSpec] from the nearest [Mix] ancestor in the widget tree.
  ///
  /// This method uses [Mix.of] to obtain the [Mix] instance associated with the
  /// given [BuildContext], and then retrieves the [MdParagraphSpec] from that [Mix].
  /// If no ancestor [Mix] is found, this method returns an empty [MdParagraphSpec].
  ///
  /// Example:
  ///
  /// ```dart
  /// final mdParagraphSpec = MdParagraphSpec.of(context);
  /// ```
  /// {@endtemplate}
  static MdParagraphSpec of(BuildContext context) {
    return _$MdParagraphSpec.from(Mix.of(context));
  }

  /// Creates a copy of this [MdParagraphSpec] but with the given fields
  /// replaced with the new values.
  @override
  MdParagraphSpec copyWith({
    TextStyle? textStyle,
    EdgeInsets? padding,
  }) {
    return MdParagraphSpec(
      textStyle: textStyle ?? _$this.textStyle,
      padding: padding ?? _$this.padding,
    );
  }

  /// Linearly interpolates between this [MdParagraphSpec] and another [MdParagraphSpec] based on the given parameter [t].
  ///
  /// The parameter [t] represents the interpolation factor, typically ranging from 0.0 to 1.0.
  /// When [t] is 0.0, the current [MdParagraphSpec] is returned. When [t] is 1.0, the [other] [MdParagraphSpec] is returned.
  /// For values of [t] between 0.0 and 1.0, an interpolated [MdParagraphSpec] is returned.
  ///
  /// If [other] is null, this method returns the current [MdParagraphSpec] instance.
  ///
  /// The interpolation is performed on each property of the [MdParagraphSpec] using the appropriate
  /// interpolation method:
  ///
  /// - [MixHelpers.lerpTextStyle] for [textStyle].
  /// - [EdgeInsets.lerp] for [padding].

  /// For , the interpolation is performed using a step function.
  /// If [t] is less than 0.5, the value from the current [MdParagraphSpec] is used. Otherwise, the value
  /// from the [other] [MdParagraphSpec] is used.
  ///
  /// This method is typically used in animations to smoothly transition between
  /// different [MdParagraphSpec] configurations.
  @override
  MdParagraphSpec lerp(MdParagraphSpec? other, double t) {
    if (other == null) return _$this;

    return MdParagraphSpec(
      textStyle: MixHelpers.lerpTextStyle(_$this.textStyle, other.textStyle, t),
      padding: EdgeInsets.lerp(_$this.padding, other.padding, t),
    );
  }

  /// The list of properties that constitute the state of this [MdParagraphSpec].
  ///
  /// This property is used by the [==] operator and the [hashCode] getter to
  /// compare two [MdParagraphSpec] instances for equality.
  @override
  List<Object?> get props => [
        _$this.textStyle,
        _$this.padding,
      ];

  MdParagraphSpec get _$this => this as MdParagraphSpec;
}

/// Represents the attributes of a [MdParagraphSpec].
///
/// This class encapsulates properties defining the layout and
/// appearance of a [MdParagraphSpec].
///
/// Use this class to configure the attributes of a [MdParagraphSpec] and pass it to
/// the [MdParagraphSpec] constructor.
final class MdParagraphSpecAttribute extends SpecAttribute<MdParagraphSpec> {
  final TextStyleDto? textStyle;
  final EdgeInsetsDto? padding;

  const MdParagraphSpecAttribute({
    this.textStyle,
    this.padding,
  });

  /// Resolves to [MdParagraphSpec] using the provided [MixData].
  ///
  /// If a property is null in the [MixData], it falls back to the
  /// default value defined in the `defaultValue` for that property.
  ///
  /// ```dart
  /// final mdParagraphSpec = MdParagraphSpecAttribute(...).resolve(mix);
  /// ```
  @override
  MdParagraphSpec resolve(MixData mix) {
    return MdParagraphSpec(
      textStyle: textStyle?.resolve(mix),
      padding: padding?.resolve(mix),
    );
  }

  /// Merges the properties of this [MdParagraphSpecAttribute] with the properties of [other].
  ///
  /// If [other] is null, returns this instance unchanged. Otherwise, returns a new
  /// [MdParagraphSpecAttribute] with the properties of [other] taking precedence over
  /// the corresponding properties of this instance.
  ///
  /// Properties from [other] that are null will fall back
  /// to the values from this instance.
  @override
  MdParagraphSpecAttribute merge(MdParagraphSpecAttribute? other) {
    if (other == null) return this;

    return MdParagraphSpecAttribute(
      textStyle: textStyle?.merge(other.textStyle) ?? other.textStyle,
      padding: padding?.merge(other.padding) ?? other.padding,
    );
  }

  /// The list of properties that constitute the state of this [MdParagraphSpecAttribute].
  ///
  /// This property is used by the [==] operator and the [hashCode] getter to
  /// compare two [MdParagraphSpecAttribute] instances for equality.
  @override
  List<Object?> get props => [
        textStyle,
        padding,
      ];
}

/// Utility class for configuring [MdParagraphSpecAttribute] properties.
///
/// This class provides methods to set individual properties of a [MdParagraphSpecAttribute].
/// Use the methods of this class to configure specific properties of a [MdParagraphSpecAttribute].
class MdParagraphSpecUtility<T extends Attribute>
    extends SpecUtility<T, MdParagraphSpecAttribute> {
  /// Utility for defining [MdParagraphSpecAttribute.textStyle]
  late final textStyle = TextStyleUtility((v) => only(textStyle: v));

  /// Utility for defining [MdParagraphSpecAttribute.padding]
  late final padding = EdgeInsetsUtility((v) => only(padding: v));

  MdParagraphSpecUtility(super.builder);

  static final self = MdParagraphSpecUtility((v) => v);

  /// Returns a new [MdParagraphSpecAttribute] with the specified properties.
  @override
  T only({
    TextStyleDto? textStyle,
    EdgeInsetsDto? padding,
  }) {
    return builder(MdParagraphSpecAttribute(
      textStyle: textStyle,
      padding: padding,
    ));
  }
}

/// A tween that interpolates between two [MdParagraphSpec] instances.
///
/// This class can be used in animations to smoothly transition between
/// different [MdParagraphSpec] specifications.
class MdParagraphSpecTween extends Tween<MdParagraphSpec?> {
  MdParagraphSpecTween({
    super.begin,
    super.end,
  });

  @override
  MdParagraphSpec lerp(double t) {
    if (begin == null && end == null) {
      return const MdParagraphSpec();
    }

    if (begin == null) {
      return end!;
    }

    return begin!.lerp(end!, t);
  }
}

mixin _$MdListSpec on Spec<MdListSpec> {
  static MdListSpec from(MixData mix) {
    return mix.attributeOf<MdListSpecAttribute>()?.resolve(mix) ??
        const MdListSpec();
  }

  /// {@template md_list_spec_of}
  /// Retrieves the [MdListSpec] from the nearest [Mix] ancestor in the widget tree.
  ///
  /// This method uses [Mix.of] to obtain the [Mix] instance associated with the
  /// given [BuildContext], and then retrieves the [MdListSpec] from that [Mix].
  /// If no ancestor [Mix] is found, this method returns an empty [MdListSpec].
  ///
  /// Example:
  ///
  /// ```dart
  /// final mdListSpec = MdListSpec.of(context);
  /// ```
  /// {@endtemplate}
  static MdListSpec of(BuildContext context) {
    return _$MdListSpec.from(Mix.of(context));
  }

  /// Creates a copy of this [MdListSpec] but with the given fields
  /// replaced with the new values.
  @override
  MdListSpec copyWith({
    double? indent,
    TextStyle? bulletStyle,
    EdgeInsets? bulletPadding,
    WrapAlignment? orderedAlignment,
    WrapAlignment? unorderedAlignment,
  }) {
    return MdListSpec(
      indent: indent ?? _$this.indent,
      bulletStyle: bulletStyle ?? _$this.bulletStyle,
      bulletPadding: bulletPadding ?? _$this.bulletPadding,
      orderedAlignment: orderedAlignment ?? _$this.orderedAlignment,
      unorderedAlignment: unorderedAlignment ?? _$this.unorderedAlignment,
    );
  }

  /// Linearly interpolates between this [MdListSpec] and another [MdListSpec] based on the given parameter [t].
  ///
  /// The parameter [t] represents the interpolation factor, typically ranging from 0.0 to 1.0.
  /// When [t] is 0.0, the current [MdListSpec] is returned. When [t] is 1.0, the [other] [MdListSpec] is returned.
  /// For values of [t] between 0.0 and 1.0, an interpolated [MdListSpec] is returned.
  ///
  /// If [other] is null, this method returns the current [MdListSpec] instance.
  ///
  /// The interpolation is performed on each property of the [MdListSpec] using the appropriate
  /// interpolation method:
  ///
  /// - [MixHelpers.lerpDouble] for [indent].
  /// - [MixHelpers.lerpTextStyle] for [bulletStyle].
  /// - [EdgeInsets.lerp] for [bulletPadding].

  /// For [orderedAlignment] and [unorderedAlignment], the interpolation is performed using a step function.
  /// If [t] is less than 0.5, the value from the current [MdListSpec] is used. Otherwise, the value
  /// from the [other] [MdListSpec] is used.
  ///
  /// This method is typically used in animations to smoothly transition between
  /// different [MdListSpec] configurations.
  @override
  MdListSpec lerp(MdListSpec? other, double t) {
    if (other == null) return _$this;

    return MdListSpec(
      indent: MixHelpers.lerpDouble(_$this.indent, other.indent, t),
      bulletStyle:
          MixHelpers.lerpTextStyle(_$this.bulletStyle, other.bulletStyle, t),
      bulletPadding:
          EdgeInsets.lerp(_$this.bulletPadding, other.bulletPadding, t),
      orderedAlignment:
          t < 0.5 ? _$this.orderedAlignment : other.orderedAlignment,
      unorderedAlignment:
          t < 0.5 ? _$this.unorderedAlignment : other.unorderedAlignment,
    );
  }

  /// The list of properties that constitute the state of this [MdListSpec].
  ///
  /// This property is used by the [==] operator and the [hashCode] getter to
  /// compare two [MdListSpec] instances for equality.
  @override
  List<Object?> get props => [
        _$this.indent,
        _$this.bulletStyle,
        _$this.bulletPadding,
        _$this.orderedAlignment,
        _$this.unorderedAlignment,
      ];

  MdListSpec get _$this => this as MdListSpec;
}

/// Represents the attributes of a [MdListSpec].
///
/// This class encapsulates properties defining the layout and
/// appearance of a [MdListSpec].
///
/// Use this class to configure the attributes of a [MdListSpec] and pass it to
/// the [MdListSpec] constructor.
final class MdListSpecAttribute extends SpecAttribute<MdListSpec> {
  final double? indent;
  final TextStyleDto? bulletStyle;
  final EdgeInsetsDto? bulletPadding;
  final WrapAlignment? orderedAlignment;
  final WrapAlignment? unorderedAlignment;

  const MdListSpecAttribute({
    this.indent,
    this.bulletStyle,
    this.bulletPadding,
    this.orderedAlignment,
    this.unorderedAlignment,
  });

  /// Resolves to [MdListSpec] using the provided [MixData].
  ///
  /// If a property is null in the [MixData], it falls back to the
  /// default value defined in the `defaultValue` for that property.
  ///
  /// ```dart
  /// final mdListSpec = MdListSpecAttribute(...).resolve(mix);
  /// ```
  @override
  MdListSpec resolve(MixData mix) {
    return MdListSpec(
      indent: indent,
      bulletStyle: bulletStyle?.resolve(mix),
      bulletPadding: bulletPadding?.resolve(mix),
      orderedAlignment: orderedAlignment,
      unorderedAlignment: unorderedAlignment,
    );
  }

  /// Merges the properties of this [MdListSpecAttribute] with the properties of [other].
  ///
  /// If [other] is null, returns this instance unchanged. Otherwise, returns a new
  /// [MdListSpecAttribute] with the properties of [other] taking precedence over
  /// the corresponding properties of this instance.
  ///
  /// Properties from [other] that are null will fall back
  /// to the values from this instance.
  @override
  MdListSpecAttribute merge(MdListSpecAttribute? other) {
    if (other == null) return this;

    return MdListSpecAttribute(
      indent: other.indent ?? indent,
      bulletStyle: bulletStyle?.merge(other.bulletStyle) ?? other.bulletStyle,
      bulletPadding:
          bulletPadding?.merge(other.bulletPadding) ?? other.bulletPadding,
      orderedAlignment: other.orderedAlignment ?? orderedAlignment,
      unorderedAlignment: other.unorderedAlignment ?? unorderedAlignment,
    );
  }

  /// The list of properties that constitute the state of this [MdListSpecAttribute].
  ///
  /// This property is used by the [==] operator and the [hashCode] getter to
  /// compare two [MdListSpecAttribute] instances for equality.
  @override
  List<Object?> get props => [
        indent,
        bulletStyle,
        bulletPadding,
        orderedAlignment,
        unorderedAlignment,
      ];
}

/// Utility class for configuring [MdListSpecAttribute] properties.
///
/// This class provides methods to set individual properties of a [MdListSpecAttribute].
/// Use the methods of this class to configure specific properties of a [MdListSpecAttribute].
class MdListSpecUtility<T extends Attribute>
    extends SpecUtility<T, MdListSpecAttribute> {
  /// Utility for defining [MdListSpecAttribute.indent]
  late final indent = DoubleUtility((v) => only(indent: v));

  /// Utility for defining [MdListSpecAttribute.bulletStyle]
  late final bulletStyle = TextStyleUtility((v) => only(bulletStyle: v));

  /// Utility for defining [MdListSpecAttribute.bulletPadding]
  late final bulletPadding = EdgeInsetsUtility((v) => only(bulletPadding: v));

  /// Utility for defining [MdListSpecAttribute.orderedAlignment]
  late final orderedAlignment =
      WrapAlignmentUtility((v) => only(orderedAlignment: v));

  /// Utility for defining [MdListSpecAttribute.unorderedAlignment]
  late final unorderedAlignment =
      WrapAlignmentUtility((v) => only(unorderedAlignment: v));

  MdListSpecUtility(super.builder);

  static final self = MdListSpecUtility((v) => v);

  /// Returns a new [MdListSpecAttribute] with the specified properties.
  @override
  T only({
    double? indent,
    TextStyleDto? bulletStyle,
    EdgeInsetsDto? bulletPadding,
    WrapAlignment? orderedAlignment,
    WrapAlignment? unorderedAlignment,
  }) {
    return builder(MdListSpecAttribute(
      indent: indent,
      bulletStyle: bulletStyle,
      bulletPadding: bulletPadding,
      orderedAlignment: orderedAlignment,
      unorderedAlignment: unorderedAlignment,
    ));
  }
}

/// A tween that interpolates between two [MdListSpec] instances.
///
/// This class can be used in animations to smoothly transition between
/// different [MdListSpec] specifications.
class MdListSpecTween extends Tween<MdListSpec?> {
  MdListSpecTween({
    super.begin,
    super.end,
  });

  @override
  MdListSpec lerp(double t) {
    if (begin == null && end == null) {
      return const MdListSpec();
    }

    if (begin == null) {
      return end!;
    }

    return begin!.lerp(end!, t);
  }
}

mixin _$MdTableSpec on Spec<MdTableSpec> {
  static MdTableSpec from(MixData mix) {
    return mix.attributeOf<MdTableSpecAttribute>()?.resolve(mix) ??
        const MdTableSpec();
  }

  /// {@template md_table_spec_of}
  /// Retrieves the [MdTableSpec] from the nearest [Mix] ancestor in the widget tree.
  ///
  /// This method uses [Mix.of] to obtain the [Mix] instance associated with the
  /// given [BuildContext], and then retrieves the [MdTableSpec] from that [Mix].
  /// If no ancestor [Mix] is found, this method returns an empty [MdTableSpec].
  ///
  /// Example:
  ///
  /// ```dart
  /// final mdTableSpec = MdTableSpec.of(context);
  /// ```
  /// {@endtemplate}
  static MdTableSpec of(BuildContext context) {
    return _$MdTableSpec.from(Mix.of(context));
  }

  /// Creates a copy of this [MdTableSpec] but with the given fields
  /// replaced with the new values.
  @override
  MdTableSpec copyWith({
    TextStyle? headStyle,
    TextStyle? bodyStyle,
    TextAlign? headAlignment,
    EdgeInsets? padding,
    TableBorder? border,
    TableColumnWidth? columnWidth,
    EdgeInsets? cellPadding,
    BoxDecoration? cellDecoration,
    TableCellVerticalAlignment? verticalAlignment,
  }) {
    return MdTableSpec(
      headStyle: headStyle ?? _$this.headStyle,
      bodyStyle: bodyStyle ?? _$this.bodyStyle,
      headAlignment: headAlignment ?? _$this.headAlignment,
      padding: padding ?? _$this.padding,
      border: border ?? _$this.border,
      columnWidth: columnWidth ?? _$this.columnWidth,
      cellPadding: cellPadding ?? _$this.cellPadding,
      cellDecoration: cellDecoration ?? _$this.cellDecoration,
      verticalAlignment: verticalAlignment ?? _$this.verticalAlignment,
    );
  }

  /// Linearly interpolates between this [MdTableSpec] and another [MdTableSpec] based on the given parameter [t].
  ///
  /// The parameter [t] represents the interpolation factor, typically ranging from 0.0 to 1.0.
  /// When [t] is 0.0, the current [MdTableSpec] is returned. When [t] is 1.0, the [other] [MdTableSpec] is returned.
  /// For values of [t] between 0.0 and 1.0, an interpolated [MdTableSpec] is returned.
  ///
  /// If [other] is null, this method returns the current [MdTableSpec] instance.
  ///
  /// The interpolation is performed on each property of the [MdTableSpec] using the appropriate
  /// interpolation method:
  ///
  /// - [MixHelpers.lerpTextStyle] for [headStyle] and [bodyStyle].
  /// - [EdgeInsets.lerp] for [padding] and [cellPadding].
  /// - [TableBorder.lerp] for [border].
  /// - [BoxDecoration.lerp] for [cellDecoration].

  /// For [headAlignment] and [columnWidth] and [verticalAlignment], the interpolation is performed using a step function.
  /// If [t] is less than 0.5, the value from the current [MdTableSpec] is used. Otherwise, the value
  /// from the [other] [MdTableSpec] is used.
  ///
  /// This method is typically used in animations to smoothly transition between
  /// different [MdTableSpec] configurations.
  @override
  MdTableSpec lerp(MdTableSpec? other, double t) {
    if (other == null) return _$this;

    return MdTableSpec(
      headStyle: MixHelpers.lerpTextStyle(_$this.headStyle, other.headStyle, t),
      bodyStyle: MixHelpers.lerpTextStyle(_$this.bodyStyle, other.bodyStyle, t),
      headAlignment: t < 0.5 ? _$this.headAlignment : other.headAlignment,
      padding: EdgeInsets.lerp(_$this.padding, other.padding, t),
      border: TableBorder.lerp(_$this.border, other.border, t),
      columnWidth: t < 0.5 ? _$this.columnWidth : other.columnWidth,
      cellPadding: EdgeInsets.lerp(_$this.cellPadding, other.cellPadding, t),
      cellDecoration:
          BoxDecoration.lerp(_$this.cellDecoration, other.cellDecoration, t),
      verticalAlignment:
          t < 0.5 ? _$this.verticalAlignment : other.verticalAlignment,
    );
  }

  /// The list of properties that constitute the state of this [MdTableSpec].
  ///
  /// This property is used by the [==] operator and the [hashCode] getter to
  /// compare two [MdTableSpec] instances for equality.
  @override
  List<Object?> get props => [
        _$this.headStyle,
        _$this.bodyStyle,
        _$this.headAlignment,
        _$this.padding,
        _$this.border,
        _$this.columnWidth,
        _$this.cellPadding,
        _$this.cellDecoration,
        _$this.verticalAlignment,
      ];

  MdTableSpec get _$this => this as MdTableSpec;
}

/// Represents the attributes of a [MdTableSpec].
///
/// This class encapsulates properties defining the layout and
/// appearance of a [MdTableSpec].
///
/// Use this class to configure the attributes of a [MdTableSpec] and pass it to
/// the [MdTableSpec] constructor.
final class MdTableSpecAttribute extends SpecAttribute<MdTableSpec> {
  final TextStyleDto? headStyle;
  final TextStyleDto? bodyStyle;
  final TextAlign? headAlignment;
  final EdgeInsetsDto? padding;
  final TableBorder? border;
  final TableColumnWidth? columnWidth;
  final EdgeInsetsDto? cellPadding;
  final BoxDecorationDto? cellDecoration;
  final TableCellVerticalAlignment? verticalAlignment;

  const MdTableSpecAttribute({
    this.headStyle,
    this.bodyStyle,
    this.headAlignment,
    this.padding,
    this.border,
    this.columnWidth,
    this.cellPadding,
    this.cellDecoration,
    this.verticalAlignment,
  });

  /// Resolves to [MdTableSpec] using the provided [MixData].
  ///
  /// If a property is null in the [MixData], it falls back to the
  /// default value defined in the `defaultValue` for that property.
  ///
  /// ```dart
  /// final mdTableSpec = MdTableSpecAttribute(...).resolve(mix);
  /// ```
  @override
  MdTableSpec resolve(MixData mix) {
    return MdTableSpec(
      headStyle: headStyle?.resolve(mix),
      bodyStyle: bodyStyle?.resolve(mix),
      headAlignment: headAlignment,
      padding: padding?.resolve(mix),
      border: border,
      columnWidth: columnWidth,
      cellPadding: cellPadding?.resolve(mix),
      cellDecoration: cellDecoration?.resolve(mix),
      verticalAlignment: verticalAlignment,
    );
  }

  /// Merges the properties of this [MdTableSpecAttribute] with the properties of [other].
  ///
  /// If [other] is null, returns this instance unchanged. Otherwise, returns a new
  /// [MdTableSpecAttribute] with the properties of [other] taking precedence over
  /// the corresponding properties of this instance.
  ///
  /// Properties from [other] that are null will fall back
  /// to the values from this instance.
  @override
  MdTableSpecAttribute merge(MdTableSpecAttribute? other) {
    if (other == null) return this;

    return MdTableSpecAttribute(
      headStyle: headStyle?.merge(other.headStyle) ?? other.headStyle,
      bodyStyle: bodyStyle?.merge(other.bodyStyle) ?? other.bodyStyle,
      headAlignment: other.headAlignment ?? headAlignment,
      padding: padding?.merge(other.padding) ?? other.padding,
      border: other.border ?? border,
      columnWidth: other.columnWidth ?? columnWidth,
      cellPadding: cellPadding?.merge(other.cellPadding) ?? other.cellPadding,
      cellDecoration:
          cellDecoration?.merge(other.cellDecoration) ?? other.cellDecoration,
      verticalAlignment: other.verticalAlignment ?? verticalAlignment,
    );
  }

  /// The list of properties that constitute the state of this [MdTableSpecAttribute].
  ///
  /// This property is used by the [==] operator and the [hashCode] getter to
  /// compare two [MdTableSpecAttribute] instances for equality.
  @override
  List<Object?> get props => [
        headStyle,
        bodyStyle,
        headAlignment,
        padding,
        border,
        columnWidth,
        cellPadding,
        cellDecoration,
        verticalAlignment,
      ];
}

/// Utility class for configuring [MdTableSpecAttribute] properties.
///
/// This class provides methods to set individual properties of a [MdTableSpecAttribute].
/// Use the methods of this class to configure specific properties of a [MdTableSpecAttribute].
class MdTableSpecUtility<T extends Attribute>
    extends SpecUtility<T, MdTableSpecAttribute> {
  /// Utility for defining [MdTableSpecAttribute.headStyle]
  late final headStyle = TextStyleUtility((v) => only(headStyle: v));

  /// Utility for defining [MdTableSpecAttribute.bodyStyle]
  late final bodyStyle = TextStyleUtility((v) => only(bodyStyle: v));

  /// Utility for defining [MdTableSpecAttribute.headAlignment]
  late final headAlignment = TextAlignUtility((v) => only(headAlignment: v));

  /// Utility for defining [MdTableSpecAttribute.padding]
  late final padding = EdgeInsetsUtility((v) => only(padding: v));

  /// Utility for defining [MdTableSpecAttribute.border]
  late final border = TableBorderUtility((v) => only(border: v));

  /// Utility for defining [MdTableSpecAttribute.columnWidth]
  late final columnWidth = TableColumnWidthUtility((v) => only(columnWidth: v));

  /// Utility for defining [MdTableSpecAttribute.cellPadding]
  late final cellPadding = EdgeInsetsUtility((v) => only(cellPadding: v));

  /// Utility for defining [MdTableSpecAttribute.cellDecoration]
  late final cellDecoration =
      BoxDecorationUtility((v) => only(cellDecoration: v));

  /// Utility for defining [MdTableSpecAttribute.verticalAlignment]
  late final verticalAlignment =
      TableCellVerticalAlignmentUtility((v) => only(verticalAlignment: v));

  MdTableSpecUtility(super.builder);

  static final self = MdTableSpecUtility((v) => v);

  /// Returns a new [MdTableSpecAttribute] with the specified properties.
  @override
  T only({
    TextStyleDto? headStyle,
    TextStyleDto? bodyStyle,
    TextAlign? headAlignment,
    EdgeInsetsDto? padding,
    TableBorder? border,
    TableColumnWidth? columnWidth,
    EdgeInsetsDto? cellPadding,
    BoxDecorationDto? cellDecoration,
    TableCellVerticalAlignment? verticalAlignment,
  }) {
    return builder(MdTableSpecAttribute(
      headStyle: headStyle,
      bodyStyle: bodyStyle,
      headAlignment: headAlignment,
      padding: padding,
      border: border,
      columnWidth: columnWidth,
      cellPadding: cellPadding,
      cellDecoration: cellDecoration,
      verticalAlignment: verticalAlignment,
    ));
  }
}

/// A tween that interpolates between two [MdTableSpec] instances.
///
/// This class can be used in animations to smoothly transition between
/// different [MdTableSpec] specifications.
class MdTableSpecTween extends Tween<MdTableSpec?> {
  MdTableSpecTween({
    super.begin,
    super.end,
  });

  @override
  MdTableSpec lerp(double t) {
    if (begin == null && end == null) {
      return const MdTableSpec();
    }

    if (begin == null) {
      return end!;
    }

    return begin!.lerp(end!, t);
  }
}

mixin _$MdBlockquoteSpec on Spec<MdBlockquoteSpec> {
  static MdBlockquoteSpec from(MixData mix) {
    return mix.attributeOf<MdBlockquoteSpecAttribute>()?.resolve(mix) ??
        const MdBlockquoteSpec();
  }

  /// {@template md_blockquote_spec_of}
  /// Retrieves the [MdBlockquoteSpec] from the nearest [Mix] ancestor in the widget tree.
  ///
  /// This method uses [Mix.of] to obtain the [Mix] instance associated with the
  /// given [BuildContext], and then retrieves the [MdBlockquoteSpec] from that [Mix].
  /// If no ancestor [Mix] is found, this method returns an empty [MdBlockquoteSpec].
  ///
  /// Example:
  ///
  /// ```dart
  /// final mdBlockquoteSpec = MdBlockquoteSpec.of(context);
  /// ```
  /// {@endtemplate}
  static MdBlockquoteSpec of(BuildContext context) {
    return _$MdBlockquoteSpec.from(Mix.of(context));
  }

  /// Creates a copy of this [MdBlockquoteSpec] but with the given fields
  /// replaced with the new values.
  @override
  MdBlockquoteSpec copyWith({
    TextStyle? textStyle,
    EdgeInsets? padding,
    BoxDecoration? decoration,
    WrapAlignment? alignment,
  }) {
    return MdBlockquoteSpec(
      textStyle: textStyle ?? _$this.textStyle,
      padding: padding ?? _$this.padding,
      decoration: decoration ?? _$this.decoration,
      alignment: alignment ?? _$this.alignment,
    );
  }

  /// Linearly interpolates between this [MdBlockquoteSpec] and another [MdBlockquoteSpec] based on the given parameter [t].
  ///
  /// The parameter [t] represents the interpolation factor, typically ranging from 0.0 to 1.0.
  /// When [t] is 0.0, the current [MdBlockquoteSpec] is returned. When [t] is 1.0, the [other] [MdBlockquoteSpec] is returned.
  /// For values of [t] between 0.0 and 1.0, an interpolated [MdBlockquoteSpec] is returned.
  ///
  /// If [other] is null, this method returns the current [MdBlockquoteSpec] instance.
  ///
  /// The interpolation is performed on each property of the [MdBlockquoteSpec] using the appropriate
  /// interpolation method:
  ///
  /// - [MixHelpers.lerpTextStyle] for [textStyle].
  /// - [EdgeInsets.lerp] for [padding].
  /// - [BoxDecoration.lerp] for [decoration].

  /// For [alignment], the interpolation is performed using a step function.
  /// If [t] is less than 0.5, the value from the current [MdBlockquoteSpec] is used. Otherwise, the value
  /// from the [other] [MdBlockquoteSpec] is used.
  ///
  /// This method is typically used in animations to smoothly transition between
  /// different [MdBlockquoteSpec] configurations.
  @override
  MdBlockquoteSpec lerp(MdBlockquoteSpec? other, double t) {
    if (other == null) return _$this;

    return MdBlockquoteSpec(
      textStyle: MixHelpers.lerpTextStyle(_$this.textStyle, other.textStyle, t),
      padding: EdgeInsets.lerp(_$this.padding, other.padding, t),
      decoration: BoxDecoration.lerp(_$this.decoration, other.decoration, t),
      alignment: t < 0.5 ? _$this.alignment : other.alignment,
    );
  }

  /// The list of properties that constitute the state of this [MdBlockquoteSpec].
  ///
  /// This property is used by the [==] operator and the [hashCode] getter to
  /// compare two [MdBlockquoteSpec] instances for equality.
  @override
  List<Object?> get props => [
        _$this.textStyle,
        _$this.padding,
        _$this.decoration,
        _$this.alignment,
      ];

  MdBlockquoteSpec get _$this => this as MdBlockquoteSpec;
}

/// Represents the attributes of a [MdBlockquoteSpec].
///
/// This class encapsulates properties defining the layout and
/// appearance of a [MdBlockquoteSpec].
///
/// Use this class to configure the attributes of a [MdBlockquoteSpec] and pass it to
/// the [MdBlockquoteSpec] constructor.
final class MdBlockquoteSpecAttribute extends SpecAttribute<MdBlockquoteSpec> {
  final TextStyleDto? textStyle;
  final EdgeInsetsDto? padding;
  final BoxDecorationDto? decoration;
  final WrapAlignment? alignment;

  const MdBlockquoteSpecAttribute({
    this.textStyle,
    this.padding,
    this.decoration,
    this.alignment,
  });

  /// Resolves to [MdBlockquoteSpec] using the provided [MixData].
  ///
  /// If a property is null in the [MixData], it falls back to the
  /// default value defined in the `defaultValue` for that property.
  ///
  /// ```dart
  /// final mdBlockquoteSpec = MdBlockquoteSpecAttribute(...).resolve(mix);
  /// ```
  @override
  MdBlockquoteSpec resolve(MixData mix) {
    return MdBlockquoteSpec(
      textStyle: textStyle?.resolve(mix),
      padding: padding?.resolve(mix),
      decoration: decoration?.resolve(mix),
      alignment: alignment,
    );
  }

  /// Merges the properties of this [MdBlockquoteSpecAttribute] with the properties of [other].
  ///
  /// If [other] is null, returns this instance unchanged. Otherwise, returns a new
  /// [MdBlockquoteSpecAttribute] with the properties of [other] taking precedence over
  /// the corresponding properties of this instance.
  ///
  /// Properties from [other] that are null will fall back
  /// to the values from this instance.
  @override
  MdBlockquoteSpecAttribute merge(MdBlockquoteSpecAttribute? other) {
    if (other == null) return this;

    return MdBlockquoteSpecAttribute(
      textStyle: textStyle?.merge(other.textStyle) ?? other.textStyle,
      padding: padding?.merge(other.padding) ?? other.padding,
      decoration: decoration?.merge(other.decoration) ?? other.decoration,
      alignment: other.alignment ?? alignment,
    );
  }

  /// The list of properties that constitute the state of this [MdBlockquoteSpecAttribute].
  ///
  /// This property is used by the [==] operator and the [hashCode] getter to
  /// compare two [MdBlockquoteSpecAttribute] instances for equality.
  @override
  List<Object?> get props => [
        textStyle,
        padding,
        decoration,
        alignment,
      ];
}

/// Utility class for configuring [MdBlockquoteSpecAttribute] properties.
///
/// This class provides methods to set individual properties of a [MdBlockquoteSpecAttribute].
/// Use the methods of this class to configure specific properties of a [MdBlockquoteSpecAttribute].
class MdBlockquoteSpecUtility<T extends Attribute>
    extends SpecUtility<T, MdBlockquoteSpecAttribute> {
  /// Utility for defining [MdBlockquoteSpecAttribute.textStyle]
  late final textStyle = TextStyleUtility((v) => only(textStyle: v));

  /// Utility for defining [MdBlockquoteSpecAttribute.padding]
  late final padding = EdgeInsetsUtility((v) => only(padding: v));

  /// Utility for defining [MdBlockquoteSpecAttribute.decoration]
  late final decoration = BoxDecorationUtility((v) => only(decoration: v));

  /// Utility for defining [MdBlockquoteSpecAttribute.alignment]
  late final alignment = WrapAlignmentUtility((v) => only(alignment: v));

  MdBlockquoteSpecUtility(super.builder);

  static final self = MdBlockquoteSpecUtility((v) => v);

  /// Returns a new [MdBlockquoteSpecAttribute] with the specified properties.
  @override
  T only({
    TextStyleDto? textStyle,
    EdgeInsetsDto? padding,
    BoxDecorationDto? decoration,
    WrapAlignment? alignment,
  }) {
    return builder(MdBlockquoteSpecAttribute(
      textStyle: textStyle,
      padding: padding,
      decoration: decoration,
      alignment: alignment,
    ));
  }
}

/// A tween that interpolates between two [MdBlockquoteSpec] instances.
///
/// This class can be used in animations to smoothly transition between
/// different [MdBlockquoteSpec] specifications.
class MdBlockquoteSpecTween extends Tween<MdBlockquoteSpec?> {
  MdBlockquoteSpecTween({
    super.begin,
    super.end,
  });

  @override
  MdBlockquoteSpec lerp(double t) {
    if (begin == null && end == null) {
      return const MdBlockquoteSpec();
    }

    if (begin == null) {
      return end!;
    }

    return begin!.lerp(end!, t);
  }
}

mixin _$MdCodeblockSpec on Spec<MdCodeblockSpec> {
  static MdCodeblockSpec from(MixData mix) {
    return mix.attributeOf<MdCodeblockSpecAttribute>()?.resolve(mix) ??
        const MdCodeblockSpec();
  }

  /// {@template md_codeblock_spec_of}
  /// Retrieves the [MdCodeblockSpec] from the nearest [Mix] ancestor in the widget tree.
  ///
  /// This method uses [Mix.of] to obtain the [Mix] instance associated with the
  /// given [BuildContext], and then retrieves the [MdCodeblockSpec] from that [Mix].
  /// If no ancestor [Mix] is found, this method returns an empty [MdCodeblockSpec].
  ///
  /// Example:
  ///
  /// ```dart
  /// final mdCodeblockSpec = MdCodeblockSpec.of(context);
  /// ```
  /// {@endtemplate}
  static MdCodeblockSpec of(BuildContext context) {
    return _$MdCodeblockSpec.from(Mix.of(context));
  }

  /// Creates a copy of this [MdCodeblockSpec] but with the given fields
  /// replaced with the new values.
  @override
  MdCodeblockSpec copyWith({
    TextStyle? textStyle,
    EdgeInsets? padding,
    BoxDecoration? decoration,
    WrapAlignment? alignment,
  }) {
    return MdCodeblockSpec(
      textStyle: textStyle ?? _$this.textStyle,
      padding: padding ?? _$this.padding,
      decoration: decoration ?? _$this.decoration,
      alignment: alignment ?? _$this.alignment,
    );
  }

  /// Linearly interpolates between this [MdCodeblockSpec] and another [MdCodeblockSpec] based on the given parameter [t].
  ///
  /// The parameter [t] represents the interpolation factor, typically ranging from 0.0 to 1.0.
  /// When [t] is 0.0, the current [MdCodeblockSpec] is returned. When [t] is 1.0, the [other] [MdCodeblockSpec] is returned.
  /// For values of [t] between 0.0 and 1.0, an interpolated [MdCodeblockSpec] is returned.
  ///
  /// If [other] is null, this method returns the current [MdCodeblockSpec] instance.
  ///
  /// The interpolation is performed on each property of the [MdCodeblockSpec] using the appropriate
  /// interpolation method:
  ///
  /// - [MixHelpers.lerpTextStyle] for [textStyle].
  /// - [EdgeInsets.lerp] for [padding].
  /// - [BoxDecoration.lerp] for [decoration].

  /// For [alignment], the interpolation is performed using a step function.
  /// If [t] is less than 0.5, the value from the current [MdCodeblockSpec] is used. Otherwise, the value
  /// from the [other] [MdCodeblockSpec] is used.
  ///
  /// This method is typically used in animations to smoothly transition between
  /// different [MdCodeblockSpec] configurations.
  @override
  MdCodeblockSpec lerp(MdCodeblockSpec? other, double t) {
    if (other == null) return _$this;

    return MdCodeblockSpec(
      textStyle: MixHelpers.lerpTextStyle(_$this.textStyle, other.textStyle, t),
      padding: EdgeInsets.lerp(_$this.padding, other.padding, t),
      decoration: BoxDecoration.lerp(_$this.decoration, other.decoration, t),
      alignment: t < 0.5 ? _$this.alignment : other.alignment,
    );
  }

  /// The list of properties that constitute the state of this [MdCodeblockSpec].
  ///
  /// This property is used by the [==] operator and the [hashCode] getter to
  /// compare two [MdCodeblockSpec] instances for equality.
  @override
  List<Object?> get props => [
        _$this.textStyle,
        _$this.padding,
        _$this.decoration,
        _$this.alignment,
      ];

  MdCodeblockSpec get _$this => this as MdCodeblockSpec;
}

/// Represents the attributes of a [MdCodeblockSpec].
///
/// This class encapsulates properties defining the layout and
/// appearance of a [MdCodeblockSpec].
///
/// Use this class to configure the attributes of a [MdCodeblockSpec] and pass it to
/// the [MdCodeblockSpec] constructor.
final class MdCodeblockSpecAttribute extends SpecAttribute<MdCodeblockSpec> {
  final TextStyleDto? textStyle;
  final EdgeInsetsDto? padding;
  final BoxDecorationDto? decoration;
  final WrapAlignment? alignment;

  const MdCodeblockSpecAttribute({
    this.textStyle,
    this.padding,
    this.decoration,
    this.alignment,
  });

  /// Resolves to [MdCodeblockSpec] using the provided [MixData].
  ///
  /// If a property is null in the [MixData], it falls back to the
  /// default value defined in the `defaultValue` for that property.
  ///
  /// ```dart
  /// final mdCodeblockSpec = MdCodeblockSpecAttribute(...).resolve(mix);
  /// ```
  @override
  MdCodeblockSpec resolve(MixData mix) {
    return MdCodeblockSpec(
      textStyle: textStyle?.resolve(mix),
      padding: padding?.resolve(mix),
      decoration: decoration?.resolve(mix),
      alignment: alignment,
    );
  }

  /// Merges the properties of this [MdCodeblockSpecAttribute] with the properties of [other].
  ///
  /// If [other] is null, returns this instance unchanged. Otherwise, returns a new
  /// [MdCodeblockSpecAttribute] with the properties of [other] taking precedence over
  /// the corresponding properties of this instance.
  ///
  /// Properties from [other] that are null will fall back
  /// to the values from this instance.
  @override
  MdCodeblockSpecAttribute merge(MdCodeblockSpecAttribute? other) {
    if (other == null) return this;

    return MdCodeblockSpecAttribute(
      textStyle: textStyle?.merge(other.textStyle) ?? other.textStyle,
      padding: padding?.merge(other.padding) ?? other.padding,
      decoration: decoration?.merge(other.decoration) ?? other.decoration,
      alignment: other.alignment ?? alignment,
    );
  }

  /// The list of properties that constitute the state of this [MdCodeblockSpecAttribute].
  ///
  /// This property is used by the [==] operator and the [hashCode] getter to
  /// compare two [MdCodeblockSpecAttribute] instances for equality.
  @override
  List<Object?> get props => [
        textStyle,
        padding,
        decoration,
        alignment,
      ];
}

/// Utility class for configuring [MdCodeblockSpecAttribute] properties.
///
/// This class provides methods to set individual properties of a [MdCodeblockSpecAttribute].
/// Use the methods of this class to configure specific properties of a [MdCodeblockSpecAttribute].
class MdCodeblockSpecUtility<T extends Attribute>
    extends SpecUtility<T, MdCodeblockSpecAttribute> {
  /// Utility for defining [MdCodeblockSpecAttribute.textStyle]
  late final textStyle = TextStyleUtility((v) => only(textStyle: v));

  /// Utility for defining [MdCodeblockSpecAttribute.padding]
  late final padding = EdgeInsetsUtility((v) => only(padding: v));

  /// Utility for defining [MdCodeblockSpecAttribute.decoration]
  late final decoration = BoxDecorationUtility((v) => only(decoration: v));

  /// Utility for defining [MdCodeblockSpecAttribute.alignment]
  late final alignment = WrapAlignmentUtility((v) => only(alignment: v));

  MdCodeblockSpecUtility(super.builder);

  static final self = MdCodeblockSpecUtility((v) => v);

  /// Returns a new [MdCodeblockSpecAttribute] with the specified properties.
  @override
  T only({
    TextStyleDto? textStyle,
    EdgeInsetsDto? padding,
    BoxDecorationDto? decoration,
    WrapAlignment? alignment,
  }) {
    return builder(MdCodeblockSpecAttribute(
      textStyle: textStyle,
      padding: padding,
      decoration: decoration,
      alignment: alignment,
    ));
  }
}

/// A tween that interpolates between two [MdCodeblockSpec] instances.
///
/// This class can be used in animations to smoothly transition between
/// different [MdCodeblockSpec] specifications.
class MdCodeblockSpecTween extends Tween<MdCodeblockSpec?> {
  MdCodeblockSpecTween({
    super.begin,
    super.end,
  });

  @override
  MdCodeblockSpec lerp(double t) {
    if (begin == null && end == null) {
      return const MdCodeblockSpec();
    }

    if (begin == null) {
      return end!;
    }

    return begin!.lerp(end!, t);
  }
}

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
    MdHeadingSpec? h1,
    MdHeadingSpec? h2,
    MdHeadingSpec? h3,
    MdHeadingSpec? h4,
    MdHeadingSpec? h5,
    MdHeadingSpec? h6,
    MdParagraphSpec? paragraph,
    TextStyle? link,
    double? blockSpacing,
    MdBlockquoteSpec? blockquote,
    MdListSpec? list,
    MdTableSpec? table,
    TextStyle? checkbox,
    MdCodeblockSpec? code,
    TextStyle? a,
    TextStyle? em,
    TextStyle? strong,
    TextStyle? del,
    WrapAlignment? textAlign,
    TextStyle? img,
    BoxDecoration? horizontalRuleDecoration,
    TextScaler? textScaleFactor,
    BoxSpec? innerContainer,
    BoxSpec? outerContainer,
    BoxSpec? contentContainer,
    ImageSpec? image,
    AnimatedData? animated,
  }) {
    return SlideSpec(
      h1: h1 ?? _$this.h1,
      h2: h2 ?? _$this.h2,
      h3: h3 ?? _$this.h3,
      h4: h4 ?? _$this.h4,
      h5: h5 ?? _$this.h5,
      h6: h6 ?? _$this.h6,
      paragraph: paragraph ?? _$this.paragraph,
      link: link ?? _$this.link,
      blockSpacing: blockSpacing ?? _$this.blockSpacing,
      blockquote: blockquote ?? _$this.blockquote,
      list: list ?? _$this.list,
      table: table ?? _$this.table,
      checkbox: checkbox ?? _$this.checkbox,
      code: code ?? _$this.code,
      a: a ?? _$this.a,
      em: em ?? _$this.em,
      strong: strong ?? _$this.strong,
      del: del ?? _$this.del,
      textAlign: textAlign ?? _$this.textAlign,
      img: img ?? _$this.img,
      horizontalRuleDecoration:
          horizontalRuleDecoration ?? _$this.horizontalRuleDecoration,
      textScaleFactor: textScaleFactor ?? _$this.textScaleFactor,
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
  /// - [MixHelpers.lerpTextStyle] for [link] and [checkbox] and [a] and [em] and [strong] and [del] and [img].
  /// - [MixHelpers.lerpDouble] for [blockSpacing].
  /// - [BoxDecoration.lerp] for [horizontalRuleDecoration].

  /// For [h1] and [h2] and [h3] and [h4] and [h5] and [h6] and [paragraph] and [blockquote] and [list] and [table] and [code] and [textAlign] and [textScaleFactor] and [innerContainer] and [outerContainer] and [contentContainer] and [image] and [animated], the interpolation is performed using a step function.
  /// If [t] is less than 0.5, the value from the current [SlideSpec] is used. Otherwise, the value
  /// from the [other] [SlideSpec] is used.
  ///
  /// This method is typically used in animations to smoothly transition between
  /// different [SlideSpec] configurations.
  @override
  SlideSpec lerp(SlideSpec? other, double t) {
    if (other == null) return _$this;

    return SlideSpec(
      h1: _$this.h1?.lerp(other.h1, t) ?? other.h1,
      h2: _$this.h2?.lerp(other.h2, t) ?? other.h2,
      h3: _$this.h3?.lerp(other.h3, t) ?? other.h3,
      h4: _$this.h4?.lerp(other.h4, t) ?? other.h4,
      h5: _$this.h5?.lerp(other.h5, t) ?? other.h5,
      h6: _$this.h6?.lerp(other.h6, t) ?? other.h6,
      paragraph: _$this.paragraph?.lerp(other.paragraph, t) ?? other.paragraph,
      link: MixHelpers.lerpTextStyle(_$this.link, other.link, t),
      blockSpacing:
          MixHelpers.lerpDouble(_$this.blockSpacing, other.blockSpacing, t),
      blockquote:
          _$this.blockquote?.lerp(other.blockquote, t) ?? other.blockquote,
      list: _$this.list?.lerp(other.list, t) ?? other.list,
      table: _$this.table?.lerp(other.table, t) ?? other.table,
      checkbox: MixHelpers.lerpTextStyle(_$this.checkbox, other.checkbox, t),
      code: _$this.code?.lerp(other.code, t) ?? other.code,
      a: MixHelpers.lerpTextStyle(_$this.a, other.a, t),
      em: MixHelpers.lerpTextStyle(_$this.em, other.em, t),
      strong: MixHelpers.lerpTextStyle(_$this.strong, other.strong, t),
      del: MixHelpers.lerpTextStyle(_$this.del, other.del, t),
      textAlign: t < 0.5 ? _$this.textAlign : other.textAlign,
      img: MixHelpers.lerpTextStyle(_$this.img, other.img, t),
      horizontalRuleDecoration: BoxDecoration.lerp(
          _$this.horizontalRuleDecoration, other.horizontalRuleDecoration, t),
      textScaleFactor: t < 0.5 ? _$this.textScaleFactor : other.textScaleFactor,
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
        _$this.h1,
        _$this.h2,
        _$this.h3,
        _$this.h4,
        _$this.h5,
        _$this.h6,
        _$this.paragraph,
        _$this.link,
        _$this.blockSpacing,
        _$this.blockquote,
        _$this.list,
        _$this.table,
        _$this.checkbox,
        _$this.code,
        _$this.a,
        _$this.em,
        _$this.strong,
        _$this.del,
        _$this.textAlign,
        _$this.img,
        _$this.horizontalRuleDecoration,
        _$this.textScaleFactor,
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
  final MdHeadingSpecAttribute? h1;
  final MdHeadingSpecAttribute? h2;
  final MdHeadingSpecAttribute? h3;
  final MdHeadingSpecAttribute? h4;
  final MdHeadingSpecAttribute? h5;
  final MdHeadingSpecAttribute? h6;
  final MdParagraphSpecAttribute? paragraph;
  final TextStyleDto? link;
  final double? blockSpacing;
  final MdBlockquoteSpecAttribute? blockquote;
  final MdListSpecAttribute? list;
  final MdTableSpecAttribute? table;
  final TextStyleDto? checkbox;
  final MdCodeblockSpecAttribute? code;
  final TextStyleDto? a;
  final TextStyleDto? em;
  final TextStyleDto? strong;
  final TextStyleDto? del;
  final WrapAlignment? textAlign;
  final TextStyleDto? img;
  final BoxDecorationDto? horizontalRuleDecoration;
  final TextScaler? textScaleFactor;
  final BoxSpecAttribute? innerContainer;
  final BoxSpecAttribute? outerContainer;
  final BoxSpecAttribute? contentContainer;
  final ImageSpecAttribute? image;

  const SlideSpecAttribute({
    this.h1,
    this.h2,
    this.h3,
    this.h4,
    this.h5,
    this.h6,
    this.paragraph,
    this.link,
    this.blockSpacing,
    this.blockquote,
    this.list,
    this.table,
    this.checkbox,
    this.code,
    this.a,
    this.em,
    this.strong,
    this.del,
    this.textAlign,
    this.img,
    this.horizontalRuleDecoration,
    this.textScaleFactor,
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
      h1: h1?.resolve(mix),
      h2: h2?.resolve(mix),
      h3: h3?.resolve(mix),
      h4: h4?.resolve(mix),
      h5: h5?.resolve(mix),
      h6: h6?.resolve(mix),
      paragraph: paragraph?.resolve(mix),
      link: link?.resolve(mix),
      blockSpacing: blockSpacing,
      blockquote: blockquote?.resolve(mix),
      list: list?.resolve(mix),
      table: table?.resolve(mix),
      checkbox: checkbox?.resolve(mix),
      code: code?.resolve(mix),
      a: a?.resolve(mix),
      em: em?.resolve(mix),
      strong: strong?.resolve(mix),
      del: del?.resolve(mix),
      textAlign: textAlign,
      img: img?.resolve(mix),
      horizontalRuleDecoration: horizontalRuleDecoration?.resolve(mix),
      textScaleFactor: textScaleFactor,
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
      h1: h1?.merge(other.h1) ?? other.h1,
      h2: h2?.merge(other.h2) ?? other.h2,
      h3: h3?.merge(other.h3) ?? other.h3,
      h4: h4?.merge(other.h4) ?? other.h4,
      h5: h5?.merge(other.h5) ?? other.h5,
      h6: h6?.merge(other.h6) ?? other.h6,
      paragraph: paragraph?.merge(other.paragraph) ?? other.paragraph,
      link: link?.merge(other.link) ?? other.link,
      blockSpacing: other.blockSpacing ?? blockSpacing,
      blockquote: blockquote?.merge(other.blockquote) ?? other.blockquote,
      list: list?.merge(other.list) ?? other.list,
      table: table?.merge(other.table) ?? other.table,
      checkbox: checkbox?.merge(other.checkbox) ?? other.checkbox,
      code: code?.merge(other.code) ?? other.code,
      a: a?.merge(other.a) ?? other.a,
      em: em?.merge(other.em) ?? other.em,
      strong: strong?.merge(other.strong) ?? other.strong,
      del: del?.merge(other.del) ?? other.del,
      textAlign: other.textAlign ?? textAlign,
      img: img?.merge(other.img) ?? other.img,
      horizontalRuleDecoration:
          horizontalRuleDecoration?.merge(other.horizontalRuleDecoration) ??
              other.horizontalRuleDecoration,
      textScaleFactor: other.textScaleFactor ?? textScaleFactor,
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
        h1,
        h2,
        h3,
        h4,
        h5,
        h6,
        paragraph,
        link,
        blockSpacing,
        blockquote,
        list,
        table,
        checkbox,
        code,
        a,
        em,
        strong,
        del,
        textAlign,
        img,
        horizontalRuleDecoration,
        textScaleFactor,
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
  /// Utility for defining [SlideSpecAttribute.h1]
  late final h1 = MdHeadingSpecUtility((v) => only(h1: v));

  /// Utility for defining [SlideSpecAttribute.h2]
  late final h2 = MdHeadingSpecUtility((v) => only(h2: v));

  /// Utility for defining [SlideSpecAttribute.h3]
  late final h3 = MdHeadingSpecUtility((v) => only(h3: v));

  /// Utility for defining [SlideSpecAttribute.h4]
  late final h4 = MdHeadingSpecUtility((v) => only(h4: v));

  /// Utility for defining [SlideSpecAttribute.h5]
  late final h5 = MdHeadingSpecUtility((v) => only(h5: v));

  /// Utility for defining [SlideSpecAttribute.h6]
  late final h6 = MdHeadingSpecUtility((v) => only(h6: v));

  /// Utility for defining [SlideSpecAttribute.paragraph]
  late final paragraph = MdParagraphSpecUtility((v) => only(paragraph: v));

  /// Utility for defining [SlideSpecAttribute.link]
  late final link = TextStyleUtility((v) => only(link: v));

  /// Utility for defining [SlideSpecAttribute.blockSpacing]
  late final blockSpacing = DoubleUtility((v) => only(blockSpacing: v));

  /// Utility for defining [SlideSpecAttribute.blockquote]
  late final blockquote = MdBlockquoteSpecUtility((v) => only(blockquote: v));

  /// Utility for defining [SlideSpecAttribute.list]
  late final list = MdListSpecUtility((v) => only(list: v));

  /// Utility for defining [SlideSpecAttribute.table]
  late final table = MdTableSpecUtility((v) => only(table: v));

  /// Utility for defining [SlideSpecAttribute.checkbox]
  late final checkbox = TextStyleUtility((v) => only(checkbox: v));

  /// Utility for defining [SlideSpecAttribute.code]
  late final code = MdCodeblockSpecUtility((v) => only(code: v));

  /// Utility for defining [SlideSpecAttribute.a]
  late final a = TextStyleUtility((v) => only(a: v));

  /// Utility for defining [SlideSpecAttribute.em]
  late final em = TextStyleUtility((v) => only(em: v));

  /// Utility for defining [SlideSpecAttribute.strong]
  late final strong = TextStyleUtility((v) => only(strong: v));

  /// Utility for defining [SlideSpecAttribute.del]
  late final del = TextStyleUtility((v) => only(del: v));

  /// Utility for defining [SlideSpecAttribute.textAlign]
  late final textAlign = WrapAlignmentUtility((v) => only(textAlign: v));

  /// Utility for defining [SlideSpecAttribute.img]
  late final img = TextStyleUtility((v) => only(img: v));

  /// Utility for defining [SlideSpecAttribute.horizontalRuleDecoration]
  late final divider =
      BoxDecorationUtility((v) => only(horizontalRuleDecoration: v));

  /// Utility for defining [SlideSpecAttribute.textScaleFactor]
  late final textScaleFactor =
      TextScalerUtility((v) => only(textScaleFactor: v));

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
    MdHeadingSpecAttribute? h1,
    MdHeadingSpecAttribute? h2,
    MdHeadingSpecAttribute? h3,
    MdHeadingSpecAttribute? h4,
    MdHeadingSpecAttribute? h5,
    MdHeadingSpecAttribute? h6,
    MdParagraphSpecAttribute? paragraph,
    TextStyleDto? link,
    double? blockSpacing,
    MdBlockquoteSpecAttribute? blockquote,
    MdListSpecAttribute? list,
    MdTableSpecAttribute? table,
    TextStyleDto? checkbox,
    MdCodeblockSpecAttribute? code,
    TextStyleDto? a,
    TextStyleDto? em,
    TextStyleDto? strong,
    TextStyleDto? del,
    WrapAlignment? textAlign,
    TextStyleDto? img,
    BoxDecorationDto? horizontalRuleDecoration,
    TextScaler? textScaleFactor,
    BoxSpecAttribute? innerContainer,
    BoxSpecAttribute? outerContainer,
    BoxSpecAttribute? contentContainer,
    ImageSpecAttribute? image,
    AnimatedDataDto? animated,
  }) {
    return builder(SlideSpecAttribute(
      h1: h1,
      h2: h2,
      h3: h3,
      h4: h4,
      h5: h5,
      h6: h6,
      paragraph: paragraph,
      link: link,
      blockSpacing: blockSpacing,
      blockquote: blockquote,
      list: list,
      table: table,
      checkbox: checkbox,
      code: code,
      a: a,
      em: em,
      strong: strong,
      del: del,
      textAlign: textAlign,
      img: img,
      horizontalRuleDecoration: horizontalRuleDecoration,
      textScaleFactor: textScaleFactor,
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
    if (begin == null && end == null) {
      return const SlideSpec();
    }

    if (begin == null) {
      return end!;
    }

    return begin!.lerp(end!, t);
  }
}
