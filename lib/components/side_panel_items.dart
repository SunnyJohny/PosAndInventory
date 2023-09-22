import 'package:flutter/material.dart';


class SidePanelItem {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  SidePanelItem({
    required this.icon,
    required this.title,
    this.onTap,
  });
}
