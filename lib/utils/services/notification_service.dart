import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  void init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings("@mipmap/ic_launcher");
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid, iOS: null, macOS: null);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: null);
  }
}
