import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

import '../../core/utils/note_table.dart';
import 'db_provider.dart';

class NoteProvider {
  NoteProvider._privateConstructor();

  static final NoteProvider instance = NoteProvider._privateConstructor();
 

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await DBProvider.instance.database;
    return await db.insert(DBProvider.noteTableName, row);
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    Database db = await DBProvider.instance.database;
    return await db.query(DBProvider.noteTableName);
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await DBProvider.instance.database;
    String id = describeEnum(NoteTable.id);
    return await db.update(
      DBProvider.noteTableName,
      row,
      where: '$id = ?',
      whereArgs: [row[id]],
    );
  }

  Future<int> delete(Map<String, dynamic> row) async {
    Database db = await DBProvider.instance.database;
    String id = describeEnum(NoteTable.id);
    return await db.delete(
      DBProvider.noteTableName,
      where: '$id = ?',
      whereArgs: [row[id]],
    );
  }
}
