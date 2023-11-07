import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';

import 'package:todo/src/core/result_types/either.dart';

import 'package:todo/src/repositories/task_repository.dart';

import 'package:todo/src/screens/home_screen/models/task_model.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final TaskRepository taskRepository;

  TasksBloc({
    required this.taskRepository,
  }) : super(const TasksInitial()) {
    on<TasksLoadingEvent>(_onTasksLoadingEvent);
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
    } else if (result is Failure) {
      emit(
        TasksErrorState(
          failure: result,
        ),
      );
    }
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
