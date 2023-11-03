part of 'tasks_bloc.dart';

abstract class TasksState extends Equatable {
  const TasksState();

  @override
  List<Object?> get props => [];
}

class TasksInitial extends TasksState {
  const TasksInitial();
}

class TasksLoadingState extends TasksState {
  const TasksLoadingState();
}

class TasksLoadedState extends TasksState {
  const TasksLoadedState({
    required this.tasks,
  });

  final List<TaskModel> tasks;

  @override
  List<Object?> get props => [tasks];
}
