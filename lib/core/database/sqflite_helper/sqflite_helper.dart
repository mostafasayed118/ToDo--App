// <<<<<<< ORIGINAL
// import 'dart:developer';

// import 'package:sqflite/sqflite.dart';

// import '../../../features/task/data/model/task_model.dart';

// class SqfliteHelper {
//   Database? db;

//   //? 1. create DB
//   //? 2.create Table
//   //? 3.CRUD => Create - Read - Update - Delete

//   //! initDatabase
//   void initDB() async {
//     //! step 1 => Create database

//     await openDatabase(
//       'tasks.db',
//       version: 1,
//       onCreate: (Database db, int v) async {
//         log('database created successfully');

//         //! step 2 => create table

//         return await db.execute('''
//       CREATE TABLE Tasks (
//         id INTEGER PRIMARY KEY AUTOINCREMENT ,
//         title TEXT,
//         note TEXT,
//         date TEXT,
//         startTime TEXT,
//         endTime TEXT,
//         color INTEGER,
//         isCompleted INTEGER )
//       ''').then(
//           (value) => log('DB created successfully'),
//         );
//       },
//       onOpen: (db) => log('Database opened'),
//     ).then((value) => db = value).catchError((e) {
//       log('Error when open database $e');
//     });
//   }

//   //! get
//   Future<List<Map<String, dynamic>>> getFromDB() async {
//     return await db!.rawQuery('SELECT * FROM Tasks');
//   }

//   //! insert
//   Future<int> insertToDB(TaskModel model) async {
//     return await db!.rawInsert('''
//       INSERT INTO Tasks(
//       title ,note ,date ,startTime ,endTime ,color ,isCompleted )
//          VALUES
//          ('${model.title}','${model.note}','${model.date}','${model.startTime}',
//        '${model.endTime}','${model.color}','${model.isCompleted}')''');
//   }

//   //! update
//   Future<int> updatedDB(int id) async {
//     return await db!.rawUpdate('''
//     UPDATE Tasks
//     SET isCompleted = ?
//     WHERE id = ?
//    ''', [1, id]);
//   }

//   //! delete
//   Future<int> deleteFromDB(int id) async {
//     return await db!.rawDelete(
//       '''DELETE FROM Tasks WHERE id = ?''',
//       [id],
//     );
//   }
// }

// =======
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
