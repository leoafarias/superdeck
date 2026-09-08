import 'package:flutter/foundation.dart';

/// The editor's sole logical Markdown document.
///
/// Consumers may replace the whole document from any source (the text editor,
/// AI generation, a file reload, or a deck switch). Identical content is
/// intentionally ignored so attribution-only editor changes cannot trigger a
/// persistence or preview feedback loop.
class DeckDocumentStore extends ChangeNotifier {
  int _revision = 0;

  DeckDocumentStore({required String markdown}) : _markdown = markdown;

  String _markdown;

  /// The current full Markdown document.
  String get markdown => _markdown;

  /// Counts the accepted replacements of this document.
  ///
  /// A long-running operation captures this value when it starts and compares
  /// it before it publishes, so it cannot overwrite a newer document.
  int get revision => _revision;

  /// Replaces the document and notifies listeners when its text changed.
  void replaceMarkdown(String markdown) {
    if (markdown == _markdown) return;
    _markdown = markdown;
    _revision++;
    notifyListeners();
  }
}
