import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:restawurant/apis/restaurants.dart';
import 'package:restawurant/databases/bookmark.dart';
import 'package:restawurant/main.dart';
import 'package:restawurant/providers/bookmarks.dart';
import 'package:restawurant/providers/restaurant.dart';
import 'package:restawurant/providers/restaurants.dart';
import 'package:restawurant/providers/search.dart';
import 'package:restawurant/providers/theme.dart';
import 'package:restawurant/widgets/restaurant_card.dart';

class EvaluateRobot {
  final WidgetTester tester;

  EvaluateRobot(this.tester);

  Future<void> loadUI() async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => RestaurantsProvider(RestaurantsApi()),
          ),
          ChangeNotifierProvider(
            create: (context) => RestaurantProvider(RestaurantsApi()),
          ),
          ChangeNotifierProvider(
            create: (context) => BookmarksProvider(BookmarkDatabase()),
          ),
          ChangeNotifierProvider(
            create: (context) => SearchProvider(RestaurantsApi()),
          ),
          ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ],
        child: const Restawurant(),
      ),
    );
  }

  Future<void> waitForApi() async {
    await tester.pumpAndSettle();
    await tester.runAsync(() async {
      await tester.pumpAndSettle(const Duration(seconds: 2));
    });
  }

  Future<void> navigateSearch() async {
    await tester.tap(find.byKey(ValueKey('searchButton')));
    await tester.pumpAndSettle();
  }

  Future<void> navigateBookmark() async {
    await tester.tap(find.byKey(ValueKey('bookmarkButton')));
    await tester.pumpAndSettle();
  }

  Future<void> navigateBack() async {
    await tester.tap(find.byKey(ValueKey('backButton')));
    await tester.pumpAndSettle();
  }

  Future<void> tapRestaurantCard() async {
    await tester.tap(find.byType(RestaurantCard).first);
    await tester.pumpAndSettle();
  }

  Future<void> tapBookmarkButton() async {
    await tester.tap(find.byKey(ValueKey('bookmarkButton')));
    await tester.pumpAndSettle();
  }

  Future<void> tapSubmitReview() async {
    await tester.tap(find.byKey(ValueKey('submitButton')), warnIfMissed: false);
    await tester.pumpAndSettle();
  }

  Future<void> typeSearchQuery(String query) async {
    await tester.enterText(find.byKey(ValueKey('searchField')), query);
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();
  }

  Future<void> typeName(String name) async {
    await tester.enterText(find.byKey(ValueKey('nameField')), name);
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();
  }

  Future<void> typeReview(String review) async {
    await tester.enterText(find.byKey(ValueKey('reviewField')), review);
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();
  }

  Future<void> checkSearchResults(String query) async {
    final searchResults = find.byKey(ValueKey('searchResults'));
    expect(searchResults, findsOneWidget);

    final restaurantCards = find.byType(RestaurantCard);
    expect(restaurantCards, findsWidgets);

    for (final card in restaurantCards.evaluate()) {
      final restaurantName = (card.widget as RestaurantCard).restaurant.name;
      expect(restaurantName.toLowerCase(), contains(query.toLowerCase()));
    }
  }

  Future<void> checkSearchNoResults() async {
    final noResultsMessage = find.text('Restaurant not found');
    expect(noResultsMessage, findsOneWidget);
  }

  Future<void> checkBookmarkEmpty() async {
    final bookmarkEmptyMessage = find.text('No bookmarks yet');
    expect(bookmarkEmptyMessage, findsOneWidget);
  }

  Future<void> checkBookmarkNotEmpty() async {
    final bookmarkNotEmptyMessage = find.byKey(ValueKey('bookmarkList'));
    expect(bookmarkNotEmptyMessage, findsOneWidget);

    final restaurantCards = find.byType(RestaurantCard);
    expect(restaurantCards, findsWidgets);
  }

  Future<void> checkReviewSubmission(String name, String review) async {
    final nameText = find.text(name);
    expect(nameText, findsOneWidget);

    final reviewText = find.text(review);
    expect(reviewText, findsOneWidget);
  }
}
