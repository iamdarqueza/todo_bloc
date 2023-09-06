import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo_bloc/data/local/task.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'tasks_database.db');
    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        description TEXT,
        dateCreated TEXT,
        dueDate TEXT,
        isCompleted INTEGER
      )
    ''');
  }

  Future<void> insertTask(Task task) async {
    final db = await instance.database;
    await db.insert('tasks', task.toMap());
  }

  Future<void> deleteTask(int taskId) async {
    final db = await instance.database;
    await db.delete('tasks', where: 'id = ?', whereArgs: [taskId]);
  }

  Future<void> updateExistingTask(Task task) async {
    final db = await instance.database;

    final updatedTask = {
      'title': task.title,
      'description': task.description,
      'dueDate': task.dueDate,
    };

    await db.update(
      'tasks',
      updatedTask,
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<void> toggleTaskCompletion(int taskId) async {
    final db = await instance.database;

    // Fetch the current isCompleted status
    final currentStatus = await db.rawQuery(
      'SELECT isCompleted FROM tasks WHERE id = ?',
      [taskId],
    );

    if (currentStatus.isNotEmpty) {
      final isCompleted = currentStatus[0]['isCompleted'] == 1 ? 0 : 1;

      // Update the task with the opposite status
      await db.rawUpdate(
        'UPDATE tasks SET isCompleted = ? WHERE id = ?',
        [isCompleted, taskId],
      );
    }
  }

  Future<void> updateTask(int taskId) async {
    final db = await instance.database;
    await db.rawUpdate(
        'UPDATE tasks SET isCompleted = NOT isCompleted WHERE id = ?',
        [taskId]);
  }

  Future<List<Task>> getAllTasks() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('tasks');
    return List.generate(maps.length, (i) {
      return Task.fromMap(maps[i]);
    });
  }

  Future<Task?> getTaskById(int taskId) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'tasks',
      where: 'id = ?',
      whereArgs: [taskId],
    );

    if (maps.isNotEmpty) {
      return Task.fromMap(maps.first);
    } else {
      return null; // Return null if no task with the specified ID is found.
    }
  }

  Future<List<Task>> getCustomTasks({bool? completed}) async {
    final db = await instance.database;

    List<Map<String, dynamic>> maps;

    if (completed != null) {
      // Filter tasks based on the 'isCompleted' column
      maps = await db.query('tasks',
          where: 'isCompleted = ?', whereArgs: [completed ? 1 : 0]);
    } else {
      // Retrieve all tasks if 'completed' is null
      maps = await db.query('tasks');
    }

    return List.generate(maps.length, (i) {
      return Task.fromMap(maps[i]);
    });
  }
}
