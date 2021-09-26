import 'package:flutter/widgets.dart';
import 'package:todo_app/models/config_model.dart';
import 'package:todo_app/utils/services/locator.dart';

class AppConfig extends ChangeNotifier {
  final ConfigModel _configModel = locator<ConfigModel>();

  AppConfig();

  Future<void> init() async {
    await _configModel.init();
    notifyListeners();
  }

  getThemeMode() => _configModel.darkMode;
}