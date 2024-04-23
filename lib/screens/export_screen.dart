import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:signals/signals_flutter.dart';
import 'package:universal_html/html.dart' as html;

import '../../helpers/constants.dart';
import '../../models/slide_model.dart';
import '../components/atoms/linear_progresss_indicator_widget.dart';
import '../components/atoms/slide_view.dart';
import '../components/molecules/scaled_app.dart';
import '../helpers/slide_to_image.dart';
import '../superdeck.dart';

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
  late final _status = createSignal(context, ExportProcessStatus.idle);
  final _pageController = PageController();
  late List<Slide> _slides;
  late final _images = listSignal<Uint8List>([]);
  late final superdeck = SuperDeckProvider.instance;

  @override
  void initState() {
    super.initState();

    _slides = superdeck.slides.value;

    Future.delayed(Durations.medium1).then((value) => startConversion());
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> startConversion() async {
    try {
      final generator = ImageGenerationService.instance;
      _status.value = ExportProcessStatus.converting;

      List<Future<Uint8List>> futures = [];

      Future<Uint8List> convertSlide(Slide slide) async {
        final convertedImage = await generator.generate(
          context: context,
          quality: widget.quality,
          slide: slide,
        );
        _images.add(convertedImage);
        await Future.delayed(Durations.short1);

        return convertedImage;
      }

      for (var slide in _slides) {
        futures.add(convertSlide(slide));
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
                return ScaledWidget(
                  child: SlideView(
                    _slides[index],
                  ),
                );
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
