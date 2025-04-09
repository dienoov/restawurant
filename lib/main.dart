import 'package:flutter/material.dart';

void main() {
  runApp(const Restawurant());
}

class Restawurant extends StatelessWidget {
  const Restawurant({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restawurant',
      theme: RestawurantThemeData.lightTheme,
      darkTheme: RestawurantThemeData.darkTheme,
      themeMode: ThemeMode.system,
    );
  }
}
