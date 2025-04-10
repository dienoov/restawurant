import 'package:flutter/material.dart';
import 'package:restawurant/models/restaurant.dart';

class BookmarksProvider extends ChangeNotifier {
  final List<Restaurant> _bookmarks = [];

  List<Restaurant> get bookmarks => _bookmarks;

  void add(Restaurant restaurant) {
    _bookmarks.add(restaurant);
    notifyListeners();
  }

  void remove(Restaurant restaurant) {
    _bookmarks.removeWhere((element) => element.id == restaurant.id);
    notifyListeners();
  }

  bool isBookmarked(Restaurant restaurant) {
    return _bookmarks.any((element) => element.id == restaurant.id);
  }
}
