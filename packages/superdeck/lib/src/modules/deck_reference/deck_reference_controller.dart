import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mix/mix.dart';
import 'package:superdeck_core/superdeck_core.dart';

import '../common/helpers/async_value.dart';
import '../common/styles/style_util.dart';
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

class DeckReferenceController extends ChangeNotifier {
  final _referenceService = DeckReferenceService();
  final Map<String, Style> styles;
  final Map<String, ExampleBuilder> examples;
  final Style baseStyle;

  /// This style is the default merged with the base style.
  late final Style _style;

  AsyncValue<ReferenceDto> _asyncData = const AsyncValue.loading();

  /// Creates a [DeckReferenceController] with the given styles and examples.
  ///
  /// The [styles] map contains named [Style] instances that can be retrieved
  /// with [getStyle]. The [baseStyle] is merged with the default style.
  /// The [examples] map contains named widget builders for example slides.
  DeckReferenceController({
    required this.styles,
    required this.baseStyle,
    required this.examples,
  }) {
    _style = defaultStyle.merge(baseStyle);
    _loadReferences();
    _referenceService.listen(_loadReferences);
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

  /// The list of assets in the loaded reference data.
  List<SlideAsset> get assets => _asyncData.requireData.assets;

  /// Retrieves the [Style] registered with the given [name].
  ///
  /// If no match is found, returns the default [baseStyle].
  Style getStyle(String? name) {
    return _style.merge(styles[name]);
  }

  /// Retrieves the [ExampleBuilder] registered with the given [name].
  ///
  /// If no match is found, returns null.
  ExampleBuilder? getExampleWidget(String name) {
    return examples[name];
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

      _asyncData = _asyncData.copyWith(
        status: AsyncStatus.sucess,
        data: await _referenceService.loadReference(),
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
