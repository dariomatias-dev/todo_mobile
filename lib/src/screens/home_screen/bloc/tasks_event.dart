part of 'tasks_bloc.dart';

abstract class TasksEvent extends Equatable {
  const TasksEvent();

  @override
  List<Object?> get props => [];
}

class TasksLoadingEvent extends TasksEvent {
  const TasksLoadingEvent();
}

class TaskCreateEvent extends TasksEvent {
  const TaskCreateEvent({
    required this.data,
  });

  final CreateTaskModel data;

  @override
  List<Object?> get props => [data];
}

class TasksUpdateEvent extends TasksEvent {
  const TasksUpdateEvent({
    required this.taskId,
    required this.data,
  });

  final String taskId;
  final UpdateTaskModel data;

  @override
  List<Object?> get props => [taskId, data];
}

class TasksDeleteEvent extends TasksEvent {
  const TasksDeleteEvent({
    required this.taskId,
  });

  final String taskId;

  @override
  List<Object?> get props => [taskId];
}
