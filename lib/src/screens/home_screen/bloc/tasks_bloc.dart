import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  TasksBloc() : super(TasksInitial()) {
    on<TasksLoadingEvent>(_onTasksLoadingEvent);
  }

  FutureOr<void> _onTasksLoadingEvent(
    TasksLoadingEvent event,
    Emitter<TasksState> emit,
  ) async {}
}
