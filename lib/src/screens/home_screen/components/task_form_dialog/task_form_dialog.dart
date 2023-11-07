import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:todo/src/core/result_types/either.dart';

import 'package:todo/src/core/enums/enums.dart';

import 'package:todo/src/providers/app_data_provider.dart';

import 'package:todo/src/screens/home_screen/bloc/tasks_bloc.dart';

import 'package:todo/src/screens/home_screen/components/simple_dialog_widget/simple_dialog_widget.dart';
import 'package:todo/src/screens/home_screen/components/task_form_dialog/task_form_widget/task_form_widget.dart';

import 'package:todo/src/screens/home_screen/models/create_task_model.dart';
import 'package:todo/src/screens/home_screen/models/task_model.dart';
import 'package:todo/src/screens/home_screen/models/update_task_model.dart';

import 'package:todo/src/utils/handle_error_util.dart';

class TaskFormDialog extends StatefulWidget {
  const TaskFormDialog({
    super.key,
    required this.formType,
    this.taskId,
    required this.tasksBloc,
    required this.simpleDialogContext,
  }) : assert(
          (formType == TaskFormType.update && taskId == null) == false,
          'Update type form needs task ID.',
        );

  final TaskFormType formType;
  final String? taskId;
  final TasksBloc tasksBloc;
  final BuildContext simpleDialogContext;

  @override
  State<TaskFormDialog> createState() => _TaskFormDialogState();
}

class _TaskFormDialogState extends State<TaskFormDialog> {
  final _tapRecognizer = TapGestureRecognizer();

  final _formKey = GlobalKey<FormState>();
  final _titleFieldController = TextEditingController();
  final _descriptionFieldController = TextEditingController();
  TaskModel? task;

  bool _hasFormData() {
    final formData = _getData();

    return formData.title.isNotEmpty || formData.description.isNotEmpty;
  }

  CreateTaskModel _getData() {
    final title = _titleFieldController.text;
    final description = _descriptionFieldController.text;

    return CreateTaskModel(
      title: title,
      description: description,
    );
  }

  Widget _getBody() {
    return TaskFormWidget(
      formKey: _formKey,
      titleFieldController: _titleFieldController,
      descriptionFieldController: _descriptionFieldController,
    );
  }

  void _showConfirmDiscardDialog(
    VoidCallback closeFormDialog,
  ) {
    showDialog(
      context: context,
      barrierColor: Colors.blue.withOpacity(0.2),
      builder: (simpleDialogContext) {
        return SimpleDialogWidget(
          simpleDialogContext: simpleDialogContext,
          title: 'Aviso',
          content:
              'Se fechar o formulário de criação de tarefa, todos os dados inseridos serão perdidos.\nDeseja sair mesmo assim?',
          actionTitle1: 'Não',
          actionTitle2: 'SIm',
          action1: null,
          action2: (closeFormDialog) {
            closeFormDialog();

            Navigator.pop(simpleDialogContext);
          },
        );
      },
    );
  }

  Future<void> _fetchData() async {
    final taskRepository = AppDataProvider.of(context)!.taskRepository;

    final result = await taskRepository.getOne(widget.taskId!);

    if (result is Success) {
      task = result.value;

      _fillFields();
    } else {}
  }

  void _fillFields() {
    _titleFieldController.text = task!.title;
    _descriptionFieldController.text = task!.description;
  }

  Future<void> _sendTask(
    VoidCallback closeFormDialog,
  ) async {
    if (_formKey.currentState!.validate()) {
      final taskRepository = AppDataProvider.of(context)!.taskRepository;

      late Either result;
      final data = _getData();

      if (widget.formType == TaskFormType.creation) {
        result = await taskRepository.create(data);
      } else {
        final updatedTask = UpdateTaskModel(
          title: data.title,
          description: data.description,
          isDone: task!.isDone,
        );

        result = await taskRepository.update(
          task!.id,
          updatedTask.toMap(),
        );
      }

      if (result is Success) {
        closeFormDialog();

        widget.tasksBloc.add(
          const TasksLoadingEvent(),
        );
      } else {
        _showTaskErrorDialog(
          (result as Failure),
          closeFormDialog,
        );
      }
    }
  }

  void _showTaskErrorDialog(
    Failure failure,
    VoidCallback closeFormDialog,
  ) {
    const actionTitle2 = 'Tentar novamente';

    void action2(VoidCallback closeSimpleDialog) {
      closeSimpleDialog();

      _sendTask(closeFormDialog);
    }

    handleErrorUtil(
      context,
      _tapRecognizer,
      failure,
      actionTitle2: actionTitle2,
      action2: action2,
    );
  }

  @override
  void dispose() {
    _tapRecognizer.dispose();

    _titleFieldController.dispose();
    _descriptionFieldController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialogWidget(
      simpleDialogContext: widget.simpleDialogContext,
      title:
          '${widget.formType == TaskFormType.creation ? 'Criar' : 'Atualizar'} Tarefa',
      body: FutureBuilder(
        future: widget.formType == TaskFormType.creation ? null : _fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CenterContentWidget(
              content: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const CenterContentWidget(
              content: Text(
                'Ocorreu um problema ao tentar carregar os dados',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }

          return _getBody();
        },
      ),
      actionTitle1: 'Fechar',
      actionTitle2:
          widget.formType == TaskFormType.creation ? 'Adicionar' : 'Atualizar',
      action1: (VoidCallback closeFormDialog) {
        final thereIsData = _hasFormData();

        if (thereIsData) {
          _showConfirmDiscardDialog(closeFormDialog);
        } else {
          closeFormDialog();
        }
      },
      action2: (closeFormDialog) async {
        FocusScope.of(context).unfocus();

        _sendTask(closeFormDialog);
      },
    );
  }
}

class CenterContentWidget extends StatelessWidget {
  const CenterContentWidget({
    super.key,
    required this.content,
  });

  final Widget content;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.0,
      width: double.infinity,
      child: Center(
        child: content,
      ),
    );
  }
}
