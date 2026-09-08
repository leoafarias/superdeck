import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hero_ui/hero_ui.dart';
import 'package:playground/core/data/data_sources/memory_deck_loader.dart';
import 'package:playground/core/domain/stores/deck_customization_store.dart';
import 'package:playground/features/ai/quick_agent/domain/commands/generate_deck_command.dart';
import 'package:playground/features/editor/domain/files/deck_file.dart';
import 'package:playground/features/editor/domain/stores/deck_document_store.dart';
import 'package:playground/features/editor/domain/stores/deck_file_session.dart';
import 'package:playground/features/editor/presentation/widgets/editor_header.dart';
import 'package:provider/provider.dart';
import 'package:superdeck/superdeck.dart';

import '../../../../helpers/fake_deck_file_repository.dart';

const _discardNotice =
    'The generated deck was discarded because the document changed '
    'while it was being created.';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);

  for (final textScale in [1.0, 1.5]) {
    testWidgets(
      'wraps and dismisses a notice in a 600px pane at $textScale text scale',
      (tester) async {
        final document = DeckDocumentStore(markdown: '');
        final controller = DeckController(
          deckLoader: MemoryDeckLoader(),
          options: DeckOptions(),
        );
        final customization = DeckCustomizationStore(controller);
        final session = DeckFileSession(
          initialSnapshot: const DeckFileSnapshot(
            reference: DeckFileReference(path: '/decks/a.md'),
            markdown: '',
          ),
          repository: FakeDeckFileRepository(),
          documentStore: document,
        );
        final command = _NoticeCommand(
          documentStore: document,
          customizationStore: customization,
        );
        addTearDown(() {
          command.dispose();
          session.dispose();
          customization.dispose();
          controller.dispose();
          document.dispose();
        });

        await tester.pumpWidget(
          MaterialApp(
            home: HeroTheme(
              data: HeroThemeData.light(),
              child: MultiProvider(
                providers: [
                  ChangeNotifierProvider<DeckFileSession>.value(value: session),
                  ListenableProvider<GenerateDeckCommand>.value(value: command),
                ],
                child: MediaQuery(
                  data: MediaQueryData(
                    textScaler: TextScaler.linear(textScale),
                  ),
                  child: const Scaffold(
                    body: Center(
                      child: SizedBox(width: 600, child: EditorHeader()),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );

        expect(tester.takeException(), isNull);
        expect(find.text(_discardNotice), findsOneWidget);
        expect(
          find.bySemanticsLabel(RegExp('Dismiss generation notice')),
          findsOneWidget,
        );
        final dismiss = find.byType(HeroIconButton);
        final headerRect = tester.getRect(find.byType(EditorHeader));
        final dismissRect = tester.getRect(dismiss);
        expect(headerRect.contains(dismissRect.center), isTrue);
        expect(dismissRect.right, lessThanOrEqualTo(headerRect.right));

        await tester.tap(dismiss);
        await tester.pumpAndSettle();

        expect(find.text(_discardNotice), findsNothing);
        expect(command.completionNotice, isNull);
        expect(tester.takeException(), isNull);

        await tester.pumpWidget(const SizedBox());
        await tester.pump(const Duration(seconds: 2));
      },
    );
  }
}

/// Supplies the notice while the widget test exercises layout and dismissal.
class _NoticeCommand extends GenerateDeckCommand {
  String? _notice = _discardNotice;

  _NoticeCommand({
    required super.documentStore,
    required super.customizationStore,
  });

  @override
  String? get completionNotice => _notice;

  @override
  void dismissNotice() {
    _notice = null;
    notifyListeners();
  }
}
