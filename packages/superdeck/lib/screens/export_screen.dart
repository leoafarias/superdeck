import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:universal_html/html.dart' as html;

import '../../helpers/constants.dart';
import '../components/atoms/linear_progresss_indicator_widget.dart';
import '../components/atoms/slide_view.dart';
import '../components/molecules/scaled_app.dart';
import '../services/snapshot_service.dart';
import '../superdeck.dart';

enum ExportProcessStatus {
  idle,
  converting,
  creatingPdf,
  complete;

  const ExportProcessStatus();

  bool get isComplete => this == ExportProcessStatus.complete;
}

class ExportScreen extends HookWidget {
  const ExportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedQuality = useState(SnapshotQuality.good);

    final navigation = useNavigation();
    final convertToPdf = useCallback(() async {
      final lastState = navigation.sideIsOpen;

      navigation.closeSide();

      await Future.delayed(Duration.zero);

      late OverlayEntry entry;
      void handleOnComplete() {
        entry.remove();
        if (lastState) {
          navigation.openSide();
        } else {
          navigation.closeSide();
        }
      }

      entry = OverlayEntry(
        maintainState: true,
        builder: (context) {
          return ExportingProcessScreen(
            onComplete: handleOnComplete,
            quality: selectedQuality.value,
          );
        },
      );
      if (!context.mounted) return;
      Overlay.of(context).insert(entry);
    }, [navigation, selectedQuality]);

    List<RadioListTile<SnapshotQuality>> buildRadioList() {
      return SnapshotQuality.values.map((e) {
        return RadioListTile<SnapshotQuality>.adaptive(
          title: Text(e.label),
          value: e,
          groupValue: selectedQuality.value,
          onChanged: (value) {
            selectedQuality.value = value!;
          },
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
                onPressed: convertToPdf,
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ExportingProcessScreen extends HookWidget {
  const ExportingProcessScreen({
    super.key,
    required this.onComplete,
    required this.quality,
  });

  final void Function() onComplete;
  final SnapshotQuality quality;

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
    final status = useState(ExportProcessStatus.idle);
    final images = useState(<Uint8List>[]);
    final pageController = usePageController();
    final slides = useSlides();

    final startConversion = useCallback(() async {
      try {
        final generator = SnapshotService.instance;
        status.value = ExportProcessStatus.converting;

        List<Future<Uint8List>> futures = [];

        Future<Uint8List> convertSlide(Slide slide) async {
          final convertedImage = await generator.generate(
            quality: quality,
            slide: slide,
          );
          images.value.add(convertedImage);

          return convertedImage;
        }

        for (var slide in slides) {
          futures.add(convertSlide(slide));
        }

        final imageResults = await Future.wait(futures);

        await Future.delayed(Durations.short1);
        status.value = ExportProcessStatus.creatingPdf;
        await Future.delayed(Durations.short1);

        final pdf = await buildPdf(imageResults);

        status.value = ExportProcessStatus.complete;
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
        log(e.toString());
      } finally {
        onComplete();
      }
    }, []);

    useEffect(() {
      startConversion();
      return null;
    }, []);

    useEffect(() {
      if (images.value.length == slides.length) {
        pageController.jumpToPage(0);
      } else {
        pageController.jumpToPage(images.value.length - 1);
      }
      return null;
    }, [images, slides]);

    final totalSlides = slides.length;
    final totalImages = images.value.length;

    final statusLabel = switch (status.value) {
      ExportProcessStatus.idle => 'Idle',
      ExportProcessStatus.converting => 'Converting',
      ExportProcessStatus.creatingPdf => 'Creating PDF',
      ExportProcessStatus.complete => 'Done',
    };

    List<Widget> buildChildren() {
      if (status.value.isComplete) {
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
            controller: pageController,
            itemCount: images.value.length,
            itemBuilder: (context, index) {
              return ScaledWidget(
                child: SlideView(
                  slides[index],
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
          color: Theme.of(context).colorScheme.surface,
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
  }
}
