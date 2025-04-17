import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restawurant/databases/bookmark.dart';
import 'package:restawurant/models/restaurant.dart';
import 'package:restawurant/providers/bookmarks.dart';

class MockBookmarkDatabase extends Mock implements BookmarkDatabase {}

void main() {
  late BookmarksProvider bookmarksProvider;
  late MockBookmarkDatabase mockBookmarkDatabase;

  setUp(() {
    mockBookmarkDatabase = MockBookmarkDatabase();
    bookmarksProvider = BookmarksProvider(mockBookmarkDatabase);
  });

  group('bookmark provider', () {
    final restaurant = Restaurant(
      id: '1',
      name: 'Restaurant',
      description: 'A nice restaurant',
      pictureId: '01',
      city: 'Malang',
      rating: 4.5,
    );

    test('should load bookmarks successfully', () async {
      when(
        () => mockBookmarkDatabase.list(),
      ).thenAnswer((_) async => [restaurant]);

      await bookmarksProvider.list();

      expect(bookmarksProvider.bookmarks, contains(restaurant));
      expect(bookmarksProvider.message, 'Bookmarks loaded successfully');
    });

    test('should handle error when loading bookmarks', () async {
      when(() => mockBookmarkDatabase.list()).thenThrow(Exception('Error'));

      await bookmarksProvider.list();

      expect(bookmarksProvider.bookmarks, isEmpty);
      expect(bookmarksProvider.message, 'Failed to load bookmarks');
    });

    test('should add a restaurant to bookmarks successfully', () async {
      when(
        () => mockBookmarkDatabase.add(restaurant),
      ).thenAnswer((_) async => Future.value(1));

      await bookmarksProvider.add(restaurant);

      expect(bookmarksProvider.message, 'Restaurant added to bookmarks');
    });

    test('should handle error when adding a restaurant to bookmarks', () async {
      when(
        () => mockBookmarkDatabase.add(restaurant),
      ).thenThrow(Exception('Error'));

      await bookmarksProvider.add(restaurant);

      expect(
        bookmarksProvider.message,
        'Failed to add restaurant to bookmarks',
      );
    });

    test('should remove a restaurant from bookmarks successfully', () async {
      when(
        () => mockBookmarkDatabase.remove(restaurant.id),
      ).thenAnswer((_) async => Future.value(1));

      await bookmarksProvider.remove(restaurant);

      expect(bookmarksProvider.message, 'Restaurant removed from bookmarks');
    });

    test(
      'should handle error when removing a restaurant from bookmarks',
      () async {
        when(
          () => mockBookmarkDatabase.remove(restaurant.id),
        ).thenThrow(Exception('Error'));

        await bookmarksProvider.remove(restaurant);

        expect(
          bookmarksProvider.message,
          'Failed to remove restaurant from bookmarks',
        );
      },
    );
  });
}
