import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restawurant/widgets/rating.dart';

void main() {
  late Widget widget;
  const double testRating = 4.5;

  setUp(() {
    widget = const MaterialApp(
      home: Scaffold(body: Rating(rating: testRating)),
    );
  });

  group('rating widget', () {
    testWidgets('rating widget displays correct number of icons and text', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(widget);

      expect(find.byIcon(Icons.circle), findsNWidgets(testRating.toInt()));
      expect(find.text(testRating.toString()), findsOneWidget);
    });

    testWidgets('rating widget displays correct color', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(widget);

      final icon = tester.widget<Icon>(find.byIcon(Icons.circle).first);
      expect(
        icon.color,
        Theme.of(tester.element(find.byType(Rating))).colorScheme.primary,
      );
    });

    testWidgets('rating widget displays correct size', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(widget);

      final icon = tester.getSize(find.byIcon(Icons.circle).first);

      expect(icon.width, equals(14));
    });
  });
}
