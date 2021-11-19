import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/model/todo_model.dart';

class SQLiteDbProvider with ChangeNotifier {
  static const tableName = "Task";
  List<TodoTask> _tasks = [];

  List<TodoTask> get tasks {
    return [..._tasks];
  }

  int get taskCount {
    return _tasks.length;
  }

  SQLiteDbProvider._();
  static final SQLiteDbProvider db = SQLiteDbProvider._();
  Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await getDatabaseInstance();
    return _database;
  }

  Future<Database> getDatabaseInstance() async {
    var directory = await getDatabasesPath();
    String path = join(directory, "$tableName.db");
    return await openDatabase(path, version: 2,
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE $tableName ("
          "id integer primary key AUTOINCREMENT,"
          "taskName TEXT,"
          "isDone TEXT,"
          "taskTime TEXT"
          ")");
    });
  }

  addTaskToDatabase(TodoTask task) async {
    final db = await database;
    _tasks.insert(0, task);
    notifyListeners();
    var raw = await db?.insert(
      tableName,
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print('raw $raw');
    return raw;
  }

  updateTask(TodoTask task) async {
    final db = await database;
    var response = await db?.update(tableName, task.toMap(),
        where: "id = ?", whereArgs: [task.id]);
    notifyListeners();
    return response;
  }

  Future<List<TodoTask>> getAllPersons() async {
    final db = await database;
    var response = await db?.query(tableName);
    _tasks = response!.map((c) => TodoTask.fromMap(c)).toList();
    notifyListeners();
    return _tasks;
  }

  deletePersonWithId(TodoTask task) async {
    _tasks.removeWhere((element) => element.id == task.id);
    final db = await database;
    notifyListeners();
    return db?.delete(tableName, where: "id = ?", whereArgs: [task.id]);
  }

  void reOrderTask(int oldIndex, int newIndex) {
    final movedTask = _tasks.removeAt(oldIndex);
    int lastIndex = taskCount;

    if (newIndex > oldIndex) {
      var lastTask = _tasks[lastIndex - 1];
      if (lastIndex <= (newIndex)) {
        if (lastTask.isDonne == 1) {
          movedTask.isDonne = false;
        } else {
          movedTask.isDonne = true;
        }
      }
      _tasks.insert(newIndex - 1, movedTask);
      db.updateTask(movedTask);
    } else {
      _tasks.insert(newIndex, movedTask);
    }
    notifyListeners();
  }

  void deleteAll() {
    _tasks.clear();
    db.deleteAll();
  }
}
