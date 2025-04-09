import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:restawurant/models/restaurant_list.dart';

class RestaurantsApi {
  static const String _baseUrl = "https://restaurant-api.dicoding.dev";

  Future<RestaurantList> list() async {
    final response = await http.get(Uri.parse("$_baseUrl/list"));

    if (response.statusCode == 200) {
      return RestaurantList.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load restaurant list');
    }
  }
}
