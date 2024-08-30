import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

import '../common/helpers/extensions.dart';

const _baseTheme = DarkChatTheme();

ChatTheme buildChatTheme(BuildContext context) {
  return DarkChatTheme(
    backgroundColor: context.colorScheme.surface,
    inputSurfaceTintColor: Colors.black,
    dateDividerTextStyle: TextStyle(
      color: context.colorScheme.onSurface,
      fontSize: 12,
      fontWeight: FontWeight.w800,
      height: 1.333,
    ),
    emptyChatPlaceholderTextStyle: TextStyle(
      color: context.colorScheme.onSurface.withOpacity(0.6),
      fontSize: 16,
      fontWeight: FontWeight.w500,
      height: 1.5,
    ),
    errorColor: context.colorScheme.error,
    inputBackgroundColor: Colors.black,
    inputBorderRadius: BorderRadius.zero,
    inputTextColor: context.colorScheme.onSurface,
    primaryColor: context.colorScheme.primary,
    receivedMessageBodyTextStyle: TextStyle(
      color: context.colorScheme.onSecondary,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      height: 1.5,
    ),
    receivedMessageCaptionTextStyle: TextStyle(
      color: context.colorScheme.onSecondary.withOpacity(0.6),
      fontSize: 12,
      fontWeight: FontWeight.w500,
      height: 1.333,
    ),
    receivedMessageDocumentIconColor: context.colorScheme.primary,
    receivedMessageLinkDescriptionTextStyle: TextStyle(
      color: context.colorScheme.onSecondary,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: 1.428,
    ),
    receivedMessageLinkTitleTextStyle: TextStyle(
      color: context.colorScheme.onSecondary,
      fontSize: 16,
      fontWeight: FontWeight.w800,
      height: 1.375,
    ),
    secondaryColor: context.colorScheme.secondary,
    sentMessageBodyTextStyle: TextStyle(
      color: context.colorScheme.onPrimary,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      height: 1.5,
    ),
    sentMessageCaptionTextStyle: TextStyle(
      color: context.colorScheme.onPrimary.withOpacity(0.6),
      fontSize: 12,
      fontWeight: FontWeight.w500,
      height: 1.333,
    ),
    sentMessageDocumentIconColor: context.colorScheme.onPrimary,
    sentMessageLinkDescriptionTextStyle: TextStyle(
      color: context.colorScheme.onPrimary,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: 1.428,
    ),
    sentMessageLinkTitleTextStyle: TextStyle(
      color: context.colorScheme.onPrimary,
      fontSize: 16,
      fontWeight: FontWeight.w800,
      height: 1.375,
    ),
    // systemMessageTheme: SystemMessageTheme(
    //   textStyle: TextStyle(
    //     color: context.colorScheme.onSurface,
    //     fontSize: 12,
    //     fontWeight: FontWeight.w800,
    //     height: 1.333,
    //   ),
    // ),
    // typingIndicatorTheme: TypingIndicatorTheme(
    //   animatedCirclesColor: context.colorScheme.onSurface,
    //   bubbleColor: context.colorScheme.surface,
    //   countTextColor: context.colorScheme.onPrimary,
    //   animatedCircleSize: _baseTheme.typingIndicatorTheme.animatedCircleSize,
    //   bubbleBorder: _baseTheme.typingIndicatorTheme.bubbleBorder,
    //   countAvatarColor: context.colorScheme.primary,
    //   multipleUserTextStyle: context.textTheme.bodySmall!,
    // ),
    unreadHeaderTheme: UnreadHeaderTheme(
      color: context.colorScheme.secondary,
      textStyle: TextStyle(
        color: context.colorScheme.onSecondary.withOpacity(0.6),
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 1.333,
      ),
    ),
    userAvatarTextStyle: TextStyle(
      color: context.colorScheme.onPrimary,
      fontSize: 12,
      fontWeight: FontWeight.w800,
      height: 1.333,
    ),
  );
}
