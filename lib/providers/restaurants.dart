import 'package:flutter/material.dart';
import 'package:restawurant/apis/restaurants.dart';
import 'package:restawurant/providers/state.dart';

class RestaurantsProvider extends ChangeNotifier {
  final RestaurantsApi _restaurantsApi;

  RestaurantsProvider(this._restaurantsApi);

  ProviderState _state = NoneState();

  ProviderState get state => _state;

  Future<void> list() async {
    _state = LoadingState();
    notifyListeners();

    try {
      final result = await _restaurantsApi.list();
      _state =
          result.error
              ? ErrorState(result.message)
              : LoadedState(result.restaurants);
    } catch (e) {
      _state = ErrorState(e.toString());
    } finally {
      notifyListeners();
    }
  }
}
