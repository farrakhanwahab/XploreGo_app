import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/country_provider.dart';
import 'providers/theme_provider.dart';
import 'theme/app_theme.dart';
import 'screens/splash_screen.dart';
// import 'package:device_preview/device_preview.dart';

void main() {
  // For development, uncomment below and comment the next line:
  // runApp(DevicePreview(
  //   enabled: !bool.fromEnvironment('dart.vm.product'),
  //   builder: (context) => const MyApp(),
  // ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CountryProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'XploreGo',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,
            home: const SplashScreen(),
            debugShowCheckedModeBanner: false,
            // builder: DevicePreview.appBuilder,
            // useInheritedMediaQuery: true,
            // locale: DevicePreview.locale(context),
          );
        },
      ),
    );
  }
}
