import 'dart:convert';
import 'dart:isolate';

import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/models/todo_list_storage_model.dart';
import 'package:todo_app/objects/todo_display_setting_config.dart';
import 'package:todo_app/objects/todo_list_obj.dart';
import 'package:todo_app/objects/todo_obj.dart';
import 'package:todo_app/ui/fragments/ipt_todo_fragment.dart';
import 'package:todo_app/ui/fragments/td_todo_fragment.dart';
import 'package:todo_app/utils/base_message.dart';
import 'package:todo_app/utils/common_tools.dart';
import 'package:todo_app/utils/services/locator.dart';
import 'package:todo_app/utils/services/notification_service.dart';
import 'package:todo_app/utils/services/sqlite_service.dart';
import 'package:timezone/timezone.dart' as tz;

class StorageViewModel extends ChangeNotifier {
  final int idPrefix = 204000;
  TodoDisplaySettingConfig config;
  TodoListStorageModel storageModel;
  String currentTodoListId;

  StorageViewModel() {
    storageModel = locator<TodoListStorageModel>();
    currentTodoListId = TDTodoFragment.label;
    config = TodoDisplaySettingConfig();
  }

  BaseMessage filterTodos(List<TodoObj> todoObjs) {
    try {
      List<TodoObj> filtered = todoObjs
          .where((element) =>
      config.displayByDays == -1 ||
          element.expiredDate == null ||
          element.expiredDate.difference(DateTime.now()).inDays <=
              config.displayByDays)
          .toList();
      Map<String, List<TodoObj>> objsMap = {
        'expired': filtered
            .where((element) =>
        (element.expiredDate != null &&
            DateTime.now().isAfter(element.expiredDate)) &&
            !element.isFinish)
            .toList(),
        'todo': filtered
            .where((element) =>
        (element.expiredDate == null ||
            (element.expiredDate != null &&
                DateTime.now().isBefore(element.expiredDate))) &&
            !element.isFinish)
            .toList(),
        'finish': filtered.where((element) => element.isFinish).toList()
      };
      switch (config.sortType) {
        case SortType.DATE_ASC:
          for (List<TodoObj> objs in objsMap.values) {
            objs.sort((a, b) => (a.expiredDate != null && b.expiredDate != null)? a.expiredDate.compareTo(b.expiredDate):0);
          }
          // objsMap['todo'].sort((a, b) => a.expiredDate.compareTo(b.expiredDate));
          // objsMap['todo'].sort((a, b) => a.expiredDate.compareTo(b.expiredDate));
          // objsMap['finish'].sort((a, b) => a.expiredDate.compareTo(b.expiredDate));
          break;
        case SortType.DATE_DESC:
          for (List<TodoObj> objs in objsMap.values) {
            objs.sort((a, b) => (a.expiredDate != null && b.expiredDate != null)? b.expiredDate.compareTo(a.expiredDate): 0);
          }
          // objsMap['todo'].sort((a, b) => b.expiredDate.compareTo(a.expiredDate));
          // objsMap['finish'].sort((a, b) => b.expiredDate.compareTo(a.expiredDate));
          break;
        case SortType.IMPORTANT:
        default:
          for (List<TodoObj> objs in objsMap.values) {
            objs.sort((a, b) => a.isImportant ? 0 : 1);
          }
      // objsMap['todo'].sort((a, b) => a.isImportant ? 0 : 1);
      // objsMap['finish'].sort((a, b) => a.isImportant ? 0 : 1);
      }
      return BaseMessage(MessageType.SUCCESS,
          title: 'success', action: () => objsMap);
    } catch(ex) {
      return BaseMessage(MessageType.ERROR, title: 'unknown',desc: ex.toString());
    }
  }

  Future<BaseMessage> insertTodoList(TodoListObj listObj) async {
    try {
      do {
        listObj.id = CommonTools.generateRandomString(8);
      } while (storageModel.todoListMap.keys
          .any((element) => element == listObj.id));
      await SQLiteService.instance.insert('TodoLists', listObj.toJson());
      storageModel.todoListMap[listObj.id] = listObj;
      return BaseMessage(MessageType.SUCCESS,
          title: 'TODO_LIST_INSERTION', desc: 'Todo list insert success.');
    } catch (ex) {
      return BaseMessage(MessageType.ERROR,
          title: 'TODO_LIST_INSERTION', desc: ex);
    }
  }

