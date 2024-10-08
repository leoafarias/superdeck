import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../components/remix/button.dart';
import '../helpers/extensions.dart';
import '../helpers/routes.dart';
import '../services/export_service.dart';
import '../services/snapshot_service.dart';
import '../superdeck.dart';

class ExportScreen extends HookWidget {
  const ExportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final slides = useSlides();
    final currentSlideIndex = useValueNotifier(
        context.currentSlideIndex, [context.currentSlideIndex]);

    final export = usePdfExportController(
      slides: slides,
      slideIndex: currentSlideIndex.value,
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
        inProgress ? _ProgressDialog(export) : ExportDialog(export),
      ],
    );
  }
}

class _ProgressDialog extends StatelessWidget {
  const _ProgressDialog(this.controller);

  final PdfExportController controller;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 32.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            controller.isComplete
                ? Icon(
                    Icons.check_circle,
                    color: context.colorScheme.primary,
                    size: 42,
                  )
                : SizedBox(
                    height: 42,
                    width: 42,
                    child: CircularProgressIndicator(
                      color: context.colorScheme.primary,
                      value: controller.isBuilding ? null : controller.progress,
                    ),
                  ),
            const SizedBox(height: 16.0),
            Text(controller.progressText),
          ],
        ),
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
    final dropdownItems = SnapshotQuality.values.map(
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
                    SizedBox(width: 10),
                    SDButtonSolid(
                      label: 'Export',
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
