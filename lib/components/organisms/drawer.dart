import 'package:flutter/material.dart';

enum SideMenu {
  preview(icon: Icons.play_arrow, label: 'Preview'),
  export(icon: Icons.save, label: 'Export');

  const SideMenu({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;
}
