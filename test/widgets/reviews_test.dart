import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restawurant/models/restaurant.dart';
import 'package:restawurant/widgets/reviews.dart';

void main() {
  late Widget widget;
  final CustomerReview review = CustomerReview(
    name: 'Sulis',
    review: 'Mantap',
    date: '2025-04-17',
  );

  setUp(() {
    widget = MaterialApp(
      home: Scaffold(
        body: Reviews(
          id: '1',
          customerReviews: <CustomerReview>[review],
          onSubmit: () {},
        ),
      ),
    );
  });

  group('review widget', () {
    testWidgets('reviews widget displays customer reviews', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(widget);

      expect(find.text('Sulis'), findsOneWidget);
      expect(find.text('Mantap'), findsOneWidget);
      expect(find.text('2025-04-17'), findsOneWidget);
    });

    testWidgets('reviews widget displays error message when input is empty', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(widget);

      await tester.tap(find.byKey(ValueKey('submitButton')));
      await tester.pump();

      expect(find.text('Please fill in all fields'), findsOneWidget);
    });

    testWidgets('reviews widget submits review successfully', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(widget);

      await tester.enterText(find.byKey(ValueKey('nameField')), 'Sidik');
      await tester.enterText(find.byKey(ValueKey('reviewField')), 'Kane lop');

      await tester.tap(find.byKey(ValueKey('submitButton')));
      await tester.pump();

      expect(find.text('Sidik'), findsOneWidget);
      expect(find.text('Kane lop'), findsOneWidget);
    });
  });
}
