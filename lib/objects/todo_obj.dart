import 'dart:convert';

import 'package:todo_app/utils/common_tools.dart';

class TodoObj {
  String id, title, memo, belong;
  int notification;
  bool isFinish, isImportant, isRepeat;
  DateTime createdDate, expiredDate, finishedDate;
  Map<String, dynamic> period;

  TodoObj(this.id, this.title, this.memo, this.belong, this.isFinish,
      this.isImportant, this.isRepeat, this.createdDate, this.expiredDate,
      this.finishedDate, this.period, this.notification); //repeat, alarm, createdDate

  updateTodoFinishStatus() {
    isFinish = !isFinish;
  }

  updateTodoImportantStatus() {
    isImportant = !isImportant;
  }

  TodoObj.empty() {
    title = '';
    memo = '';
    belong = '';
    isFinish = false;
    isImportant = false;
    isRepeat = false;
    createdDate = DateTime.now();
    expiredDate = null;
    period = null;
    notification = -1;
  }

  TodoObj.fromMap(Map<dynamic,dynamic> object) {
    id = object['id'];
    title = object['title'];
    belong = object['belong'];
    memo = object['memo'];
    isFinish = CommonTools.intToBool(object['isFinish']);
    isImportant = CommonTools.intToBool(object['isImportant']);
    isRepeat = CommonTools.intToBool(object['isRepeat']);
    createdDate = object['createdDate'].length > 0?DateTime.tryParse(object['createdDate']):null;
    expiredDate = object['expiredDate'].length > 0?DateTime.tryParse(object['expiredDate']):null;
    finishedDate = object['finishedDate'].length > 0?DateTime.tryParse(object['finishedDate']):null;
    period = object['period'].length > 0?jsonDecode(object['period']): null;
    notification = (object['notification'] is int)?object['notification']:int.parse(object['notification']);
  }

  Map<String,dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'belong': belong,
      'memo': memo,
      'isFinish': CommonTools.boolToInt(isFinish),
      'isImportant': CommonTools.boolToInt(isImportant),
      'isRepeat': CommonTools.boolToInt(isRepeat),
      'createdDate': expiredDate != null?createdDate.toString(): '',
      'expiredDate': expiredDate != null?expiredDate.toString(): '',
      'finishedDate': expiredDate != null?finishedDate.toString(): '',
      'period': period != null?jsonEncode(period): '',
      'notification': notification
    };
  }
}

class RepeatPeriodObj {
  List<int> scheduleInWeek;
  int interval;
  String type;
  DateTime startDate;

  RepeatPeriodObj({Map<String, dynamic> json, DateTime startDate}) {
    this.startDate = startDate??DateTime.now();
    if(json != null) {
      scheduleInWeek = json['sch'];
      interval = json['itv'];
      type = json['type'];
    } else {
      scheduleInWeek = [];
      interval = 1;
      type = 'week';
      scheduleInWeek.add(this.startDate.weekday);
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'sch': scheduleInWeek,
      'itv': interval,
      'type': type
    };
  }
}