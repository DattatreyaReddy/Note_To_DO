import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

import '../../core/utils/task_table.dart';
import 'db_provider.dart';

class TaskProvider {
  TaskProvider._privateConstructor();

  static final TaskProvider instance = TaskProvider._privateConstructor();

  Future<int> insert(Map<String, dynamic> row) async {
    print(row);
    Database db = await DBProvider.instance.database;
    return await db.insert(DBProvider.taskTableName, row);
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    Database db = await DBProvider.instance.database;
    return await db.query(
      DBProvider.taskTableName,
      orderBy: describeEnum(TaskTable.isDone),
    );
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await DBProvider.instance.database;
    String id = describeEnum(TaskTable.id);
    return await db.update(
      DBProvider.taskTableName,
      row,
      where: '$id = ?',
      whereArgs: [row[id]],
    );
  }

  Future<int> delete(Map<String, dynamic> row) async {
    Database db = await DBProvider.instance.database;
    String id = describeEnum(TaskTable.id);
    return await db.delete(
      DBProvider.taskTableName,
      where: '$id = ?',
      whereArgs: [row[id]],
    );
  }
}