  Future<BaseMessage> deleteTodoList() async {
    try {
      TodoListObj currentListObj = storageModel.todoListMap[currentTodoListId];
      Batch batch = SQLiteService.instance.db.batch();
      batch
          .delete('TodoLists', where: 'id = ?', whereArgs: [currentListObj.id]);
      batch
          .delete('Todos', where: 'belong = ?', whereArgs: [currentListObj.id]);
      var tmp = await batch.commit();
      storageModel.todoListMap.removeWhere((key, value) => key == currentListObj.id);
      storageModel.todoListMap.remove(currentListObj);
      currentListObj = storageModel.todoListMap['undefined'];
      notifyListeners();
      return BaseMessage(MessageType.SUCCESS,
          title: 'TODO_LIST_DELETE', desc: 'Todo list insert success.');
    } catch (ex) {
      return BaseMessage(MessageType.ERROR,
          title: 'TODO_LIST_DELETE', desc: ex);
    }
  }

  void changeCurrentTodoList(String id) {
    if (currentTodoListId != id) {
      currentTodoListId = id;
      if (![TDTodoFragment.label, IPTTodoFragment.label].contains(id)) {
        storageModel.currentListObj = storageModel.todoListMap[id];
      }
      notifyListeners();
    }
  }

  Future<BaseMessage> updateTodoFinishStatus(TodoObj todo) async {
    int count = await SQLiteService.instance.update(
        'todos',
        {'isFinish': CommonTools.boolToInt(!todo.isFinish)},
        ['id = \"${todo.id}\"']);
    notifyListeners();
    if (count == 1) {
      todo.updateTodoFinishStatus();
      notifyListeners();
      return BaseMessage(MessageType.SUCCESS,
          title: 'TODO_INSERTION', desc: 'Todo update success.');
    } else
      return BaseMessage(MessageType.ERROR,
          title: 'ERROR (count: $count)', desc: 'debug desc.');
  }

  Future<BaseMessage> insertTodo(TodoObj todo) async {
    if ([TDTodoFragment.label, IPTTodoFragment.label]
        .contains(currentTodoListId)) {
      todo.belong = 'undefined';
      if (currentTodoListId == IPTTodoFragment.label) todo.isImportant = true;
    } else
      todo.belong = currentTodoListId;
    do {
      todo.id = CommonTools.generateRandomString(8);
    } while (storageModel.todoListMap[todo.belong].todoObjs
        .any((element) => element.id == todo.id));
    storageModel.todoListMap[todo.belong].todoObjs.add(todo);
    await SQLiteService.instance.insert('todos', todo.toMap());
    notifyListeners();
    return BaseMessage(MessageType.SUCCESS,
        title: 'TODO_INSERTION', desc: 'Todo insert success.');
  }

  Future<BaseMessage> updateTodo(TodoObj origin, TodoObj todoObj) async {
    Map<String, dynamic> originMap = origin.toMap();
    Map<String, dynamic> reqUpdate = Map();
    todoObj.toMap().forEach((key, value) {
      if (originMap[key] != value) reqUpdate[key] = value;
    });
    if (reqUpdate.isEmpty)
      return BaseMessage(MessageType.WARNING,
          title: 'TODO_UPDATE_ABORT', desc: 'No Update field.');
    int count = await SQLiteService.instance
        .update('todos', reqUpdate, ['id = \"${todoObj.id}\"']);
    for (int i = 0;
        i < storageModel.todoListMap[origin.belong].todoObjs.length;
        i++) {
      if (storageModel.todoListMap[origin.belong].todoObjs[i].id == origin.id) {
        storageModel.todoListMap[origin.belong].todoObjs[i] = todoObj;
      }
    }
    notifyListeners();
    if (count == 1)
      return BaseMessage(MessageType.SUCCESS,
          title: 'TODO_UPDATE_SUCCESS', desc: 'Todo update success.');
    else
      return BaseMessage(MessageType.ERROR,
          title: 'ERROR (count: $count)', desc: 'debug desc.');
  }

  Future<BaseMessage> deleteTodo(TodoObj todoObj) async {
    storageModel.todoListMap[todoObj.belong].todoObjs.remove(todoObj);
    int count = await SQLiteService.instance
        .delete('todos', ['id = \"${todoObj.id}\"']);
    notifyListeners();
    if (count == 1)
      return BaseMessage(MessageType.SUCCESS,
          title: 'TODO_INSERTION', desc: 'Todo insert success.');
    else
      return BaseMessage(MessageType.ERROR,
          title: 'ERROR (count: $count)', desc: 'debug desc.');
  }

