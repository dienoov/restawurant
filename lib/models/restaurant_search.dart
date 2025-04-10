import 'dart:convert';

import 'package:restawurant/models/restaurant.dart';

RestaurantSearch restaurantSearchFromJson(String str) =>
    RestaurantSearch.fromJson(json.decode(str));

String restaurantSearchToJson(RestaurantSearch data) =>
    json.encode(data.toJson());

class RestaurantSearch {
  final bool error;
  final int founded;
  final List<Restaurant> restaurants;

  RestaurantSearch({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  factory RestaurantSearch.fromJson(Map<String, dynamic> json) =>
      RestaurantSearch(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<Restaurant>.from(
          json["restaurants"].map((x) => Restaurant.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "error": error,
    "founded": founded,
    "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
  };
}
