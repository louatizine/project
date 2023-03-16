import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

import '../models/task.dart';

class DBhelper{
  static const int _version = 1;
  static const String _tableName = 'tasks';
  static Database? db;

  static Future<void> initDb() async {
    if (db != null) {
      debugPrint('not null db');
    } else {
      try {
        String path = await getDatabasesPath() + 'task.db';
        db = await openDatabase(
          path,
          version: _version,
          onCreate: (db, version) async {
            await db.execute(
              'CREATE TABLE $_tableName ('
                  'id INTEGER PRIMARY KEY AUTOINCREMENT,'
                  ' title STRING, '
                  ' note TEXT, '
                  ' date STRING, '
                  ' startTime STRING, '
                  ' endTime STRING, '
                  ' remind INTEGER,'
                  ' repeat STRING, '
                  ' color INTEGER,'
                  ' isCompleted INTEGER)',
            );
          },
        );
      } catch (e) {
        print(e);
      }
    }
  }
static Future<int> insert(Task? task) async{
    print("insert function called");
    return await db?.insert(_tableName, task!.tojson())??1;
  }

static Future< List < Map <String, dynamic> > > query(){
    print("query function called");
    return  db!.query(_tableName);
  }

  static delete(Task task)async{
    return await db!.delete(_tableName, where: 'id=?', whereArgs: [task.id]);
  }

  static update(int id)async{
     return await  db!.rawUpdate('''
    UPDATE tasks
    set isCompleted = ? where id = ?  
    ''', [1, id]);
  }
}