  // Future<BaseMessage> setRepeat(TodoObj origin, TodoObj todoObj) async {
  //   int count = await SQLiteService.instance.update('todos', {
  //     'isRepeat': CommonTools.boolToInt(todoObj.isRepeat),
  //     'period': '\"${jsonEncode(todoObj.period)}\"'
  //   }, [
  //     'id = \"${todoObj.id}\"'
  //   ]);
  //   notifyListeners();
  //   if (count == 1)
  //     return BaseMessage(MessageType.SUCCESS,
  //         title: 'TODO_INSERTION', desc: 'Todo insert success.');
  //   else
  //     return BaseMessage(MessageType.ERROR,
  //         title: 'ERROR (count: $count)', desc: 'debug desc.');
  // }
  //
  // Future<BaseMessage> cancelRepeat(TodoObj origin, TodoObj todoObj) async {
  //   int count = await SQLiteService.instance.update(
  //       'todos',
  //       {'isRepeat': CommonTools.boolToInt(todoObj.isRepeat), 'period': ''},
  //       ['id = \"${todoObj.id}\"']);
  //   notifyListeners();
  //   if (count == 1)
  //     return BaseMessage(MessageType.SUCCESS,
  //         title: 'TODO_INSERTION', desc: 'Todo insert success.');
  //   else
  //     return BaseMessage(MessageType.ERROR,
  //         title: 'ERROR (count: $count)', desc: 'debug desc.');
  // }

  Future<BaseMessage> setNotification(
      TodoObj origin, TodoObj todoObj, DateTime dateTime) async {
    int availableId = (await getAvailableNotificationId());
    todoObj.notification = availableId;

    // final DateTime now = DateTime.now();
    // final int isolateId = Isolate.current.hashCode;
    // print("[$now] Hello, world! isolate=${isolateId} function=''");
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(CommonTools.NOTIFICATION_CHANNEL_ID,
            'your channel name', 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            showWhen: false);
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    // await NotificationService().flutterLocalNotificationsPlugin.show(
    //     idPrefix + availableId,
    //     'Todo',
    //     '${todoObj.title} - ${CommonTools.outputTimeFormat.format(todoObj.expiredDate)}',
    //     platformChannelSpecifics,
    //     payload: 'item x');
    if (todoObj.isRepeat) {
      await NotificationService().flutterLocalNotificationsPlugin.zonedSchedule(
          idPrefix + availableId,
          'Todo',
          '${todoObj.title} - ${CommonTools.outputTimeFormat.format(todoObj.expiredDate)}',
          tz.TZDateTime.from(dateTime, tz.local),
          platformChannelSpecifics,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          androidAllowWhileIdle: true,
          matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime);
    } else {
      await NotificationService().flutterLocalNotificationsPlugin.zonedSchedule(
          idPrefix + availableId,
          'Todo',
          '${todoObj.title} - ${CommonTools.outputTimeFormat.format(todoObj.expiredDate)}',
          tz.TZDateTime.from(dateTime, tz.local),
          platformChannelSpecifics,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          androidAllowWhileIdle: true);
    }
    BaseMessage msg = await updateTodo(origin, todoObj);
    if (msg.type == MessageType.ERROR) return msg;

    notifyListeners();

    return BaseMessage(MessageType.SUCCESS,
        title: 'SET_NOTIFICATION', desc: 'SET_NOTIFICATION success.');
  }

  Future<BaseMessage> cancelNotification(
      TodoObj origin, TodoObj todoObj) async {
    todoObj.notification = -1;
    BaseMessage msg = await updateTodo(origin, todoObj);
    if (msg.type == MessageType.ERROR) return msg;

    await NotificationService()
        .flutterLocalNotificationsPlugin
        .cancel(origin.notification);
    origin = todoObj;
    notifyListeners();

    return BaseMessage(MessageType.SUCCESS,
        title: 'CANCEL_NOTIFICATION', desc: 'cancel success.');
  }

  void updateTodoImportantStatus(TodoObj todo) {
    todo.updateTodoImportantStatus();
    notifyListeners();
  }

  Future<int> getAvailableNotificationId() async {
    int id = -1;
    List<Map<dynamic, dynamic>> result = await SQLiteService.instance
        .query('SELECT MAX(notification) AS AVA FROM todos');
    if (result[0]['AVA'] != -1) {
      id = result[0]['AVA'] + 1;
    } else {
      id = 0;
    }
    print(result);
    return id;
  }

  //special fragment
  BaseMessage getTodoByDateTime(DateTime dateTime) {
    List<TodoObj> todoObjs = [];
    for (TodoListObj todoListObj in storageModel.todoListMap.values) {
      for (TodoObj todoObj in todoListObj.todoObjs) {
        if (todoObj.expiredDate == null ||
            CommonTools.isInSameDay(todoObj.expiredDate, dateTime))
          todoObjs.add(todoObj);
      }
    }
    return filterTodos(todoObjs);
  }

  BaseMessage getAllImportantTodo() {
    List<TodoObj> todoObjs = [];
    for (TodoListObj todoListObj in storageModel.todoListMap.values) {
      for (TodoObj todoObj in todoListObj.todoObjs) {
        if (todoObj.isImportant) todoObjs.add(todoObj);
      }
    }
    return filterTodos(todoObjs);
  }

  //display setting
  void changeDisplaySetting(int days) {
    config.displayByDays = days;
    notifyListeners();
  }
  void changeSortSetting(SortType type) {
    config.sortType = type;
    notifyListeners();
  }
}
