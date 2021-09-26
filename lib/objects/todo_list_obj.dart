import 'package:todo_app/objects/todo_obj.dart';

class TodoListObj {
  String id, title;

  List<TodoObj> todoObjs;

  TodoListObj({this.id, this.title, this.todoObjs});

  TodoListObj.empty() {
    id = '';
    title = '';
    todoObjs = [];
  }

  // TodoListObj.debug() {
  //   id = 'XXX';
  //   title = 'Test title';
  //   todoObjs = [
  //     TodoObj.empty(),
  //     TodoObj.empty(),
  //     TodoObj.empty(),
  //     TodoObj.empty(),
  //     TodoObj.empty(),
  //     TodoObj.empty(),
  //   ];
  // }

  TodoListObj.fromMap(Map<dynamic, dynamic> object) {
    id = object['id'];
    title = object['title'];
    todoObjs = [];
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title};
  }
}
