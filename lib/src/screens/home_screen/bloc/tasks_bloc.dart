import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';

import 'package:todo/src/core/result_types/either.dart';

import 'package:todo/src/repositories/task_repository.dart';

import 'package:todo/src/screens/home_screen/models/form_data_model.dart';
import 'package:todo/src/screens/home_screen/models/task_model.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final TaskRepository taskRepository;

  TasksBloc({
    required this.taskRepository,
  }) : super(const TasksInitial()) {
    on<TasksLoadingEvent>(_onTasksLoadingEvent);
    on<TaskCreateEvent>(_onTaskCreateEvent);
  }

  FutureOr<void> _onTasksLoadingEvent(
    TasksLoadingEvent event,
    Emitter<TasksState> emit,
  ) async {
    emit(
      const TasksLoadingState(),
    );

    final result = await taskRepository.getAll();

    if (result is Success) {
      emit(
        TasksLoadedState(
          tasks: result.value,
        ),
      );
    }
  }

  FutureOr<void> _onTaskCreateEvent(
    TaskCreateEvent event,
    Emitter<TasksState> emit,
  ) async {
    await taskRepository.create(event.data);

    await _onTasksLoadingEvent(
      const TasksLoadingEvent(),
      emit,
    );
  }
}
