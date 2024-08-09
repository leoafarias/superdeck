import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../helpers/constants.dart';
import '../components/atoms/linear_progresss_indicator_widget.dart';
import '../helpers/extensions.dart';
import '../services/snapshot_service.dart';
import '../superdeck.dart';

class ExportScreen extends StatefulHookWidget {
  const ExportScreen({super.key});

  @override
  State<ExportScreen> createState() => _ExportScreenState();
}

class _ExportScreenState extends State<ExportScreen> {
  late final PDFExportController _pdfExportController;

  @override
  void initState() {
    super.initState();
    _pdfExportController = PDFExportController();
  }

  @override
  Widget build(BuildContext context) {
    final selectedQuality = useState(SnapshotQuality.good);
    final slides = useSlides();

    useEffect(() {
      _pdfExportController.slides = slides;
    }, [slides]);

    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Select Quality:',
                    style: context.textTheme.displaySmall,
                  ),
                  const SizedBox(height: 16.0),
                  ...SnapshotQuality.values.map((e) {
                    return RadioListTile.adaptive(
                      title: Text(e.label),
                      value: e,
                      groupValue: selectedQuality.value,
                      onChanged: (value) => selectedQuality.value = value!,
                    );
                  }).toList(),
                  const SizedBox(height: 24.0),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () => _pdfExportController.start(),
                        child: const Text('Export'),
                      ),
                      const SizedBox(width: 16.0),
                    ],
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: _pdfExportController.render(),
          ),
        ],
      ),
    );
  }
}

List<Widget> _renderComplete() {
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

class ExportProgress extends StatelessWidget {
  ExportProgress({
    super.key,
    required this.controller,
  });

  final PDFExportController controller;

  @override
  Widget build(BuildContext context) {
    List<Widget> buildChildren() {
      return [
        AspectRatio(
          aspectRatio: kAspectRatio,
          child: controller.render(),
        ),
        const SizedBox(height: 26),
        Text(
          controller.status.name,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: AnimatedLinearProgressIndicator(
                progress: controller.progress,
              ),
            ),
            const SizedBox(width: 16),
            Text(
              controller.progressText,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        )
      ];
    }

    return ListenableBuilder(
        listenable: controller,
        builder: (context, _) {
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
                  children: controller.isComplete
                      ? _renderComplete()
                      : buildChildren(),
                ),
              ),
            ],
          );
        });
  }
}
