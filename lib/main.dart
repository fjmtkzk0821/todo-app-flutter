import 'dart:isolate';

// import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/app.dart';
import 'package:todo_app/utils/services/locator.dart';
import 'package:todo_app/utils/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await AndroidAlarmManager.initialize();
  await NotificationService().init();
  setUpLocator();
  runApp(App());
}