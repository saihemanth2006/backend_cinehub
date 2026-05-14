import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'screens/main_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/signup_screen.dart';

class CineHubApp extends StatelessWidget {
  const CineHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      builder: DevicePreview.appBuilder,
      theme: ThemeData(brightness: Brightness.dark, fontFamily: 'Poppins'),
      home: Builder(
        builder: (context) => LoginScreen(
          onLoggedIn: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const MainScreen()));
          },
          onSignUpRequested: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) => SignupScreen(onSignedUp: (ctx) {
                  Navigator.of(ctx).pushReplacement(MaterialPageRoute(builder: (_) => const MainScreen()));
                })));
          },
        ),
      ),
    );
  }
}
