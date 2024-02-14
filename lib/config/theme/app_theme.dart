import 'package:flutter/material.dart';

class AppTheme {
  final colorSeed = Colors.orange;

  ThemeData getData() =>
      ThemeData(
        useMaterial3: true,
        colorSchemeSeed: colorSeed
      );
}
