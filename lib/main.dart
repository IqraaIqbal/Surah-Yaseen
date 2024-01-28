import 'package:flutter/material.dart';
import 'package:yaseen/Screens/home_page.dart';
import 'package:yaseen/Screens/splash_screen.dart';
import 'package:yaseen/Theme/light_theme.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      themeMode: ThemeMode.system,
      home: const SplashScreen(),
    );
  }
}
