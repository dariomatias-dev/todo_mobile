part of 'tasks_bloc.dart';

abstract class TasksEvent extends Equatable {
  const TasksEvent();

  @override
  List<Object?> get props => [];
}

class TasksLoadingEvent extends TasksEvent {}

class TaskCreateEvent extends TasksEvent {
  const TaskCreateEvent({
    required this.data,
  });

  final FormDataModel data;

  @override
  List<Object?> get props => [data];
}
