import 'package:flutter/material.dart';

class AssignmentItemConfig {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;

  const AssignmentItemConfig({
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
  });

  static AssignmentItemConfig getConfig(String name) {
    final lowerName = name.toLowerCase();

    if (lowerName.contains('report') || lowerName.contains('analyt')) {
      return const AssignmentItemConfig(
        icon: Icons.bar_chart_rounded,
        backgroundColor: Color(0xFFE1BEE7), // Soft Pastel Purple (Image 2)
        iconColor: Color(0xFF4A148C),        // Dark Purple Icon
      );
    } else if (lowerName.contains('tarea') || lowerName.contains('asigna') || lowerName.contains('task')) {
      return const AssignmentItemConfig(
        icon: Icons.assignment_turned_in_rounded,
        backgroundColor: Color(0xFFDCEDC8), // Soft Pastel Green (Image 2)
        iconColor: Color(0xFF1B5E20),        // Dark Green Icon
      );
    } else if (lowerName.contains('sincron') || lowerName.contains('sync')) {
      return const AssignmentItemConfig(
        icon: Icons.sync_rounded,
        backgroundColor: Color(0xFFFFCCBC), // Soft Pastel Orange
        iconColor: Color(0xFFBF360C),
      );
    } else if (lowerName.contains('ejecutad') || lowerName.contains('complet')) {
      return const AssignmentItemConfig(
        icon: Icons.check_box_rounded,
        backgroundColor: Color(0xFFB3E5FC), // Soft Pastel Blue
        iconColor: Color(0xFF0D47A1),
      );
    } else if (lowerName.contains('ejecu') || lowerName.contains('monit')) {
      return const AssignmentItemConfig(
        icon: Icons.location_on_rounded,
        backgroundColor: Color(0xFFFFE0B2), // Soft Pastel Amber
        iconColor: Color(0xFFE65100),
      );
    } else if (lowerName.contains('mensaj') || lowerName.contains('push')) {
      return const AssignmentItemConfig(
        icon: Icons.mark_email_unread_rounded,
        backgroundColor: Color(0xFFC5CAE9), // Indigo Pastel
        iconColor: Color(0xFF1A237E),
      );
    }

    return const AssignmentItemConfig(
      icon: Icons.assignment_rounded,
      backgroundColor: Color(0xFFDCEDC8), // Soft Pastel Green
      iconColor: Color(0xFF1B5E20),
    );
  }
}
