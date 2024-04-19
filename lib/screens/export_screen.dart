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
import '../components/atoms/linear_progresss_indicator_widget.dart';
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

enum ExportProcessStatus {
  idle,
  converting,
  creatingPdf,
  complete;

  const ExportProcessStatus();

  bool get isComplete => this == ExportProcessStatus.complete;
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
  final Map<int, GlobalKey> _globalKeys = {};

  late final _status = createSignal(context, ExportProcessStatus.idle);
  final _pageController = PageController();
  late List<Slide> _slides;
  late final _images = listSignal<Uint8List>([]);

  @override
  void initState() {
    super.initState();

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
      _status.value = ExportProcessStatus.converting;

      List<Future<Uint8List>> futures = [];

      Future<Uint8List> convertSlide(Slide slide) async {
        final image = await getImageFromWidget(SlideView(slide));

        final convertedImage = await getImageInBytes(image);

        image.dispose();

        _images.add(convertedImage);
        await Future.delayed(Durations.short1);

        return convertedImage;
      }

      for (var slide in _slides) {
        futures.add(convertSlide(slide));
        // _images.add(await convertSlide(slide));
      }

      final images = await Future.wait(futures);

      await Future.delayed(Durations.short1);
      _status.value = ExportProcessStatus.creatingPdf;
      await Future.delayed(Durations.short1);

      final pdf = await buildPdf(images);

      _status.value = ExportProcessStatus.complete;
      await Future.delayed(Durations.short1);

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

        await file.writeAsBytes(pdf);
      }
    } on Exception catch (e) {
      print(e.toString());
    } finally {
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
    _images.listen(
      context,
      () {
        int page;
        if (_images.length == _slides.length) {
          page = 0;
        } else {
          page = _images.length - 1;
        }
        _pageController.jumpToPage(page);
      },
    );

    return Watch.builder(builder: (context) {
      final totalSlides = _slides.length;
      final totalImages = _images.length;

      final statusLabel = switch (_status.value) {
        ExportProcessStatus.idle => 'Idle',
        ExportProcessStatus.converting => 'Converting',
        ExportProcessStatus.creatingPdf => 'Creating PDF',
        ExportProcessStatus.complete => 'Done',
      };

      List<Widget> buildChildren() {
        if (_status.value.isComplete) {
          return [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 48,
                ),
                SizedBox(width: 16),
                Text(
                  'Done',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )
          ];
        }

        return [
          Container(
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
            height: 225,
            width: 400,
            child: PageView.builder(
              controller: _pageController,
              itemCount: _images.length,
              itemBuilder: (context, index) {
                return SlideView(_slides[index]);
              },
            ),
          ),
          const SizedBox(height: 26),
          Text(
            statusLabel,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: AnimatedLinearProgressIndicator(
                  progress: totalImages / totalSlides,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                '$totalImages/$totalSlides',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          )
        ];
      }

      return Stack(
        children: [
          Container(
            color: Theme.of(context).colorScheme.background,
          ),
          Container(
            color: Colors.black.withOpacity(0.8),
            padding: const EdgeInsets.all(200),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: buildChildren(),
            ),
          ),
        ],
      );
    });
  }
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
