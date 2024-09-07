import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:superdeck_core/superdeck_core.dart';

import '../modules/common/helpers/extensions.dart';
import '../modules/deck_reference/deck_reference_hooks.dart';
import '../modules/navigation/navigation_hooks.dart';
import '../modules/pdf_export/pdf_export_controller.dart';
import '../modules/widget_capture/widget_capture_service.dart';

class ExportScreen extends HookWidget {
  const ExportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final slides = useDeckSlides();
    final currentSlideIndex = useCurrentSlideIndex();

    final export = usePdfExportController(
      slides: slides,
      slideIndex: currentSlideIndex,
    );

    final inProgress = export.inProgress;

    return Stack(
      children: [
        Center(
          child: export.render(),
        ),
        Positioned.fill(
            child: Container(
          color: const Color.fromARGB(255, 14, 14, 14).withOpacity(0.9),
        )),
        inProgress ? PdfExportBar(export) : ExportDialog(export),
      ],
    );
  }
}

class PdfExportBar extends StatelessWidget {
  const PdfExportBar(this.controller, {super.key});

  final PdfExportController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 16.0,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          controller.isComplete
              ? Icon(
                  Icons.check_circle,
                  color: context.colorScheme.primary,
                  size: 32,
                )
              : SizedBox(
                  height: 32,
                  width: 32,
                  child: CircularProgressIndicator(
                    color: context.colorScheme.primary,
                    value: controller.isBuilding ? null : controller.progress,
                  ),
                ),
          const SizedBox(width: 16.0),
          Text(controller.progressText),
        ],
      ),
    );
  }
}

class ExportDialog extends HookWidget {
  const ExportDialog(
    this.controller, {
    super.key,
  });
  final PdfExportController controller;
  @override
  Widget build(BuildContext context) {
    final dropdownItems = WidgetCaptureQuality.values.map(
      (quality) => DropdownMenuItem(
        value: quality,
        child: Text(
          quality.name.capitalize(),
        ),
      ),
    );

    return Dialog(
      backgroundColor: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Select export quality:'),
            const SizedBox(height: 16.0),
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButton(
                      isDense: true,
                      value: controller.quality,
                      focusColor: Colors.transparent,
                      underline: const SizedBox.shrink(),
                      onChanged: (value) => controller.quality = value!,
                      items: dropdownItems.toList(),
                    ),
                    const SizedBox(width: 10),
                    OutlinedButton(
                      child: const Text('Export'),
                      onPressed: () => controller.start(),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
