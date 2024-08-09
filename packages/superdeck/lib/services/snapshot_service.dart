import 'dart:async';
import 'dart:developer';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import '../components/atoms/slide_view.dart';
import '../helpers/constants.dart';
import '../providers/assets_provider.dart';
import '../providers/examples_provider.dart';
import '../providers/snapshot_provider.dart';
import '../providers/style_provider.dart';
import '../superdeck.dart';

enum SnapshotQuality {
  low('Low', pixelRatio: 0.4),
  good('Good', pixelRatio: 1),
  better('Better', pixelRatio: 2),
  best('Best', pixelRatio: 3);

  const SnapshotQuality(this.label, {required this.pixelRatio});

  final String label;
  final double pixelRatio;
}

//
class SnapshotService {
  SnapshotService._();

  static final SnapshotService instance = SnapshotService._();

  static final _generationQueue = <String>{};
  static const _maxConcurrentGenerations = 3;

  Future<Uint8List> generate({
    required SnapshotQuality quality,
    required Slide slide,
  }) async {
    final queueKey = '${slide.key}_${quality.name.toLowerCase()}';
    try {
      while (_generationQueue.length >= _maxConcurrentGenerations) {
        await Future.delayed(Duration(
          milliseconds: math.Random().nextInt(100),
        ));
      }

      _generationQueue.add(queueKey);
      print('Generating image for slide: ${slide.key}');

      return await _fromWidgetToImage(
        SlideView(slide),
        pixelRatio: quality.pixelRatio,
        targetSize: kResolution,
      );
    } catch (e, stackTrace) {
      log('Error generating image: $e', stackTrace: stackTrace);
      rethrow;
    } finally {
      print('Finished generating image for slide: ${slide.key}');
      _generationQueue.remove(queueKey);
    }
  }

  Future<Uint8List> generateWithKey({
    required GlobalKey key,
    required SnapshotQuality quality,
  }) async {
    final boundary =
        key.currentContext!.findRenderObject() as RenderRepaintBoundary;
    final image = await boundary.toImage(pixelRatio: quality.pixelRatio);
    return _imageToUint8List(image);
  }

  Future<Uint8List> _imageToUint8List(ui.Image image) async {
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    image.dispose();
    return byteData!.buffer.asUint8List();
  }

  Future<Uint8List> _fromWidgetToImage(
    Widget widget, {
    required double pixelRatio,
    Size? targetSize,
  }) async {
    return offStage(
      widget,
      context: SnapshotRef.instance.context,
      pixelRatio: pixelRatio,
    );
  }
}

Future<Uint8List> offStage(
  Widget widget, {
  Duration? wait,
  double? pixelRatio,
  required BuildContext context,
}) async {
  /// finding the widget in the current context by the key.
  final repaintBoundary = RenderRepaintBoundary();

  bool _needsUpdate = false;

  /// create a new pipeline owner
  final pipelineOwner = PipelineOwner(
    onNeedVisualUpdate: () => _needsUpdate = true,
  );

  /// create a new build owner
  final buildOwner = BuildOwner(focusManager: FocusManager());

  final logicalSize =
      View.of(context).physicalSize / View.of(context).devicePixelRatio;
  pixelRatio ??= View.of(context).devicePixelRatio;

  final renderView = RenderView(
    view: View.of(context),
    child: RenderPositionedBox(
        alignment: Alignment.center, child: repaintBoundary),
    configuration: ViewConfiguration(
      logicalConstraints: BoxConstraints(
        maxWidth: logicalSize.width,
        maxHeight: logicalSize.height,
      ),
      physicalConstraints: BoxConstraints(
        maxWidth: logicalSize.width,
        maxHeight: logicalSize.height,
      ),
      devicePixelRatio: 1.0,
    ),
  );

  /// setting the rootNode to the renderview of the widget
  pipelineOwner.rootNode = renderView;

  /// setting the renderView to prepareInitialFrame
  renderView.prepareInitialFrame();

  /// setting the rootElement with the widget that has to be captured
  final rootElement = RenderObjectToWidgetAdapter<RenderBox>(
    container: repaintBoundary,
    child: Directionality(
      textDirection: TextDirection.ltr,
      child: StyleProvider.inherit(
        context: context,
        child: AssetsProvider.inherit(
          context: context,
          child: ExamplesProvider.inherit(
            context: context,
            child: InheritedTheme.captureAll(
              context,
              MediaQuery(
                data: MediaQuery.of(context),
                child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: Theme.of(context),
                  color: Colors.transparent,
                  home: Scaffold(body: widget),
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  ).attachToRenderTree(buildOwner);

  ///adding the rootElement to the buildScope
  buildOwner.buildScope(rootElement);

  /// finialize the buildOwner
  buildOwner.finalizeTree();

  ///Flush Layout
  pipelineOwner.flushLayout();

  /// Flush Compositing Bits
  pipelineOwner.flushCompositingBits();

  pipelineOwner.flushSemantics();

  /// Flush paint
  pipelineOwner.flushPaint();

  await Future.delayed(const Duration(milliseconds: 100));
  while (_needsUpdate) {
    _needsUpdate = false;
    await Future.delayed(const Duration(milliseconds: 250));
  }

  /// we start the createImageProcess once we have the repaintBoundry of
  /// the widget we attached to the widget tree.
  return await _createImageProcess(
    repaintBoundary: repaintBoundary,
    pixelRatio: pixelRatio,
  );
}

/// create image process
Future<Uint8List> _createImageProcess({
  required RenderRepaintBoundary repaintBoundary,
  double? pixelRatio,
}) async {
  // the boundary is converted to Image.

  final image = await repaintBoundary.toImage(pixelRatio: pixelRatio!);

  /// The raw image is converted to byte data.
  final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

  /// The byteData is converted to uInt8List image aka memory Image.
  return byteData!.buffer.asUint8List();
}
