import 'package:flutter/material.dart';
import 'package:restawurant/services/notifications.dart';
import 'package:restawurant/services/workmanager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationsProvider extends ChangeNotifier {
  bool isEnabled = false;

  NotificationsProvider() {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    isEnabled = prefs.getBool('notifications') ?? false;
    notifyListeners();
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notifications', isEnabled);
  }

  void toggle() {
    if (isEnabled = !isEnabled) {
      WorkmanagerService().runPeriodicTask();
    } else {
      WorkmanagerService().cancelAllTask();
      NotificationsService().cancelAllNotifications();
    }
    notifyListeners();
    _save();
  }
}
