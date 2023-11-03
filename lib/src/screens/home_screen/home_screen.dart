import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo/src/screens/home_screen/bloc/tasks_bloc.dart';

import 'package:todo/src/screens/home_screen/components/floating_action_button_widget.dart';

import 'package:todo/src/services/database_client_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final databaseService = DatabaseClientService();

  Future<void> initializeDatabase() async {
    await databaseService.init();
  }

  @override
  void dispose() {
    databaseService.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: databaseService,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => TasksBloc(
              databaseService: context.read<DatabaseClientService>(),
            )..add(const TasksLoadingEvent()),
          ),
        ],
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: const Text('Lista de Tarefas'),
          ),
          body: FutureBuilder(
            future: initializeDatabase(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return BlocBuilder<TasksBloc, TasksState>(
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
                );
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          floatingActionButton: const FloatingActionButtonWidget(),
        ),
      ),
    );
  }
}
