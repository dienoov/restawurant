import 'package:flutter/material.dart';
import 'package:restawurant/styles/colors.dart';
import 'package:restawurant/styles/typography.dart';

class RestawurantThemeData {
  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: RestawurantColors.orange.color,
        onPrimary: RestawurantColors.ivory.color,
        secondary: RestawurantColors.lime.color,
        onSecondary: RestawurantColors.green.color,
        error: RestawurantColors.maroon.color,
        onError: RestawurantColors.pink.color,
        surface: RestawurantColors.offwhite.color,
        onSurface: Colors.black,
      ),
      brightness: Brightness.light,
      textTheme: _textTheme,
      useMaterial3: true,
      appBarTheme: _appBarTheme,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      colorSchemeSeed: RestawurantColors.orange.color,
      brightness: Brightness.dark,
      textTheme: _textTheme,
      useMaterial3: true,
      appBarTheme: _appBarTheme,
    );
  }

  static TextTheme get _textTheme {
    return TextTheme(
      displayLarge: RestawurantTextTheme.displayLarge,
      displayMedium: RestawurantTextTheme.displayMedium,
      displaySmall: RestawurantTextTheme.displaySmall,
      headlineLarge: RestawurantTextTheme.headlineLarge,
      headlineMedium: RestawurantTextTheme.headlineMedium,
      headlineSmall: RestawurantTextTheme.headlineSmall,
      titleLarge: RestawurantTextTheme.titleLarge,
      titleMedium: RestawurantTextTheme.titleMedium,
      titleSmall: RestawurantTextTheme.titleSmall,
      bodyLarge: RestawurantTextTheme.bodyLargeBold,
      bodyMedium: RestawurantTextTheme.bodyLargeMedium,
      bodySmall: RestawurantTextTheme.bodyLargeRegular,
      labelLarge: RestawurantTextTheme.labelLarge,
      labelMedium: RestawurantTextTheme.labelMedium,
      labelSmall: RestawurantTextTheme.labelSmall,
    );
  }

  static AppBarTheme get _appBarTheme {
    return AppBarTheme(toolbarTextStyle: _textTheme.titleLarge);
  }
}
