import 'package:flutter/material.dart';

import 'package:todo/src/core/routes/todo_routes.dart';
import 'package:todo/src/providers/app_data_provider.dart';
import 'package:todo/src/repositories/task_repository.dart';

class TodoApp extends StatefulWidget {
  const TodoApp({
    super.key,
    required this.taskRepository,
  });

  final TaskRepository taskRepository;

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  @override
  void dispose() {
    widget.taskRepository.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppDataProvider(
      taskRepository: widget.taskRepository,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Lista de Tarefas',
        routes: todoRoutes,
      ),
    );
  }
}
