import 'dart:isolate';
import 'dart:math';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/utils/services/notification_service.dart';

class CommonTools {
  static const NOTIFICATION_CHANNEL_ID = 'todp_app_204';
  static const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  static final outputTimeFormat = DateFormat('yyyyMMdd');

  static bool intToBool(int value) => value == 1;

  static int boolToInt(bool value) => value?1:0;

  static bool isInSameDay(DateTime dt1, dt2) {
    if(dt2 == null || dt1 == null) return false;
    return outputTimeFormat.format(dt1) == outputTimeFormat.format(dt2);
  }

  static String generateRandomString(int len) {
    Random random = Random();
    return String.fromCharCodes(Iterable.generate(len, (index) => _chars.codeUnitAt(random.nextInt(_chars.length))));
  }
}