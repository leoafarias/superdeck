import 'dart:io';
import 'dart:ui' as ui;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:signals/signals_flutter.dart';
import 'package:universal_html/html.dart' as html;

import '../../helpers/constants.dart';
import '../../models/slide_model.dart';
import '../components/atoms/slide_view.dart';
import '../superdeck.dart';

enum ExportQuality {
  good('Good', pixelRatio: 1),
  better('Better', pixelRatio: 2),
  best('Best', pixelRatio: 3);

  const ExportQuality(this.label, {required this.pixelRatio});

  final String label;
  final double pixelRatio;
}

class ExportScreen extends StatefulWidget {
  const ExportScreen({super.key});

  @override
  State<ExportScreen> createState() => _ExportScreenState();
}

class _ExportScreenState extends State<ExportScreen> {
  final navigation = NavigationProvider.instance;

  late final _selectedQuality = createSignal(context, ExportQuality.good);

  Future<void> convertToPdf(BuildContext context) async {
    final lastState = navigation.sideIsOpen.value;

    navigation.sideIsOpen.value = false;

    await Future.delayed(Duration.zero);

    late OverlayEntry entry;
    void handleOnComplete() {
      entry.remove();
      navigation.sideIsOpen.value = lastState;
    }

    entry = OverlayEntry(
      maintainState: true,
      builder: (context) {
        return ExportingProcessScreen(
          onComplete: handleOnComplete,
          quality: _selectedQuality.value,
        );
      },
    );
    if (!context.mounted) return;
    Overlay.of(context).insert(entry);
  }

  void setQuality(ExportQuality? quality) {
    if (quality == null) throw Exception('Quality cannot be null');
    _selectedQuality.value = quality;
  }

  @override
  Widget build(BuildContext context) {
    final selectedQuality = _selectedQuality.watch(context);

    List<RadioListTile<ExportQuality>> buildRadioList() {
      return ExportQuality.values.map((e) {
        return RadioListTile<ExportQuality>.adaptive(
          title: Text(e.label),
          value: e,
          groupValue: selectedQuality,
          onChanged: setQuality,
        );
      }).toList();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Export'),
      ),
      body: Center(
        child: SizedBox(
          width: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'The exported file will be saved as "superdeck.pdf" in the root of your project.',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 24.0),
              const Text(
                'Select Quality:',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              ...buildRadioList(),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () => convertToPdf(context),
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ExportingProcessScreen extends StatefulWidget {
  const ExportingProcessScreen({
    super.key,
    required this.onComplete,
    required this.quality,
  });

  final void Function() onComplete;
  final ExportQuality quality;

  @override
  State<ExportingProcessScreen> createState() => _ExportingProcessScreenState();
}

class _ExportingProcessScreenState extends State<ExportingProcessScreen> {
  late final _isConverting = createSignal(context, false);
  final Map<int, GlobalKey> _globalKeys = {};
  late final _currentSlide = createSignal(context, 0);
  late final _status = createSignal(context, '');
  final _pageController = PageController();
  late List<Slide> _slides;

  @override
  void initState() {
    super.initState();
    _isConverting.value = false;
    _slides = superdeck.slides.value;
    assignGlobalKeys(_slides);
    Future.delayed(Durations.medium1).then((value) => startConversion());
  }

  void assignGlobalKeys(List<Slide> slides) {
    for (var slide in slides) {
      _globalKeys[slide.hashCode] = GlobalKey();
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<Uint8List> getImageInBytes(ui.Image image) async {
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  Future<ui.Image> getImageFromWidget(Widget child) async {
    return await fromWidgetToImage(
      child,
      pixelRatio: widget.quality.pixelRatio,
      context: context,
      targetSize: kResolution,
    );
  }

  Future<void> startConversion() async {
    try {
      _isConverting.value = true;

      List<ui.Image> images = [];
      List<Uint8List> bytes = [];
      _currentSlide.value = 0;
      await Future.delayed(Duration.zero);

      for (var slide in _slides) {
        _currentSlide.value++;
        _status.value =
            'Extracting slide ${_currentSlide.value} of ${_slides.length}';
        // await Future.delayed(Durations.short1);
        await Future.delayed(Duration.zero);
        final image = await getImageFromWidget(SlideView(slide));
        images.add(image);
      }

      _currentSlide.value = 0;
      await Future.delayed(Durations.short1);

      for (var image in images) {
        _currentSlide.value++;
        _status.value =
            'Converting slide ${_currentSlide.value} of ${_slides.length}';
        await Future.delayed(Duration.zero);
        bytes.add(await getImageInBytes(image));
      }

      _status.value = 'Building PDF...';
      await Future.delayed(Durations.short1);

      final pdf = await buildPdf(bytes);

      if (kIsWeb) {
        // Create a Blob from the PDF bytes
        final blob = html.Blob([pdf], 'application/pdf');

        // Create a URL for the Blob
        final url = html.Url.createObjectUrlFromBlob(blob);

        html.AnchorElement(href: url)
          ..setAttribute('download', 'superdeck.pdf')
          ..click();

        return;
      }

      final outputFile = await FilePicker.platform.saveFile(
        dialogTitle: 'Save PDF',
        fileName: 'superdeck.pdf',
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
      if (outputFile != null) {
        File file = File(outputFile);
        _status.value = 'Saving...';

        await file.writeAsBytes(pdf);
      }

      _currentSlide.value = 0;
    } on Exception catch (e) {
      print(e.toString());
    } finally {
      _isConverting.value = false;
      widget.onComplete();
    }
  }

  Future<Uint8List> buildPdf(List<Uint8List> images) async {
    final pdf = pw.Document();

    for (final imageData in images) {
      final image = pw.MemoryImage(imageData);

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat(
            kResolution.width,
            kResolution.height,
          ),
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Image(
                image,
                width: kResolution.width,
                height: kResolution.height,
              ),
            );
          },
        ),
      );
    }

    return pdf.save();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.black,
          padding: const EdgeInsets.all(200),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _status.value,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              SmoothLinearProgressIndicator(
                progress: _currentSlide.value / _slides.length,
              )
            ],
          ),
        ),
      ],
    );
  }
}

