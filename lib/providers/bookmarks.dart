import 'package:flutter/material.dart';
import 'package:restawurant/databases/bookmark.dart';
import 'package:restawurant/models/restaurant.dart';

class BookmarksProvider extends ChangeNotifier {
  final BookmarkDatabase _database;

  BookmarksProvider(this._database);

  final List<Restaurant> _bookmarks = [];

  List<Restaurant> get bookmarks => _bookmarks;

  Restaurant? _bookmark;

  Restaurant? get bookmark => _bookmark;

  String _message = '';

  String get message => _message;

  Future<void> list() async {
    try {
      _bookmarks.clear();
      final result = await _database.list();
      _bookmarks.addAll(result);
      _message = 'Bookmarks loaded successfully';
    } catch (e) {
      _message = 'Failed to load bookmarks';
    } finally {
      notifyListeners();
    }
  }

  Future<void> detail(String id) async {
    try {
      _bookmark = await _database.detail(id);
      if (_bookmark != null) {
        _message = 'Bookmark loaded successfully';
      } else {
        _message = 'Bookmark not found';
      }
    } catch (e) {
      _message = 'Failed to load bookmark';
    } finally {
      notifyListeners();
    }
  }

  Future<void> add(Restaurant restaurant) async {
    try {
      await _database.add(restaurant);
      _message = 'Restaurant added to bookmarks';
    } catch (e) {
      _message = 'Failed to add restaurant to bookmarks';
    } finally {
      notifyListeners();
    }
  }

  Future<void> remove(Restaurant restaurant) async {
    try {
      await _database.remove(restaurant.id);
      _message = 'Restaurant removed from bookmarks';
    } catch (e) {
      _message = 'Failed to remove restaurant from bookmarks';
    } finally {
      notifyListeners();
    }
  }

  bool isBookmarked(Restaurant restaurant) {
    return _bookmark != null;
  }
}
