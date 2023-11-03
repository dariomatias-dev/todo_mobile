import 'package:flutter/material.dart';

import 'package:todo/src/repositories/task_repository.dart';

import 'package:todo/src/todo_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final taskRepository = TaskRepository();
  await taskRepository.init();

  runApp(
    TodoApp(
      taskRepository: taskRepository,
    ),
  );
}
