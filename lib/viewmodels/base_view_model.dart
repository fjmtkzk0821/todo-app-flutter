import 'package:flutter/widgets.dart';
import 'package:todo_app/utils/base_message.dart';

class BaseViewModel extends ChangeNotifier {
  bool isLoading;
  BaseMessage message;

  BaseViewModel() {
    isLoading = false;
  }

  void updateLoadingStatus(bool status, {BaseMessage msg}) {
    isLoading = status;
    message = msg;
    notifyListeners();
  }
}