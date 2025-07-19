import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const XploreGoApp());
}

class XploreGoApp extends StatelessWidget {
  const XploreGoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'XploreGo',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
