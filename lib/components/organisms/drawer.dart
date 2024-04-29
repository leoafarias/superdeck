import 'package:flutter/material.dart';

enum SideMenu {
  preview(icon: Icons.play_arrow, label: 'Preview'),
  export(icon: Icons.save, label: 'Export'),
  clearCache(icon: Icons.cached, label: 'Clear Cache');

  const SideMenu({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;
}
