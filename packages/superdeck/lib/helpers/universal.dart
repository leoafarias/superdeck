import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

extension TargetPlatformX on TargetPlatform {
  bool get isCupertino =>
      this == TargetPlatform.iOS || this == TargetPlatform.macOS;
  bool get isMaterial => !isCupertino;
}

class XPlatform extends InheritedWidget {
  final TargetPlatform? overridePlatform;

  const XPlatform({
    super.key,
    required super.child,
    this.overridePlatform,
  });

  static TargetPlatform of(BuildContext context) {
    final XPlatform? inherited =
        context.dependOnInheritedWidgetOfExactType<XPlatform>();
    return inherited?.overridePlatform ?? defaultTargetPlatform;
  }

  @override
  bool updateShouldNotify(XPlatform oldWidget) {
    return overridePlatform != oldWidget.overridePlatform;
  }
}

class XButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Color? color;

  const XButton({super.key, 
    required this.onPressed,
    required this.child,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final platform = XPlatform.of(context);

    if (platform.isCupertino) {
      return CupertinoButton(
        color: color,
        onPressed: onPressed,
        child: child,
      );
    } else {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
        ),
        onPressed: onPressed,
        child: child,
      );
    }
  }
}

class XSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const XSwitch({super.key, 
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final platform = XPlatform.of(context);

    if (platform.isCupertino) {
      return CupertinoSwitch(
        value: value,
        onChanged: onChanged,
      );
    } else {
      return Switch(
        value: value,
        onChanged: onChanged,
      );
    }
  }
}

class XDropdownButton<T> extends StatefulWidget {
  final bool isDense;
  final Widget? underline;
  final T? value;
  final ValueChanged<T?> onChanged;
  final List<XDropdownMenuItem<T>> items;

  const XDropdownButton({
    super.key,
    this.isDense = false,
    this.underline,
    required this.value,
    required this.onChanged,
    required this.items,
  });

  @override
  _XDropdownButtonState<T> createState() => _XDropdownButtonState<T>();
}

class _XDropdownButtonState<T> extends State<XDropdownButton<T>> {
  void _showCupertinoPicker(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 250,
          color: CupertinoTheme.of(context).scaffoldBackgroundColor,
          child: CupertinoPicker(
            itemExtent: 32.0,
            onSelectedItemChanged: (int index) {
              widget.onChanged(widget.items[index].value);
            },
            children: widget.items.map((item) => item.toCupertino()).toList(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final platform = XPlatform.of(context);

    if (platform.isCupertino) {
      Widget getSelectedWidget() {
        final item = widget.items.firstWhere(
          (item) => item.value == widget.value,
          orElse: () => widget.items.first,
        );

        return item.toCupertino();
      }

      return GestureDetector(
        onTap: () => _showCupertinoPicker(context),
        child: Container(
          padding: widget.isDense
              ? const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0)
              : const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          decoration: BoxDecoration(
            border: Border.all(color: CupertinoColors.inactiveGray),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              getSelectedWidget(),
              Icon(
                CupertinoIcons.chevron_down,
                color: CupertinoTheme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      );
    } else {
      return DropdownButton<T>(
        isDense: widget.isDense,
        underline: widget.underline,
        value: widget.value,
        onChanged: widget.onChanged,
        items: widget.items.map((item) => item.toMaterial()).toList(),
      );
    }
  }
}

class XDropdownMenuItem<T> {
  final T value;
  final Widget child;

  XDropdownMenuItem({
    required this.value,
    required this.child,
  });

  DropdownMenuItem<T> toMaterial() {
    return DropdownMenuItem<T>(
      value: value,
      child: child,
    );
  }

  Widget toCupertino() {
    return child;
  }
}

class XAlertDialog extends StatelessWidget {
  final Widget? title;
  final Widget? content;
  final List<XDialogAction> actions;

  const XAlertDialog({
    super.key,
    this.title,
    this.content,
    this.actions = const [],
  });

  @override
  Widget build(BuildContext context) {
    final platform = XPlatform.of(context);

    if (platform.isCupertino) {
      return CupertinoAlertDialog(
        title: title,
        content: content,
        actions: actions.map((action) => action.toCupertino()).toList(),
      );
    } else {
      return AlertDialog(
        title: title,
        content: content,
        actions: actions.map((action) => action.toMaterial()).toList(),
      );
    }
  }

  static Future<T?> show<T>({
    required BuildContext context,
    Widget? title,
    Widget? content,
    required List<XDialogAction> actions,
  }) {
    final platform = XPlatform.of(context);

    if (platform == TargetPlatform.iOS) {
      return showCupertinoDialog<T>(
        context: context,
        builder: (context) => XAlertDialog(
          title: title,
          content: content,
          actions: actions,
        ),
      );
    } else {
      return showDialog<T>(
        context: context,
        builder: (context) => XAlertDialog(
          title: title,
          content: content,
          actions: actions,
        ),
      );
    }
  }
}

class XDialogAction {
  final Widget child;
  final VoidCallback onPressed;

  XDialogAction({
    required this.child,
    required this.onPressed,
  });

  CupertinoDialogAction toCupertino() {
    return CupertinoDialogAction(
      onPressed: onPressed,
      child: child,
    );
  }

  Widget toMaterial() {
    return TextButton(
      onPressed: onPressed,
      child: child,
    );
  }
}
