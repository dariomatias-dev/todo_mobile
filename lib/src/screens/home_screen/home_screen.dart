import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/src/core/result_types/either.dart';

import 'package:todo/src/providers/app_data_provider.dart';

import 'package:todo/src/repositories/task_repository.dart';

import 'package:todo/src/screens/home_screen/bloc/tasks_bloc.dart';

import 'package:todo/src/screens/home_screen/components/floating_action_button_widget.dart';
import 'package:todo/src/screens/home_screen/components/simple_dialog_widget/simple_dialog_widget.dart';
import 'package:todo/src/screens/home_screen/components/task_card_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _showInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (simpleDialogContext) {
        return SimpleDialogWidget(
          simpleDialogContext: simpleDialogContext,
          title: 'Informação',
          content:
              'Esse projeto foi criado com o objetivo de colocar em prática os meus conhecimentos adquidos com os estudos iniciais de BLoC, Repository Pattern e tratamento de erros.',
          actionTitle1: 'Fechar',
          action1: (closeSimpleDialog) {
            closeSimpleDialog();
          },
        );
      },
    );
  }

  void _handleError(BuildContext context, Failure failure) {
    const defaultMessage =
        '\nPor favor, tente novamente ou volte mais tarde.\nCaso persista informe os desenvolvedores.';

    String title = 'Erro';
    String content = 'Ocorreu um problema ao carregar os dados.$defaultMessage';
    String actionTitle1 = 'Fechar';
    String? actionTitle2;

    void action1(closeSimpleDialog) {
      closeSimpleDialog();
    }

    void action2(closeSimpleDialog) {
      closeSimpleDialog();
    }

    if (failure.type == FailureType.databaseClosed) {
      content = 'O banco de dados fechou inesperadamente.$defaultMessage';
    } else if (failure.type == FailureType.platform) {
      content =
          'O seu dispositivo é incompatível com o sistema de armazenamento utilizado.';
    }

    showDialog(
      context: context,
      builder: (simpleDialogContext) {
        return SimpleDialogWidget(
          simpleDialogContext: simpleDialogContext,
          title: title,
          content: content,
          actionTitle1: actionTitle1,
          actionTitle2: actionTitle2,
          action1: action1,
          action2: action2,
        );
      },
    );
  }

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
            )..add(
                const TasksLoadingEvent(),
              ),
          ),
        ],
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: const Text('Lista de Tarefas'),
            actions: [
              IconButton(
                onPressed: () => _showInfoDialog(context),
                icon: const Icon(
                  Icons.info_outline,
                ),
              ),
            ],
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
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                }

                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 16.0,
                      right: 14.0,
                      bottom: 88.0,
                      left: 14.0,
                    ),
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: tasks.length,
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 6.0);
                      },
                      itemBuilder: (context, index) {
                        final task = tasks[index];

                        return TaskCardWidget(
                          taskRepository: taskRepository,
                          task: task,
                        );
                      },
                    ),
                  ),
                );
              } else if (state is TasksErrorState) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _handleError(
                    context,
                    state.failure,
                  );
                });

                return const Center(
                  child: Text(
                    'Não foi possível carregar os dados',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
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
