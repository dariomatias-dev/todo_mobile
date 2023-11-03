import 'package:flutter/material.dart';

import 'package:todo/src/providers/app_data_provider.dart';

import 'package:todo/src/repositories/task_repository.dart';

import 'package:todo/src/services/database_client_service.dart';

import 'package:todo/src/todo_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final databaseService = DatabaseClientService();
  final initializedDatabaseService = await databaseService.init();

  final taskRepository = TaskRepository(
    databaseService: databaseService,
  );

  runApp(
    AppDataProvider(
      taskRepository: taskRepository,
      child: TodoApp(
        databaseService: databaseService,
        initializedDatabaseService: initializedDatabaseService,
      ),
    ),
  );
}
