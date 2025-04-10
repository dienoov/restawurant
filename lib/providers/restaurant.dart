import 'package:flutter/material.dart';
import 'package:restawurant/apis/restaurants.dart';
import 'package:restawurant/providers/state.dart';

class RestaurantProvider extends ChangeNotifier {
  final RestaurantsApi _restaurantsApi;

  RestaurantProvider(this._restaurantsApi);

  ProviderState _state = NoneState();

  ProviderState get state => _state;

  Future<void> detail(String id) async {
    _state = LoadingState();
    notifyListeners();

    try {
      final result = await _restaurantsApi.detail(id);
      _state =
          result.error
              ? ErrorState(result.message)
              : LoadedState(result.restaurant);
    } catch (e) {
      _state = ErrorState(e.toString());
    } finally {
      notifyListeners();
    }
  }
}
