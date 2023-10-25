// text_input_widget.dart
import 'package:dash_deck/dash_deck.dart';
import 'package:dash_deck_demo/chat/components/horizontal_pill_list.dart';
import 'package:dash_deck_demo/chat/components/typing_indicator.dart';
import 'package:dash_deck_demo/chat/controllers/chat_controller.dart';
import 'package:dash_deck_demo/chat/prompts/slide_presentation_improver.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MessageInput extends HookConsumerWidget {
  const MessageInput({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController textController = useTextEditingController();

    final createPresentation = useState(false);
    final currentSlide = ref.watch(currentSlideProvider);

    final waitingResponse = ref.watch(waitingResponseProvider);

    final handleSubmit = useCallback(() async {
      final message = textController.text;

      if (message.isEmpty) {
        return;
      }
      textController.clear();

      final response =
          await ref.read(chatControllerProvider.notifier).sendPrompt(
                name: message,
                content: improveContent(currentSlide?.content ?? '', message),
              );

      ref
          .read(deckControllerProvider.notifier)
          .updateSlideContent(currentSlide!, response);
    }, [currentSlide, createPresentation.value]);

    final focusNode = useFocusNode(
      onKey: (
        FocusNode node,
        RawKeyEvent event,
      ) {
        // Ignore for key up events
        if (event is RawKeyUpEvent) {
          return KeyEventResult.ignored;
        }

        final isEnterKey = event.logicalKey == LogicalKeyboardKey.enter ||
            event.logicalKey == LogicalKeyboardKey.numpadEnter;

        if (event.isShiftPressed && isEnterKey) {
          textController.value = TextEditingValue(
            text: '${textController.text}\n',
            selection: TextSelection.collapsed(
              offset: textController.text.length + 1,
            ),
          );
          return KeyEventResult.handled;
        }

        if (isEnterKey) {
          if (event is RawKeyDownEvent) {
            handleSubmit();
            return KeyEventResult.handled;
          }
        }
        return KeyEventResult.ignored;
      },
    );

    Widget buildSendButton({
      required bool isTyping,
    }) {
      if (isTyping) {
        return const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: TypingIndicator(isTyping: true),
            ),
          ],
        );
      }
      return IconButton(
        splashRadius: 20,
        icon: const Icon(Icons.send),
        iconSize: 18,
        onPressed: () {
          handleSubmit();
        },
      );
    }

    return Column(
      children: [
        createPresentation.value
            ? HorizontalPillList(
                items: const [
                    'Punchier',
                    'Super Punchier',
                  ],
                onSelectedPill: (value) {
                  // updateSlideContent();
                })
            : const SizedBox(),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: TextField(
            controller: textController,
            keyboardType: TextInputType.multiline,
            autocorrect: true,
            focusNode: focusNode,
            enabled: !waitingResponse,
            minLines: 1,
            maxLines: null,
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Type a message',
              filled: true,
              fillColor:
                  Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.4),
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              suffixIcon: buildSendButton(
                isTyping: waitingResponse,
              ),
              prefixIcon: Tooltip(
                message: 'About the deck',
                child: IconButton(
                  icon: const Icon(Icons.slideshow),
                  color: createPresentation.value ? Colors.blue : Colors.grey,
                  iconSize: 18,
                  onPressed: () {
                    createPresentation.value = !createPresentation.value;
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
