import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo/src/providers/app_data_provider.dart';

import 'package:todo/src/repositories/task_repository.dart';

import 'package:todo/src/screens/home_screen/bloc/tasks_bloc.dart';
import 'package:todo/src/screens/home_screen/components/floating_action_button_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final taskRepository = AppDataProvider.of(context)!.taskRepository;

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: taskRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => TasksBloc(
              taskRepository: context.read<TaskRepository>(),
            ),
          ),
        ],
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: const Text('Lista de Tarefas'),
          ),
          body: BlocBuilder<TasksBloc, TasksState>(
            builder: (context, state) {
              if (state is TasksLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is TasksLoadedState) {
                final tasks = state.tasks;

                if (tasks.isEmpty) {
                  return const Center(
                    child: Text(
                      'A lista está vazia.\nComece criando uma tarefa!',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];

                    return CheckboxListTile(
                      title: Text(task.title),
                      subtitle: Text(task.description),
                      value: task.isDone,
                      onChanged: null,
                    );
                  },
                );
              }

              return Container();
            },
          ),
          floatingActionButton: const FloatingActionButtonWidget(),
        ),
      ),
    );
  }
}
