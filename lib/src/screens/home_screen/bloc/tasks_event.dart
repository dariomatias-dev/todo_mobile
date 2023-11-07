part of 'tasks_bloc.dart';

abstract class TasksEvent extends Equatable {
  const TasksEvent();

  @override
  List<Object?> get props => [];
}

class TasksLoadingEvent extends TasksEvent {
  const TasksLoadingEvent();
}

class TasksDeleteEvent extends TasksEvent {
  const TasksDeleteEvent({
    required this.taskId,
  });

  final String taskId;

  @override
  List<Object?> get props => [taskId];
}
