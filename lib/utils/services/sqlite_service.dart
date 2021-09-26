import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SQLiteService {
  static final SQLiteService instance = SQLiteService();
  Database db;
  String dbRes = 'todo.db';

  Future<void> init() async {
    var dbPath = await getDatabasesPath();
    var path = join(dbPath, dbRes);
    try {
      await Directory(dbPath).create(recursive: true);
    } catch (ex) {
      print(ex);
    }
    db = await openDatabase(path);
  }

  Future<List<Map>> query(String sql) async {
    return await db.rawQuery(sql);
  }

  Future<void> execute(String sql) async {
    await db.execute(sql);
  }

  Future<int> insert(String table, Map<String, dynamic> row) async {
    int id = -1;
    // id = await db.rawInsert(
    //     'INSERT INTO $table(${row.keys.join(',')}) VALUES ${tmp.join(',')}');
    id = await db.insert(table, row);
    return id;
  }

  Future<int> update(String table, Map<String, dynamic> setData,
      List<String> condition) async {
    int count = -1;
    count = await db.rawUpdate(
        'UPDATE $table SET ${setData.keys.map((key) => '$key = ?').join(',')} WHERE ${condition.join(',')}',setData.values.toList());
    return count;
  }

  Future<int> delete(String table, List<String> condition) async {
    int count = -1;
    count =
        await db.rawDelete('DELETE FROM $table WHERE ${condition.join(',')}');
    return count;
  }

  Future<bool> drop(String table) async {
    List<Map<String, dynamic>> result =
        await db.rawQuery('DROP TABLE IF EXISTS $table');
    print(result);
    return true;
  }

  Future<bool> isTableExisted(String table) async {
    return (await db.rawQuery(
                'SELECT name FROM sqlite_master WHERE type=\'table\' AND name=\'$table\''))
            .length ==
        1;
  }

  void release() {
    if (db != null) db.close();
  }
}
