import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restawurant/providers/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late ThemeProvider themeProvider;

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    themeProvider = ThemeProvider();
  });

  group('ThemeProvider', () {
    test('should have initial state', () {
      expect(themeProvider.themeMode, ThemeMode.light);
    });

    test('should toggle theme from light to dark', () {
      themeProvider.toggle();
      expect(themeProvider.themeMode, ThemeMode.dark);
    });

    test('should toggle theme from light to dark and back', () {
      themeProvider.toggle();
      expect(themeProvider.themeMode, ThemeMode.dark);
      themeProvider.toggle();
      expect(themeProvider.themeMode, ThemeMode.light);
    });
  });
}
