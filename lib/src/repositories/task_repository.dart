import 'package:todo/src/core/result_types/either.dart';

import 'package:todo/src/screens/home_screen/models/form_data_model.dart';
import 'package:todo/src/screens/home_screen/models/task_model.dart';

import 'package:todo/src/services/database_client_service.dart';

class TaskRepository {
  TaskRepository();

  static const table = 'task';

  static const columnId = 'id';
  static const columnTitle = 'title';
  static const columnDescription = 'description';
  static const columnIsDone = 'is_done';

  static const columns = [
    columnId,
    columnTitle,
    columnDescription,
    columnIsDone,
  ];

  static const createTableQuery = '''
      CREATE TABLE $table (
        $columnId TEXT PRIMARY KEY,
        $columnTitle TEXT NOT NULL,
        $columnDescription TEXT NOT NULL,
        $columnIsDone INTEGER NOT NULL
      )
    ''';

  final _databaseClientService = DatabaseClientService(
    table: table,
    columns: columns,
    createTableQuery: createTableQuery,
  );

  Future<void> init() async {
    await _databaseClientService.init();
  }

  Future<Either> create(FormDataModel data) async {
    final task = {
      'title': data.title,
      'description': data.description,
      'is_done': 0,
    };

    return await _databaseClientService.create(task);
  }

  Future<Either> getAll() async {
    final result = await _databaseClientService.getAll();

    if (result is Success) {
      final tasks = (result.value as List<Map<String, Object?>>).map((data) {
        return TaskModel.fromMap(data);
      }).toList();

      return Success(
        value: tasks,
      );
    }

    return result;
  }

  Future<Either> getCount() async {
    return await _databaseClientService.getCount();
  }

  Future<Either> update(String id, Map<String, dynamic> data) async {
    return await _databaseClientService.update(
      id,
      data,
    );
  }

  Future<Either> delete(String id) async {
    return await _databaseClientService.delete(id);
  }

  Future<void> dispose() async {
    await _databaseClientService.dispose();
  }
}
