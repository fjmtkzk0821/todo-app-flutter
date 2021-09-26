import 'package:flutter/widgets.dart';
import 'package:todo_app/ui/pages/setting_page.dart';
import 'package:todo_app/ui/pages/todo_display_page.dart';

class AppRouter {
  static final Map<String, WidgetBuilder> _routeMap = {
    '/index': (_) => TodoDisplayPage(),
  };

  static Map<String, WidgetBuilder> getRouteMap() => _routeMap;

  static WidgetBuilder findRouteByKey(String key) {
    return _routeMap.containsKey(key)?_routeMap[key]:_routeMap['/index'];
  }
}