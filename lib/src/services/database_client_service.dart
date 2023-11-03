import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

import 'package:todo/src/screens/home_screen/models/form_data_model.dart';

class DatabaseClientService {
  static const _databaseName = "todo.db";
  static const _databaseVersion = 1;

  static const table = 'task';

  static const columnId = 'id';
  static const columnTitle = 'title';
  static const columnDescription = 'description';
  static const columnIsDone = 'is_done';

  late Database _db;

  Future<void> init() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);

    _db = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int _) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId TEXT PRIMARY KEY,
        $columnTitle TEXT NOT NULL,
        $columnDescription TEXT NOT NULL,
        $columnIsDone INTEGER NOT NULL
      )
    ''');
  }

  Future<void> create(FormDataModel data) async {
    const uuid = Uuid();
    final id = uuid.v4();

    await _db.insert(
      table,
      {
        'id': id,
        'title': data.title,
        'description': data.description,
        'is_done': 0,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getAll() async {
    return await _db.query(table);
  }

  Future<int> getCount() async {
    final results = await _db.rawQuery('SELECT COUNT(*) FROM $table');

    return Sqflite.firstIntValue(results) ?? 0;
  }

  Future<int> update(Map<String, dynamic> row) async {
    int id = row[columnId];

    return await _db.update(
      table,
      row,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future<int> delete(int id) async {
    return await _db.delete(
      table,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future<void> dispose() async {
    await _db.close();
  }
}
