import 'package:todo/src/core/result_types/either.dart';

import 'package:todo/src/screens/home_screen/models/form_data_model.dart';

import 'package:todo/src/services/database_client_service.dart';

class TaskRepository {
  const TaskRepository({
    required this.databaseService,
  });

  final DatabaseClientService databaseService;

  static const table = 'task';

  static const columnId = 'id';
  static const columnTitle = 'title';
  static const columnDescription = 'description';
  static const columnIsDone = 'is_done';

  Future<Either> create(FormDataModel data) async {
    return const Success(value: null);
  }

  Future<Either> getAll() async {
    return const Success(value: [null]);
  }

  Future<Either> getCount() async {
    return const Success(value: null);
  }

  Future<Either> update(Map<String, dynamic> row) async {
    return const Success(value: null);
  }

  Future<Either> delete(int id) async {
    return const Success(value: null);
  }
}
