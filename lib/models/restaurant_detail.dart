import 'dart:convert';

import 'package:restawurant/models/restaurant.dart';

RestaurantDetail restaurantDetailFromJson(String str) => RestaurantDetail.fromJson(json.decode(str));

String restaurantDetailToJson(RestaurantDetail data) => json.encode(data.toJson());

class RestaurantDetail {
  final bool? error;
  final String? message;
  final Restaurant? restaurant;

  RestaurantDetail({
    this.error,
    this.message,
    this.restaurant,
  });

  factory RestaurantDetail.fromJson(Map<String, dynamic> json) => RestaurantDetail(
    error: json["error"],
    message: json["message"],
    restaurant: json["restaurant"] == null ? null : Restaurant.fromJson(json["restaurant"]),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "restaurant": restaurant?.toJson(),
  };
}