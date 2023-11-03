import 'package:flutter/material.dart';

import 'package:todo/src/core/result_types/either.dart';
import 'package:todo/src/core/routes/todo_routes.dart';

import 'package:todo/src/services/database_client_service.dart';

class TodoApp extends StatefulWidget {
  const TodoApp({
    super.key,
    required this.databaseService,
    required this.initializedDatabaseService,
  });

  final DatabaseClientService databaseService;
  final Either<Exception, dynamic> initializedDatabaseService;

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  @override
  void dispose() {
    widget.databaseService.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lista de Tarefas',
      routes: todoRoutes,
    );
  }
}
