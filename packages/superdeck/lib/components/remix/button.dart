import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mix/mix.dart';
import 'package:remix/remix.dart';

final _button = ButtonSpecUtility.self;

Style get _buttonStyle => Style(
      _button.container.padding.all(8),
    );

class SDButton extends StatelessWidget {
  const SDButton({
    required this.onPressed,
    super.key,
    required this.label,
    this.icon,
  });

  final VoidCallback onPressed;
  final String label;

  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return XButton(
      style: _buttonStyle,
      onPressed: onPressed,
      iconLeft: icon,
      label: label,
    );
  }
}

class SDButtonSolid extends StatelessWidget {
  const SDButtonSolid({
    required this.onPressed,
    super.key,
    required this.label,
    this.icon,
  });

  final VoidCallback onPressed;
  final String label;

  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return XButton(
      onPressed: onPressed,
      iconLeft: icon,
      label: label,
    );
  }
}

class SDOutlinedButton extends StatelessWidget {
  const SDOutlinedButton({
    required this.onPressed,
    super.key,
    required this.label,
    this.icon,
  });

  final VoidCallback onPressed;
  final String label;

  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return XButton(
      onPressed: onPressed,
      iconLeft: icon,
      label: label,
    );
  }
}

class SDIconButton extends StatelessWidget {
  const SDIconButton({
    required this.onPressed,
    super.key,
    required this.icon,
    this.selected = false,
  });

  final VoidCallback onPressed;
  final bool selected;

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SDButton(
      onPressed: onPressed,
      icon: icon,
      label: '',
    );
  }
}
