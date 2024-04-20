import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../components/atoms/slide_view.dart';
import '../helpers/constants.dart';
import '../models/slide_model.dart';

Map<String, Uint8List> _imageCache = {};

String getCacheKey(Slide slide, ExportQuality quality) {
  return '${slide.hashCode}_${quality.label}';
}

class SlideToImage {
  SlideToImage._();

  static SlideToImage get instance => _instance;

  static final _instance = SlideToImage._();

  Future<Uint8List> generate({
    required BuildContext context,
    ExportQuality quality = ExportQuality.good,
    required Slide slide,
  }) async {
    final key = getCacheKey(slide, quality);
    if (_imageCache.containsKey(key)) {
      return _imageCache[key]!;
    }

    final image = await getImageFromWidget(context, quality, SlideView(slide));
    final convertedImage = await getImageInBytes(image);
    image.dispose();

    _imageCache[key] = convertedImage;
    return convertedImage;
  }

  Future<ui.Image> getImageFromWidget(
    BuildContext context,
    ExportQuality quality,
    Widget child,
  ) async {
    return await fromWidgetToImage(
      child,
      pixelRatio: quality.pixelRatio,
      context: context,
      targetSize: kResolution,
    );
  }

  Future<Uint8List> getImageInBytes(ui.Image image) async {
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }
}

enum ExportQuality {
  low('Low', pixelRatio: 0.5),
  good('Good', pixelRatio: 1),
  better('Better', pixelRatio: 2),
  best('Best', pixelRatio: 3);

  const ExportQuality(this.label, {required this.pixelRatio});

  final String label;
  final double pixelRatio;
}

Future<ui.Image> fromWidgetToImage(
  Widget widget, {
  required double pixelRatio,
  required BuildContext context,
  Size? targetSize,
}) async {
  Widget child = widget;

  child = InheritedTheme.captureAll(
    context,
    MediaQuery(
      data: MediaQuery.of(context),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Theme.of(context),
        color: Colors.transparent,
        home: Scaffold(body: child),
      ),
    ),
  );

  final repaintBoundary = RenderRepaintBoundary();
  final platformDispatcher = WidgetsBinding.instance.platformDispatcher;

  final view = View.maybeOf(context) ?? platformDispatcher.views.first;
  final logicalSize = targetSize ?? view.physicalSize / view.devicePixelRatio;

  int retryCount = 5;
  bool isDirty = false;

  final renderView = RenderView(
    view: view,
    child: RenderPositionedBox(
      alignment: Alignment.center,
      child: repaintBoundary,
    ),
    configuration: ViewConfiguration(
      size: logicalSize,
      devicePixelRatio: pixelRatio,
    ),
  );

  final pipelineOwner = PipelineOwner();
  final buildOwner = BuildOwner(
    focusManager: FocusManager(),
    onBuildScheduled: () {
      isDirty = true;
    },
  );

  pipelineOwner.rootNode = renderView;
  renderView.prepareInitialFrame();

  final rootElement = RenderObjectToWidgetAdapter<RenderBox>(
    container: repaintBoundary,
    child: Directionality(
      textDirection: TextDirection.ltr,
      child: child,
    ),
  ).attachToRenderTree(buildOwner);
  ui.Image? image;
  while (retryCount > 0) {
    // await Future.delayed(const Duration(seconds: 1));
    isDirty = false;
    image = await _captureImage(
      buildOwner: buildOwner,
      rootElement: rootElement,
      pipelineOwner: pipelineOwner,
      repaintBoundary: repaintBoundary,
      pixelRatio: pixelRatio,
      logicalSize: logicalSize,
    );

    if (!isDirty) {
      break;
    }

    await Future.delayed(Durations.medium1);

    retryCount--;
  }

  try {
    buildOwner.finalizeTree();
  } catch (e) {}

  return image!;
}

Future<ui.Image?> _captureImage({
  required BuildOwner buildOwner,
  required RenderObjectToWidgetElement<RenderBox> rootElement,
  required PipelineOwner pipelineOwner,
  required RenderRepaintBoundary repaintBoundary,
  required double pixelRatio,
  required Size logicalSize,
}) async {
  buildOwner.buildScope(rootElement);
  buildOwner.finalizeTree();

  pipelineOwner.flushLayout();
  pipelineOwner.flushCompositingBits();
  pipelineOwner.flushPaint();

  return repaintBoundary.toImage(pixelRatio: pixelRatio);
}

Future<void> _waitForImagesLoaded(Element rootElement) async {
  final List<Future<void>> futures = [];

  void traverseElement(Element element) {
    if (element.widget is Image) {
      final imageProvider = (element.widget as Image).image;
      print(element.widget);
      final stream = imageProvider.resolve(ImageConfiguration.empty);
      print('Resolved ImageStream: $stream');
      final completer = Completer<void>();

      late ImageStreamListener listener;
      listener = ImageStreamListener(
        (ImageInfo image, bool synchronousCall) {
          print('Image loaded: $image');
          completer.complete();
          stream.removeListener(listener);
        },
        onError: (dynamic exception, StackTrace? stackTrace) {
          print('Image loading error: $exception');
          completer.completeError(exception, stackTrace);
          stream.removeListener(listener);
        },
      );

      stream.addListener(listener);
      futures.add(completer.future);
      print('Number of futures: ${futures.length}');
    }

    element.visitChildren(traverseElement);
  }

  rootElement.visitChildren(traverseElement);

  await Future.wait(futures);
}
