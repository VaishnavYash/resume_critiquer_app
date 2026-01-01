import 'package:flutter/material.dart';

class Utils {
  static Icon getIcon(final String label) {
    IconData? icon;
    Color? color;
    if (label.contains('strength')) {
      icon = Icons.check_circle;
      color = Colors.greenAccent;
    } else if (label.contains('improvement')) {
      icon = Icons.warning_amber_rounded;
      color = Colors.amberAccent;
    } else if (label.contains('format')) {
      icon = Icons.article;
      color = Colors.deepPurple;
    } else if (label.contains('achieve') || label.contains('certificat')) {
      icon = Icons.star;
      color = Colors.yellow;
    } else if (label.contains('technical') ||
        label.contains('solving') ||
        label.contains('skill')) {
      icon = Icons.psychology;
      color = Colors.blueAccent;
    } else if (label.contains('tailor')) {
      icon = Icons.edit_note;
      color = Colors.lightGreenAccent;
    } else {
      icon = Icons.badge;
      color = Colors.cyan;
    }

    return Icon(icon, color: color, size: 16);
  }
}
