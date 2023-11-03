import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:todo/src/screens/home_screen/models/form_data_model.dart';
import 'package:todo/src/screens/home_screen/models/task_model.dart';
import 'package:todo/src/services/database_client_service.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final DatabaseClientService databaseService;

  TasksBloc({
    required this.databaseService,
  }) : super(const TasksInitial()) {
    on<TasksLoadingEvent>(_onTasksLoadingEvent);
    on<TaskCreateEvent>(_onTaskCreateEvent);
  }

  FutureOr<void> _onTasksLoadingEvent(
    TasksLoadingEvent event,
    Emitter<TasksState> emit,
  ) async {
    emit(const TasksLoadingState());

    final result = await databaseService.getAll();
    final tasks = result.map((data) {
      return TaskModel.fromMap(data);
    }).toList();

    emit(TasksLoadedState(
      tasks: tasks,
    ));
  }

  FutureOr<void> _onTaskCreateEvent(
    TaskCreateEvent event,
    Emitter<TasksState> emit,
  ) async {
    await databaseService.create(event.data);

    await _onTasksLoadingEvent(
      const TasksLoadingEvent(),
      emit,
    );
  }
}
