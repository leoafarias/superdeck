import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:signals/signals_flutter.dart';

import '../../helpers/constants.dart';
import '../../models/slide_model.dart';

class PDFExport extends StatefulWidget {
  final List<Slide> slides;

  const PDFExport({super.key, required this.slides});

  @override
  State<PDFExport> createState() => _PDFExportState();
}

class _PDFExportState extends State<PDFExport> {
  late final _isConverting = createSignal(context, false);
  final Map<String, GlobalKey> _globalKeys = {};

  @override
  void initState() {
    super.initState();
    _isConverting.value = true;
    for (var slide in widget.slides) {
      _globalKeys[slide.hashCode.toString()] = GlobalKey();
    }
  }

  @override
  void didUpdateWidget(PDFExport oldWidget) {
    if (widget.slides != oldWidget.slides) {
      _globalKeys.clear();
      for (var slide in widget.slides) {
        _globalKeys[slide.hashCode.toString()] = GlobalKey();
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  Future<Uint8List> getWidgetImageData(
    GlobalKey key, [
    double pixelRatio = 1,
  ]) async {
    final boundary =
        key.currentContext!.findRenderObject() as RenderRepaintBoundary;

    final image = await boundary.toImage(pixelRatio: pixelRatio);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final imageData = byteData!.buffer.asUint8List();
    return imageData;
  }

  Future<void> saveImagesToPdf(List<Uint8List> images) async {
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
              child: pw.Image(image),
            );
          },
        ),
      );
    }

    final file = File('superdeck.pdf');
    await file.writeAsBytes(await pdf.save());
  }

  Future<void> convertToPdf() async {
    try {
      _isConverting.value = true;

      List<Uint8List> images = [];
      for (int i = 0; i < widget.slides.length; i++) {
        final slide = widget.slides[i];
        final key = _globalKeys[slide.hashCode.toString()]!;
        final image = await getWidgetImageData(key);
        images.add(image);
      }

      await saveImagesToPdf(images);
    } catch (e) {
      print('Error converting to pdf: $e');
    } finally {
      _isConverting.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: convertToPdf,
      child: const Text('Export to PDF'),
    );
  }
}
