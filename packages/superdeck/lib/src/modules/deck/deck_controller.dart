import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mix/mix.dart';
import 'package:superdeck_core/superdeck_core.dart';

import '../common/helpers/async_value.dart';
import '../common/styles/style.dart';
import 'deck_service.dart';

/// A controller for managing deck references and associated data.
///
/// The [DeckController] fetches and provides access to reference data
/// for a deck, including slides, assets, and styles. It listens for updates
/// from the [DeckReferenceService] and notifies listeners when data changes.
///
/// Usage:
///
/// ```dart
/// final deckRef = DeckReferenceController(
///   styles: {'h1': headerStyle, 'body': bodyStyle},
///   baseStyle: Style.empty(),
///   examples: {'sample': sampleBuilder},
/// );
///
/// // Access loaded data
/// final slides = deckRef.slides;
/// final headerStyle = deckRef.getStyle('h1');
/// ```

bool _isDebug = false;

abstract class SlidePart extends StatefulWidget {
  double get height;

  const SlidePart({
    super.key,
  });

  Widget build(BuildContext context);

  @override
  SlidePartState createState() => SlidePartState();
}

class SlidePartState extends State<SlidePart> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Builder(builder: (context) {
        return widget.build(context);
      }),
    );
  }
}

class DeckController extends ChangeNotifier {
  final _referenceService = DeckReferenceService();
  Map<String, DeckStyle> _styles = {};
  Map<String, WidgetBuilderWithOptions> _widgets = {};
  DeckStyle _baseStyle = DeckStyle();
  SlidePart? _header;
  SlidePart? _footer;
  final Widget? _background;
  late List<Slide> _slides;
  late List<SlideAsset> _assets;

  AsyncValue<ReferenceDto> asyncData = const AsyncValue.loading();

  /// Creates a [DeckController] with the given styles and examples.
  ///
  /// The [_styles] map contains named [Style] instances that can be retrieved
  /// with [getStyle]. The [_baseStyle] is merged with the default style.
  /// The [_widgets] map contains named widget builders for example slides.
  DeckController({
    required Map<String, DeckStyle> styles,
    required DeckStyle baseStyle,
    List<Slide> initialSlides = const [],
    List<SlideAsset> initialAssets = const [],
    required Map<String, WidgetBuilderWithOptions> widgets,
    SlidePart? header,
    SlidePart? footer,
    Widget? background,
  })  : _footer = footer,
        _header = header,
        _background = background {
    _styles = styles;
    _slides = initialSlides;
    _assets = initialAssets;

    _baseStyle = baseStyle;
    _widgets = widgets;

    loadReferences();

    _referenceService.listen(loadReferences);
  }

  void update({
    DeckStyle? baseStyle,
    Map<String, DeckStyle>? styles,
    Map<String, WidgetBuilderWithOptions>? examples,
    SlidePart? headerBuilder,
    SlidePart? footerBuilder,
    List<Slide>? slides,
  }) {
    if (baseStyle != null) {
      baseStyle = baseStyle;
    }

    if (headerBuilder != null) {
      _header = headerBuilder;
    }

    if (footerBuilder != null) {
      _footer = footerBuilder;
    }

    if (styles != null) {
      _styles = styles;
    }

    if (examples != null) {
      _widgets = examples;
    }

    if (slides != null) {
      _slides = slides;
    }

    notifyListeners();
  }

  double get totalPartsHeight {
    final headerHeight = _header?.height ?? 0;
    final footerHeight = _footer?.height ?? 0;

    return headerHeight + footerHeight;
  }

  SlidePart? get header => _header;

  SlidePart? get footer => _footer;

  static DeckController of(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<_DeckControllerProvider>();
    return provider!.controller;
  }

  Widget watch(Widget Function(BuildContext context) builder) {
    return _DeckControllerProvider(
        controller: this,
        child: Builder(
          builder: builder,
        ));
  }

  Widget buildBackground() {
    return _background ?? const SizedBox();
  }

  /// Whether reference data is currently being loaded.
  bool get isLoading => asyncData.isLoading;

  /// Whether reference data is being refreshed after a change.
  bool get isRefreshing => asyncData.isRefreshing;

  /// Whether an error occurred while loading reference data.
  bool get hasError => asyncData.hasError;

  /// Whether reference data has been successfully loaded.
  bool get hasData => asyncData.hasValue;

  /// The list of slides in the loaded reference data.
  List<Slide> get slides => _slides;

  /// The list of assets in the loaded reference data.
  List<SlideAsset> get assets => _assets;

  Slide getSlide(int index) => slides[index];

  /// Retrieves the [Style] registered with the given [name].
  ///
  /// If no match is found, returns the default [_baseStyle].
  Style getStyle(String? name) {
    final style = _baseStyle.build().merge(_styles[name]?.build());
    return _isDebug ? style.applyVariant(const Variant('debug')) : style;
  }

  /// Retrieves the [WidgetBuilderWithOptions] registered with the given [name].
  ///
  /// If no match is found, returns null.
  WidgetBuilderWithOptions? getWidget(String name) {
    return _widgets[name];
  }

  /// Retrieves the [SlideAsset] that matches the given [uri].
  ///
  /// The [targetSize] can be used to find an asset variant of a specific size.
  /// If no match is found, returns null.
  SlideAsset? getImageAsset(
    Uri uri, {
    Size? targetSize,
  }) {
    return assets.firstWhereOrNull((f) => f.matches(uri.toString()));
  }

  Future<void> loadReferences() async {
    try {
      asyncData = asyncData.copyWith(status: AsyncStatus.loading);
      notifyListeners();
      final data = await _referenceService.loadReference();
      asyncData = asyncData.copyWith(
        status: AsyncStatus.sucess,
        data: data,
      );

      _slides = data.slides;
      _assets = data.assets;
    } catch (error, stackTrace) {
      asyncData = AsyncValue.error(error, stackTrace);
    } finally {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();

    _referenceService.stop();
  }
}

typedef WidgetBuilderWithOptions = Widget Function(
  BuildContext context,
  WidgetOptions options,
);

/// An inherited notifier that provides access to a [DeckController].
///
/// This class is used internally by [_DeckControllerProvider] to propagate the
/// [DeckController] down the widget tree.
class _DeckControllerProvider extends InheritedNotifier<DeckController> {
  /// Creates a [_DeckControllerProvider] with the given [controller] and [child].
  const _DeckControllerProvider({
    required this.controller,
    required super.child,
  });

  /// The [DeckController] instance associated with this inherited notifier.
  final DeckController controller;
}
