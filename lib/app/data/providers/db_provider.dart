import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

import '../../core/utils/note_table.dart';
import '../../core/utils/task_table.dart';


class DBProvider {
  static final dbName = 'NoteToDo.db';
  static final dbVersion = 1;
  static final taskTableName = 'taskTable';
  static final noteTableName = 'noteTable';

  static late Database _database;

  DBProvider._privateConstructor();

  static final DBProvider instance = DBProvider._privateConstructor();


  Future<Database> get database async {
    try {
      return _database;
    } catch (e) {
      _database = await initDatabase();
      return _database;
    }
  }

  Future<Database> initDatabase() async {
    String path = (await getDatabasesPath()) + dbName;

    return openDatabase(
      path,
      version: dbVersion,
      onCreate: onCreate,
    );
  }

  FutureOr<void> onCreate(Database db, int version) {
    db.rawQuery('''
      CREATE TABLE $taskTableName(
        ${describeEnum(TaskTable.id)} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${describeEnum(TaskTable.name)} TEXT,
        ${describeEnum(TaskTable.isDone)} INT
      )
      ''');

    db.rawQuery('''
          CREATE TABLE $noteTableName(
        ${describeEnum(NoteTable.id)} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${describeEnum(NoteTable.title)} TEXT,
        ${describeEnum(NoteTable.description)} TEXT,
        ${describeEnum(NoteTable.timestamp)} Text
      )
    ''');
  }
}
