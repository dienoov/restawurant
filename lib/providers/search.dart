import 'package:flutter/material.dart';
import 'package:restawurant/apis/restaurants.dart';
import 'package:restawurant/providers/state.dart';

class SearchProvider extends ChangeNotifier {
  final RestaurantsApi _restaurantsApi;

  SearchProvider(this._restaurantsApi);

  ProviderState _state = NoneState();

  ProviderState get state => _state;

  Future<void> search(String query) async {
    _state = LoadingState();
    notifyListeners();

    try {
      final result = await _restaurantsApi.search(query);
      _state =
          result.error
              ? ErrorState('Restaurant not found')
              : LoadedState(result.restaurants);
    } catch (e) {
      _state = ErrorState(e.toString());
    } finally {
      notifyListeners();
    }
  }

  void reset() {
    _state = NoneState();
    notifyListeners();
  }
}
