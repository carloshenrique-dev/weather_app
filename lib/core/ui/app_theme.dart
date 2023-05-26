import 'package:flutter/material.dart';

class AppTheme {
  static final textStyleWithShadow = TextStyle(color: Colors.white, shadows: [
    BoxShadow(
      color: Colors.black12.withOpacity(0.25),
      spreadRadius: 1,
      blurRadius: 4,
      offset: const Offset(0, 0.5),
    )
  ]);

  static ThemeData get theme => ThemeData(
        brightness: Brightness.light,
        textTheme: TextTheme(
          displayLarge: textStyleWithShadow,
          displayMedium: textStyleWithShadow,
          displaySmall: textStyleWithShadow,
          headlineMedium: textStyleWithShadow,
          headlineSmall: textStyleWithShadow,
          titleMedium: const TextStyle(color: Colors.white),
          bodyMedium: const TextStyle(color: Colors.white),
          bodyLarge: const TextStyle(color: Colors.white),
          bodySmall: const TextStyle(color: Colors.white70, fontSize: 13),
        ),
      );
}
