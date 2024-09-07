import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mix/mix.dart';
import 'package:superdeck_core/superdeck_core.dart';

import '../common/helpers/async_value.dart';
import '../common/styles/style.dart';
import 'deck_reference_service.dart';

/// A controller for managing deck references and associated data.
///
/// The [DeckReferenceController] fetches and provides access to reference data
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

bool _isDebug = true;

class DeckReferenceController extends ChangeNotifier {
  final _referenceService = DeckReferenceService();
  Map<String, DeckStyle> _styles = {};
  Map<String, ExampleBuilder> _examples = {};
  DeckStyle _baseStyle = DeckStyle();

  AsyncValue<ReferenceDto> _asyncData = const AsyncValue.loading();

  /// Creates a [DeckReferenceController] with the given styles and examples.
  ///
  /// The [_styles] map contains named [Style] instances that can be retrieved
  /// with [getStyle]. The [_baseStyle] is merged with the default style.
  /// The [_examples] map contains named widget builders for example slides.
  DeckReferenceController({
    required Map<String, DeckStyle> styles,
    required DeckStyle baseStyle,
    required Map<String, ExampleBuilder> examples,
  }) {
    _styles = styles;
    _baseStyle = baseStyle;
    _examples = examples;
    _loadReferences();
    _referenceService.listen(_loadReferences);
  }

  void update({
    DeckStyle? baseStyle,
    Map<String, DeckStyle>? styles,
    Map<String, ExampleBuilder>? examples,
  }) {
    if (baseStyle != null) {
      _baseStyle = baseStyle;
    }

    if (styles != null) {
      _styles = styles;
    }

    if (examples != null) {
      _examples = examples;
    }

    notifyListeners();
  }

  /// Whether reference data is currently being loaded.
  bool get isLoading => _asyncData.isLoading;

  /// Whether reference data is being refreshed after a change.
  bool get isRefreshing => _asyncData.isRefreshing;

  /// Whether an error occurred while loading reference data.
  bool get hasError => _asyncData.hasError;

  /// Whether reference data has been successfully loaded.
  bool get hasData => _asyncData.hasValue;

  /// The list of slides in the loaded reference data.
  List<Slide> get slides => _asyncData.requireData.slides;

  ReferenceDto get requireData => _asyncData.requireData;

  /// The list of assets in the loaded reference data.
  List<SlideAsset> get assets => _asyncData.requireData.assets;

  /// Retrieves the [Style] registered with the given [name].
  ///
  /// If no match is found, returns the default [_baseStyle].
  Style getStyle(String? name) {
    final style = _baseStyle.build().merge(_styles[name]?.build());
    return _isDebug ? style.applyVariant(const Variant('debug')) : style;
  }

  /// Retrieves the [ExampleBuilder] registered with the given [name].
  ///
  /// If no match is found, returns null.
  ExampleBuilder? getExampleWidget(String name) {
    return _examples[name];
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

  Future<void> _loadReferences() async {
    try {
      _asyncData = _asyncData.copyWith(status: AsyncStatus.loading);
      notifyListeners();
      final data = await _referenceService.loadReference();
      _asyncData = _asyncData.copyWith(
        status: AsyncStatus.sucess,
        data: data,
      );
    } catch (error, stackTrace) {
      _asyncData = AsyncValue.error(error, stackTrace);
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

typedef ExampleBuilder = Widget Function(
  BuildContext context,
  WidgetOptions options,
);
