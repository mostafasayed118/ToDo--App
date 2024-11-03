import 'dart:developer';

import 'package:sqflite/sqflite.dart';

import '../../../features/task/data/model/task_model.dart';

class SqfliteHelper {
  Database? _db;

  //? 1. create DB
  //? 2.create Table
  //? 3.CRUD => Create - Read - Update - Delete

  //! initDatabase
  Future<void> initDB() async {
    //! step 1 => Create database
    try {
      _db = await openDatabase(
        'tasks.db',
        version: 1,
        onCreate: (Database db, int version) async {
          log('Database created successfully');

          //! step 2 => create table
          await db.execute('''
            CREATE TABLE Tasks (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              title TEXT,
              note TEXT,
              date TEXT,
              startTime TEXT,
              endTime TEXT,
              color INTEGER,
              isCompleted INTEGER
            )
          ''');
          log('Table created successfully');
        },
        onOpen: (db) => log('Database opened'),
      );
    } catch (e) {
      log('Error when opening database: $e');
    }
  }

  //! get
  Future<List<Map<String, dynamic>>> getFromDB() async {
    if (_db == null) {
      throw Exception('Database is not initialized');
    }
    return await _db!.query('Tasks');
  }

  //! insert
  Future<int> insertToDB(TaskModel model) async {
    if (_db == null) {
      throw Exception('Database is not initialized');
    }
    return await _db!.insert('Tasks', {
      'id': model.id,
      'title': model.title,
      'note': model.note,
      'date': model.date,
      'startTime': model.startTime,
      'endTime': model.endTime,
      'color': model.color,
      'isCompleted': model.isCompleted,
    });
  }

  //! update
  Future<int> updateDB(
    int id,
  ) async {
    if (_db == null) {
      throw Exception('Database is not initialized');
    }
    return await _db!.update(
      'Tasks',
      {'isCompleted': 1},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  //! delete
  Future<int> deleteFromDB(int id) async {
    if (_db == null) {
      throw Exception('Database is not initialized');
    }
    return await _db!.delete(
      'Tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