class SmoothLinearProgressIndicator extends StatefulWidget {
  final double progress;

  const SmoothLinearProgressIndicator({super.key, required this.progress});

  @override
  _SmoothLinearProgressIndicatorState createState() =>
      _SmoothLinearProgressIndicatorState();
}

class _SmoothLinearProgressIndicatorState
    extends State<SmoothLinearProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _animation = Tween<double>(begin: 0.0, end: widget.progress)
        .animate(_animationController);
    _animationController.forward();
  }

  @override
  void didUpdateWidget(covariant SmoothLinearProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.progress != oldWidget.progress) {
      _animation = Tween<double>(
        begin: _animation.value,
        end: widget.progress,
      ).animate(_animationController);
      _animationController.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return LinearProgressIndicator(
          minHeight: 10,
          borderRadius: BorderRadius.circular(10),
          value: _animation.value,
        );
      },
    );
  }
}

Future<ui.Image> fromWidgetToImage(
  Widget widget, {
  Duration delay = Durations.short1,
  double pixelRatio = 1.0,
  required BuildContext context,
  Size? targetSize,
}) async {
  Widget child = widget;

  child = InheritedTheme.captureAll(
    context,
    MediaQuery(
      data: MediaQuery.of(context),
      child: MaterialApp(
        theme: Theme.of(context),
        color: Colors.transparent,
        home: child,
      ),
    ),
  );

  final repaintBoundary = RenderRepaintBoundary();
  // final platformDispatcher = WidgetsBinding.instance.platformDispatcher;
  // final fallBackView = platformDispatcher.views.first;
  final view = View.of(context);
  final logicalSize = targetSize ?? view.physicalSize / view.devicePixelRatio;

  int retryCount = 3;
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
    isDirty = false;
    image = await _captureImage(
      buildOwner: buildOwner,
      rootElement: rootElement,
      pipelineOwner: pipelineOwner,
      repaintBoundary: repaintBoundary,
      pixelRatio: pixelRatio,
      logicalSize: logicalSize,
      delay: delay,
    );

    if (!isDirty) {
      break;
    }

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
  required Duration delay,
}) async {
  buildOwner.buildScope(rootElement);
  buildOwner.finalizeTree();

  pipelineOwner.flushLayout();
  pipelineOwner.flushCompositingBits();
  pipelineOwner.flushPaint();

  await Future.delayed(delay);

  return repaintBoundary.toImage(pixelRatio: pixelRatio);
}
