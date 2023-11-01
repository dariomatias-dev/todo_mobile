import 'package:flutter/material.dart';

import 'package:todo/src/core/routes/todo_routes.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lista de Tarefas',
      routes: todoRoutes,
    );
  }
}
