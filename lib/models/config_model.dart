import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/utils/base_message.dart';
import 'package:todo_app/utils/services/sqlite_service.dart';
import 'package:timezone/data/latest.dart' as tz;

class ConfigModel {
  bool darkMode;

  ConfigModel() {
    darkMode = true;
  }

  Future<BaseMessage> init() async {
    tz.initializeTimeZones();
    final _sqLiteService = SQLiteService.instance;
    await _sqLiteService.init();
    try {
      Batch batch = _sqLiteService.db.batch();
      if (!await _sqLiteService.isTableExisted('TodoLists')) {
        batch.execute('CREATE TABLE TodoLists (id TEXT, title TEXT)');
        batch.insert('TodoLists', {'id': 'undefined', 'title': 'undefined'});
      }
      if (!await _sqLiteService.isTableExisted('Todos')) {
        batch.execute(
            'CREATE TABLE Todos (id INTEGER, title TEXT,type TEXT, belong TEXT, isFinish INTEGER, isImportant INTEGER, createdDate TEXT,expiredDate TEXT, finishedDate TEXT, isRepeat INTEGER, period TEXT, memo TEXT, notification INTEGER)');
        //_sqLiteService.execute('CREATE TABLE Todos (id INTEGER, title TEXT,type TEXT, belong TEXT, isFinish INTEGER, isImportant INTEGER, createdDate TEXT,expiredDate TEXT, finishedDate TEXT, isRepeat INTEGER, period TEXT, memo TEXT)');
      }
      await batch.commit();
      return BaseMessage(MessageType.SUCCESS,
          title: 'init complete', desc: 'database initialized');
    } catch (ex) {
      print(ex);
      return BaseMessage(MessageType.ERROR,
          title: 'unknown Error Occur',
          desc: 'error occur when database initialization');
    }
  }
}
