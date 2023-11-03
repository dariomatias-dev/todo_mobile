import 'package:flutter/material.dart';

import 'package:todo/src/repositories/task_repository.dart';

class AppDataProvider extends InheritedWidget {
  const AppDataProvider({
    super.key,
    required this.taskRepository,
    required final Widget child,
  }) : super(child: child);

  final TaskRepository taskRepository;

  static AppDataProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppDataProvider>();
  }

  @override
  bool updateShouldNotify(AppDataProvider oldWidget) {
    return false;
  }
}
