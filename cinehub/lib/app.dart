import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/main_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/signup_screen.dart';

import 'screens/splash/splash_screen.dart';

class CineHubApp extends StatelessWidget {
  const CineHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    final base = ThemeData.dark();
    final reducedSpacing = 0.0; // normal letter spacing across app
    final textTheme = base.textTheme;
    final tightTextTheme = TextTheme(
      displayLarge: textTheme.displayLarge?.copyWith(letterSpacing: reducedSpacing, wordSpacing: -1.0),
      displayMedium: textTheme.displayMedium?.copyWith(letterSpacing: reducedSpacing, wordSpacing: -1.0),
      displaySmall: textTheme.displaySmall?.copyWith(letterSpacing: reducedSpacing, wordSpacing: -1.0),
      headlineLarge: textTheme.headlineLarge?.copyWith(letterSpacing: reducedSpacing, wordSpacing: -1.0),
      headlineMedium: textTheme.headlineMedium?.copyWith(letterSpacing: reducedSpacing, wordSpacing: -1.0),
      headlineSmall: textTheme.headlineSmall?.copyWith(letterSpacing: reducedSpacing, wordSpacing: -1.0),
      titleLarge: textTheme.titleLarge?.copyWith(letterSpacing: reducedSpacing, wordSpacing: -1.0),
      titleMedium: textTheme.titleMedium?.copyWith(letterSpacing: reducedSpacing, wordSpacing: -1.0),
      titleSmall: textTheme.titleSmall?.copyWith(letterSpacing: reducedSpacing, wordSpacing: -1.0),
      bodyLarge: textTheme.bodyLarge?.copyWith(letterSpacing: reducedSpacing, wordSpacing: -1.0),
      bodyMedium: textTheme.bodyMedium?.copyWith(letterSpacing: reducedSpacing, wordSpacing: -1.0),
      bodySmall: textTheme.bodySmall?.copyWith(letterSpacing: reducedSpacing, wordSpacing: -1.0),
      labelLarge: textTheme.labelLarge?.copyWith(letterSpacing: reducedSpacing, wordSpacing: -1.0),
      labelSmall: textTheme.labelSmall?.copyWith(letterSpacing: reducedSpacing, wordSpacing: -1.0),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData(
        brightness: Brightness.dark,
        textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
      ),
      home: Builder(
        builder: (context) => const SplashScreen(
          nextScreen: LoginScreen(),
        ),
      ),
    );
  }
}
