import 'dart:math';

import 'package:flutter/material.dart';
import 'package:restawurant/apis/restaurants.dart';
import 'package:restawurant/models/restaurant.dart';
import 'package:restawurant/models/restaurant_list.dart';
import 'package:restawurant/services/notifications.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    if (task == "dailyTask") {
      try {
        final RestaurantList result = await RestaurantsApi().list();
        final Restaurant restaurant =
            result.restaurants[Random().nextInt(result.restaurants.length)];

        NotificationsService().scheduleDailyNotification(
          id: DateTime.now().millisecondsSinceEpoch.hashCode,
          title: inputData?["title"] ?? "It's time for lunch!",
          body: "Check out ${restaurant.name} for lunch today!",
        );
      } catch (e) {
        debugPrint("Error fetching restaurant: $e");
      }
    }
    return Future.value(true);
  });
}

class WorkmanagerService {
  final Workmanager _workmanager;

  WorkmanagerService([Workmanager? workmanager])
    : _workmanager = workmanager ??= Workmanager();

  Future<void> init() async {
    await _workmanager.initialize(callbackDispatcher, isInDebugMode: true);
  }

  Future<void> runPeriodicTask() async {
    await _workmanager.registerPeriodicTask(
      "dailyTask",
      "dailyTask",
      frequency: const Duration(hours: 24),
      inputData: {"title": "It's time for lunch!"},
    );
  }

  Future<void> cancelAllTask() async {
    await _workmanager.cancelAll();
  }
}
