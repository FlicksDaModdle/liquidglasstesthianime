// lib/main.dart
import 'package:flutter/cupertino.dart';
import 'package:hianimieliquidglass/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // We use a CupertinoApp since the rest of the app uses Cupertino widgets
    // and the cupertino_native package is designed for this context.
    return const CupertinoApp(
      title: 'HiAnime Liquid Glass',
      // Ensure the theme is set up for a dark/black look
      theme: CupertinoThemeData(
        brightness: Brightness.dark,
        primaryColor: CupertinoColors.systemPink, // Example primary color
        scaffoldBackgroundColor: CupertinoColors.black,
      ),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
