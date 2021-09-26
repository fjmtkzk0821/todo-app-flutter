import 'package:todo_app/models/config_model.dart';
import 'package:todo_app/models/todo_list_storage_model.dart';
import 'package:todo_app/objects/todo_list_obj.dart';
import 'package:todo_app/objects/todo_obj.dart';
import 'package:todo_app/utils/base_message.dart';
import 'package:todo_app/utils/services/locator.dart';
import 'package:todo_app/utils/services/sqlite_service.dart';
import 'package:todo_app/viewmodels/base_view_model.dart';

class SplashViewModel extends BaseViewModel {
  ConfigModel _configModel;

  SplashViewModel() {
    _configModel = locator<ConfigModel>();

  }

  Future<void> loadData() async {
    TodoListStorageModel _storageModel = locator<TodoListStorageModel>();
    updateLoadingStatus(true,
        msg: BaseMessage(MessageType.LOADING,
            title: 'Loading', desc: ''));
    Future.delayed(Duration(seconds: 2));
    List<Map<dynamic,dynamic>> sqlResult = await SQLiteService.instance.query('SELECT * FROM TodoLists');
    for(Map<dynamic, dynamic> row in sqlResult) {
      TodoListObj tmpTodoListObj = TodoListObj.fromMap(row);
      _storageModel.todoListMap[tmpTodoListObj.id] = tmpTodoListObj;
    }
    sqlResult = await SQLiteService.instance.query('SELECT * FROM Todos');
    List<TodoObj> tmpTodoObjs = sqlResult.map((e) => TodoObj.fromMap(e)).toList();
    for(TodoObj todoObj in tmpTodoObjs) {
      _storageModel.todoListMap[todoObj.belong].todoObjs.add(todoObj);
    }
    updateLoadingStatus(false);
  }
}