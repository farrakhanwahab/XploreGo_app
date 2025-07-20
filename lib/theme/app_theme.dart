import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        fontFamily: 'Nexa',
        fontFamilyFallback: ['Roboto', 'Arial', 'sans-serif'],
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 16, fontFamily: 'Nexa'),
          displayMedium: TextStyle(fontSize: 13, fontFamily: 'Nexa'),
          displaySmall: TextStyle(fontSize: 13, fontFamily: 'Nexa'),
          headlineLarge: TextStyle(fontSize: 15, fontFamily: 'Nexa'),
          headlineMedium: TextStyle(fontSize: 14, fontFamily: 'Nexa'),
          headlineSmall: TextStyle(fontSize: 14, fontFamily: 'Nexa'),
          titleLarge: TextStyle(fontSize: 16, fontFamily: 'Nexa'),
          titleMedium: TextStyle(fontSize: 14, fontFamily: 'Nexa'),
          titleSmall: TextStyle(fontSize: 14, fontFamily: 'Nexa'),
          bodyLarge: TextStyle(fontSize: 16, fontFamily: 'Nexa'),
          bodyMedium: TextStyle(fontSize: 13, fontFamily: 'Nexa'),
          bodySmall: TextStyle(fontSize: 13, fontFamily: 'Nexa'),
          labelLarge: TextStyle(fontSize: 16, fontFamily: 'Nexa'),
          labelMedium: TextStyle(fontSize: 13, fontFamily: 'Nexa'),
          labelSmall: TextStyle(fontSize: 12, fontFamily: 'Nexa'),
        ),
      );

  static ThemeData get darkTheme => ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        fontFamily: 'Nexa',
        fontFamilyFallback: ['Roboto', 'Arial', 'sans-serif'],
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 16, fontFamily: 'Nexa'),
          displayMedium: TextStyle(fontSize: 13, fontFamily: 'Nexa'),
          displaySmall: TextStyle(fontSize: 13, fontFamily: 'Nexa'),
          headlineLarge: TextStyle(fontSize: 15, fontFamily: 'Nexa'),
          headlineMedium: TextStyle(fontSize: 14, fontFamily: 'Nexa'),
          headlineSmall: TextStyle(fontSize: 14, fontFamily: 'Nexa'),
          titleLarge: TextStyle(fontSize: 16, fontFamily: 'Nexa'),
          titleMedium: TextStyle(fontSize: 14, fontFamily: 'Nexa'),
          titleSmall: TextStyle(fontSize: 14, fontFamily: 'Nexa'),
          bodyLarge: TextStyle(fontSize: 16, fontFamily: 'Nexa'),
          bodyMedium: TextStyle(fontSize: 13, fontFamily: 'Nexa'),
          bodySmall: TextStyle(fontSize: 13, fontFamily: 'Nexa'),
          labelLarge: TextStyle(fontSize: 16, fontFamily: 'Nexa'),
          labelMedium: TextStyle(fontSize: 13, fontFamily: 'Nexa'),
          labelSmall: TextStyle(fontSize: 12, fontFamily: 'Nexa'),
        ),
      );
} 