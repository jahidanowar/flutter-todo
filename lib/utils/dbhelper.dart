import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo/models/todo.dart';

class DbHelper {
  final int version = 1;
  late Database db;

  Future<void> openDb() async {
    var dbPath = join(await getDatabasesPath(), 'todo_db.sqlite');
    db = await openDatabase(
      dbPath,
      version: version,
      onCreate: _createDb,
    );
  }

  void _createDb(newDb, version) {
    newDb.execute(
        'CREATE TABLE todos (id INTEGER PRIMARY KEY, title TEXT, completed INTEGER)');
  }

  Future<int> insert(Todo todo) async {
    int result = await db.insert(
      'todos',
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return result;
  }

  Future<List<Todo>> getAll() async {
    List<Map<String, dynamic>> result =
        await db.query('todos', orderBy: 'id DESC');
    List<Todo> todos = result.map((e) => Todo.fromMap(e)).toList();
    return todos;
  }

  Future<int> delete(int? id) async {
    int result = await db.delete('todos', where: 'id = ?', whereArgs: [id]);
    return result;
  }

  Future<int> update(int? id, int completed) async {
    int result = await db.update(
      'todos',
      {'completed': completed},
      where: 'id = ?',
      whereArgs: [id],
    );
    return result;
  }
}
