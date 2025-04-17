import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restawurant/models/restaurant.dart';
import 'package:restawurant/widgets/rating.dart';
import 'package:restawurant/widgets/restaurant_card.dart';

void main() {
  late Widget widget;
  final Restaurant restaurant = Restaurant(
    id: '1',
    name: 'Kafe',
    description: 'Kafe di Malang yang keren',
    pictureId: '21',
    city: 'Malang',
    rating: 4.5,
  );

  setUp(() {
    HttpOverrides.global = null;
    widget = MaterialApp(
      routes: {
        '/restaurant':
            (context) => Scaffold(body: Text(restaurant.description)),
      },
      home: Scaffold(body: RestaurantCard(restaurant: restaurant)),
    );
  });

  group('restaurant card widget', () {
    testWidgets('restaurant card widget displays correct data', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      expect(find.byType(Image), findsOneWidget);
      expect(find.text('Kafe'), findsOneWidget);
      expect(find.text('Malang'), findsOneWidget);
      expect(find.byType(Rating), findsOneWidget);
    });

    testWidgets('restaurant card widget navigates to details page on tap', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(widget);

      await tester.tap(find.byType(RestaurantCard));
      await tester.pumpAndSettle();

      expect(find.text('Kafe di Malang yang keren'), findsOneWidget);
    });
  });
}
