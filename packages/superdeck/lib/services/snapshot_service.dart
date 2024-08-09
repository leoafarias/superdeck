import 'dart:async';
import 'dart:developer';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../components/atoms/slide_view.dart';
import '../components/molecules/scaled_app.dart';
import '../helpers/constants.dart';
import '../providers/assets_provider.dart';
import '../providers/examples_provider.dart';
import '../providers/snapshot_provider.dart';
import '../providers/style_provider.dart';
import '../superdeck.dart';

class PDFExportController extends ChangeNotifier {
  SnapshotQuality _quality = SnapshotQuality.good;
  _ExportProcessStatus _status = _ExportProcessStatus.idle;
  List<Uint8List> _images = [];
  final scrollController = ItemScrollController();

  /// Create a map for keys and GlobalKey for each slide
  Map<String, GlobalKey> _slideKeys = {};

  List<Slide> _slides = [];

  bool get isComplete => _status == _ExportProcessStatus.complete;

  PDFExportController();

  Map<String, GlobalKey> get keys => _slideKeys;

  List<Slide> get slides => _slides;

  void set slides(List<Slide> slides) {
    _slideKeys = {for (var slide in slides) slide.key: GlobalKey()};
    _slides = slides;
    notifyListeners();
  }

  double get progress => _images.length / _slides.length;

  String get progressText => '${_images.length} / ${_slides.length}';

  SnapshotQuality get quality => _quality;

  set quality(SnapshotQuality value) {
    _quality = value;
    notifyListeners();
  }

  _ExportProcessStatus get status => _status;

  Future<void> start() async {
    _status = _ExportProcessStatus.capturing;
    notifyListeners();

    for (var i = 0; i < _slides.length; i++) {
      final isLast = i == _slides.length - 1;
      scrollController.jumpTo(
        index: i,
        // duration: Durations.short1,
        alignment: isLast ? 0.5 : 0,
      );

      await _convertSlide(i);
    }

    _status = _ExportProcessStatus.creating;
    notifyListeners();

    await Future.delayed(Durations.medium1);
    final pdf = await _buildPdf();

    _status = _ExportProcessStatus.complete;
    notifyListeners();
    await _savePdf(pdf);
  }

  Future<void> _convertSlide(int index) async {
    final slide = _slides[index];
    // Ensure the slide is fully rendered

    final image = await SnapshotService.instance.generateWithKey(
      quality: _quality,
      key: _slideKeys[slide.key]!,
    );
    _images = [..._images, image];
    notifyListeners();
  }

  Future<void> _savePdf(Uint8List pdf) async {
    final pdfFileName = 'superdeck';

    await FileSaver.instance.saveAs(
      name: pdfFileName,
      bytes: pdf,
      ext: 'pdf',
      mimeType: MimeType.pdf,
    );
  }

  Future<Uint8List> _buildPdf() async {
    final pdf = pw.Document();

    for (final imageData in _images) {
      final image = pw.MemoryImage(imageData);

      final pdfImage = pw.Image(
        image,
        width: kResolution.width,
        height: kResolution.height,
      );

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat(
            kResolution.width,
            kResolution.height,
          ),
          build: (pw.Context context) {
            return pw.Center(
              child: pdfImage,
            );
          },
        ),
      );
    }

    return pdf.save();
  }

  Widget render() {
    return ScrollablePositionedList.builder(
      itemScrollController: scrollController,
      itemBuilder: (context, index) {
        final slide = _slides[index];
        return RepaintBoundary(
          key: keys[slide.key],
          child: ScaledWidget(
            child: SlideView(slide),
          ),
        );
      },
      itemCount: _slides.length,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

enum _ExportProcessStatus {
  idle,
  capturing,
  creating,
  complete,
}

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

    // Get the size of the boundary
    final boundarySize = boundary.size;
    //  adjust the pixel ratio based on the ideal size which is kResolution
    final pixelRatio = kResolution.width / boundarySize.width;

    final image =
        await boundary.toImage(pixelRatio: quality.pixelRatio * pixelRatio);
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
    return _renderOffStage(
      widget,
      context: SnapshotRef.instance.context,
      pixelRatio: pixelRatio,
    );
  }
}

Future<Uint8List> _renderOffStage(
  Widget widget, {
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
