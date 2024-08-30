import 'package:flutter/material.dart';

enum SideMenu {
  preview(icon: Icons.play_arrow, label: 'Preview'),

  clearCache(icon: Icons.cached, label: 'Clear Cache');

  const SideMenu({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  static List<SideMenu> devMenu = [
    ...values,
  ];

  static List<SideMenu> prodMenu = [
    preview,
  ];
}
