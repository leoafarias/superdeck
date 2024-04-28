import 'dart:async';
import 'dart:developer';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import '../components/atoms/slide_view.dart';
import '../helpers/constants.dart';
import '../models/slide_model.dart';

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
class ImageGenerationService {
  bool _isDisposed = false;
  ImageGenerationService(this.context);

  final BuildContext context;

  void dispose() => _isDisposed = true;

  void checkDisposed() {
    if (_isDisposed) {
      throw Exception('ImageGenerationService is disposed');
    }
  }

  Future<Uint8List> generate({
    required SnapshotQuality quality,
    required Slide slide,
  }) async {
    try {
      final image = await _fromWidgetToImage(
        SlideView.snapshot(slide),
        context: context,
        pixelRatio: quality.pixelRatio,
        targetSize: kResolution,
      );

      return _imageToUint8List(image);
    } catch (e, stackTrace) {
      log('Error generating image: $e', stackTrace: stackTrace);
      rethrow;
    }
  }

  Future<Uint8List> _imageToUint8List(ui.Image image) async {
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    image.dispose();
    return byteData!.buffer.asUint8List();
  }

  Future<ui.Image> _fromWidgetToImage(
    Widget widget, {
    required double pixelRatio,
    required BuildContext context,
    Size? targetSize,
  }) async {
    try {
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
      final logicalSize =
          targetSize ?? view.physicalSize / view.devicePixelRatio;

      int retryCount = 10;
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

      final pipelineOwner = PipelineOwner(
        onNeedVisualUpdate: () {
          isDirty = true;
        },
      );

      final buildOwner = BuildOwner(
        focusManager: FocusManager(),
        onBuildScheduled: () {
          isDirty = true;
          log('Build scheduled');
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

      while (retryCount > 0) {
        isDirty = false;
        buildOwner.buildScope(rootElement);
        buildOwner.finalizeTree();
        pipelineOwner.flushLayout();
        pipelineOwner.flushCompositingBits();
        pipelineOwner.flushPaint();

        await Future.delayed(const Duration(milliseconds: 250));

        if (!isDirty) {
          print('completed;  ');
          break;
        }

        print('retrying...  ');

        retryCount--;
      }

      final image = await repaintBoundary.toImage(pixelRatio: pixelRatio);

      buildOwner.finalizeTree();

      return image;
    } catch (e) {
      log('Error finalizing tree: $e');
      rethrow;
    }
  }
}
