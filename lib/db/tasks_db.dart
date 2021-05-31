import 'dart:convert';
import 'package:fam_church/models/task_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class TasksDatabase {
  static final TasksDatabase instance = TasksDatabase._init();

  static Database? _database;

  TasksDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('tasks.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';
    final integerType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE $tasks ( 
  ${TaskFields.id} $idType, 
  ${TaskFields.isImportant} $boolType,
  ${TaskFields.number} $integerType,
  ${TaskFields.title} $textType,
  ${TaskFields.description} $textType,
  ${TaskFields.time} $textType
  )
''');
  }

// creave a nove
  Future<TaskModel> create(TaskModel taskModel) async {
    final db = await instance.database;
    //final json = taskModel.toJson();
    // final columns =
    //     '${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time}';

    // final values =
    //     '${json[NoteFields.title]}, ${json[NoteFields.description]}, ${json[NoteFields.time]}';

    // final id =
    //     await db.rawInsert('INSERt INtO table_name ($columns) VALUES($values)');

    final id = await db.insert(tasks, taskModel.toJson());
    return taskModel.copy(id: id);
  }

//read notes
  Future<TaskModel?> readNote(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tasks,
      columns: TaskFields.values,
      where: '${TaskFields.id} = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return TaskModel.fromJson(maps.first);
    } else {
      return null;
    }
  }

//read all avail notes
  Future<List<TaskModel>> readAllNotes() async {
    final db = await instance.database;
    final orderBy = '${TaskFields.time} ASC';
    // final result =
    //     await db.rawQuery('SELECt *FROM $tableTask ORDER BY $orderBy');

    final result = await db.query(tasks, orderBy: orderBy);

    return result.map((json) => TaskModel.fromJson(json)).toList();
  }

//update your notes
  Future<int> update(TaskModel taskModel) async {
    final db = await instance.database;

    return db.update(
      tasks,
      taskModel.toJson(),
      where: '${TaskFields.id} = ?',
      whereArgs: [taskModel.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tasks,
      where: '${TaskFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
