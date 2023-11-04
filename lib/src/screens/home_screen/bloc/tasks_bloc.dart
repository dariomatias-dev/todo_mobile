import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';

import 'package:todo/src/core/result_types/either.dart';

import 'package:todo/src/repositories/task_repository.dart';

import 'package:todo/src/screens/home_screen/models/form_data_model.dart';
import 'package:todo/src/screens/home_screen/models/task_model.dart';
import 'package:todo/src/screens/home_screen/models/update_task_model.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final TaskRepository taskRepository;

  TasksBloc({
    required this.taskRepository,
  }) : super(const TasksInitial()) {
    on<TasksLoadingEvent>(_onTasksLoadingEvent);
    on<TaskCreateEvent>(_onTaskCreateEvent);
    on<TasksUpdateEvent>(_onTasksUpdateEvent);
    on<TasksDeleteEvent>(_onTasksDeleteEvent);
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

  FutureOr<void> _onTasksUpdateEvent(
    TasksUpdateEvent event,
    Emitter<TasksState> emit,
  ) async {
    final data = event.data.toMap();

    await taskRepository.update(event.taskId, data);

    await _onTasksLoadingEvent(
      const TasksLoadingEvent(),
      emit,
    );
  }

  FutureOr<void> _onTasksDeleteEvent(
    TasksDeleteEvent event,
    Emitter<TasksState> emit,
  ) async {
    await taskRepository.delete(event.taskId);

    await _onTasksLoadingEvent(
      const TasksLoadingEvent(),
      emit,
    );
  }
}
