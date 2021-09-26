import 'package:todo_app/objects/todo_list_obj.dart';
import 'package:todo_app/objects/todo_obj.dart';

class TodoListStorageModel {
  Map<String, TodoListObj> todoListMap;
  TodoListObj currentListObj;

  TodoListStorageModel() {
    todoListMap = {
    };
    currentListObj = null;
  }
}