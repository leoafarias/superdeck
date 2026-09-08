# Remaining Markdown review work

Updated September 8, 2026. The generation and runtime cleanup is implemented
in the PR stack below. The Markdown renderer comparison and parser assembly
review remain outstanding in this workspace, so this plan is still needed.

This replaces the original broad review proposal with its remaining work.
The separate renderer handoff contains the detailed architecture and source
context. No Markdown implementation change is part of the cleanup stack.

## Completed cleanup

| Area | Implementation |
| --- | --- |
| Capture teardown, thumbnail pruning, transition ownership, and CI for stacked PRs | [PR #108](https://github.com/conceptadev/superdeck/pull/108) |
| Shared generation application, cancellation and document/file revision guards, service setup, and editor notices | [PR #109](https://github.com/conceptadev/superdeck/pull/109) |
| Build-status ownership, loader snapshots, script aliases, and test-command documentation | [PR #110](https://github.com/conceptadev/superdeck/pull/110) |

These changes retain the existing package boundaries and generation models.
Generation has passed the deterministic checkpoint and a live 10-slide run
with three artworks, 18.778 seconds of generation time, and ten captured slides.
That validates one generation run; it does not establish renderer parity or
replace the separate interactive authoring checks.

## 1. Establish the Markdown behavior contract

Inventory the behavior supplied by the existing renderer and each custom
builder. Start with the
[Markdown showcase](../packages/core/test/fixtures/markdown/github_web_markdown_showcase.md)
and existing parser, codec, widget, and capture tests.

Cover headings, paragraphs, inline formatting, nested lists, tasks, tables,
alerts, blockquotes, fenced code, Mermaid, images, custom widgets, Unicode,
text scaling, and overflow. Define intended link activation, selection, and
inline-image behavior before changing those features.

Deliver a feature-to-test matrix that distinguishes current behavior from
approved changes. Reuse existing fixtures and assertions.

## 2. Compare rendering the existing AST with ordinary widgets

Keep the Dart `markdown` parser and the current `flutter_markdown_plus`
implementation as the working baseline. Begin the separate comparison with
paragraphs, headings, and nested alerts rendered from existing parsed nodes.
Preserve Mix styling, inline formatting, Hero behavior, asset resolution, and
syntax configuration. Do not introduce another AST or a permanent renderer
selection framework for the experiment.

Compare the maintained code each approach needs, parser invocations during
style changes, cold/warm render cost, transition frames, capture completion,
and memory for representative 10- and 20-slide decks. Use matching SDK, fonts,
assets, devices, build modes, and cache conditions.

A successful text prototype is not a complete renderer. Before selecting or
extending it, evaluate lists, tables, code, blockquotes, images, semantics,
links, and selection on macOS and web. Investigate another widget package only
if the comparison leaves a specific requirement unresolved.

Deliver a keep, simplify, or replace decision supported by screenshots,
interaction results, measurements, and maintenance cost. A replacement needs
an identifiable benefit and coverage of every affected contract.

## 3. Review shared deck assembly

The CLI builder and Playground codec still assemble slide models separately
from the same deck parsers. Compare both paths before plugins run, using the
same inputs: options, sections, comments, widget arguments, slide identity,
fenced directives, malformed edits, and error diagnostics.

If parity supports consolidation, extract one small pure assembly function in
`builder`. Keep filesystem access, plugins, status reporting, and each caller's
recovery behavior with their current owners. Preserve serializer normalization
and slide-identity contracts. This is a separate parser change from selecting
a content renderer.

## Validation and retirement

Use the layer-specific commands in [AGENTS.md](../AGENTS.md). Regenerate code,
run analysis and contract checks, then run affected package, macOS integration,
and Chromium/WebKit tests. Capture output is part of renderer acceptance.

For each Markdown change, verify the complete authoring path: CLI build,
opening a deck, editing, invalid-edit recovery, saving/reloading, navigation,
and thumbnail/PDF capture. Keep `fvm flutter run` attached during manual checks
and inspect its logs after interactions. Run live generation again when its
behavior or model configuration changes.

Retire this plan when the renderer decision and parser consolidation have
been implemented or explicitly declined, with the decisions and validation
recorded in their PRs or maintained architecture documentation.
