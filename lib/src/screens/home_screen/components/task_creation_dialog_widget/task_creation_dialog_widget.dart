import 'package:flutter/material.dart';

import 'package:todo/src/screens/home_screen/bloc/tasks_bloc.dart';

import 'package:todo/src/screens/home_screen/components/simple_dialog_widget/simple_dialog_widget.dart';
import 'package:todo/src/screens/home_screen/components/task_creation_dialog_widget/task_creation_dialog_form_widget/task_creation_dialog_form_widget.dart';

import 'package:todo/src/screens/home_screen/models/form_data_model.dart';

class TaskCreationDialogWidget extends StatefulWidget {
  const TaskCreationDialogWidget({
    super.key,
    required this.tasksBloc,
    required this.simpleDialogContext,
  });

  final TasksBloc tasksBloc;
  final BuildContext simpleDialogContext;

  @override
  State<TaskCreationDialogWidget> createState() =>
      _TaskCreationDialogWidgetState();
}

class _TaskCreationDialogWidgetState extends State<TaskCreationDialogWidget> {
  final _formKey = GlobalKey<FormState>();
  final _titleFieldController = TextEditingController();
  final _descriptionFieldController = TextEditingController();

  bool _hasFormData() {
    final formData = _getData();

    return formData.title.isNotEmpty || formData.description.isNotEmpty;
  }

  FormDataModel _getData() {
    final title = _titleFieldController.text;
    final description = _descriptionFieldController.text;

    return FormDataModel(
      title: title,
      description: description,
    );
  }

  Widget _getBody() {
    return TaskCreationDialogFormWidget(
      formKey: _formKey,
      titleFieldController: _titleFieldController,
      descriptionFieldController: _descriptionFieldController,
    );
  }

  void _showConfirmDiscardDialog(
    VoidCallback closeSimpleDialog,
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
          action2: (closeSimpleDialog) {
            Navigator.pop(simpleDialogContext);
            closeSimpleDialog();
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _titleFieldController.dispose();
    _descriptionFieldController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialogWidget(
      simpleDialogContext: widget.simpleDialogContext,
      title: 'Criar Tarefa',
      body: _getBody(),
      actionTitle1: 'Fechar',
      actionTitle2: 'Adicionar',
      action1: (VoidCallback closeSimpleDialog) {
        final thereIsData = _hasFormData();

        if (thereIsData) {
          _showConfirmDiscardDialog(closeSimpleDialog);
        } else {
          closeSimpleDialog();
        }
      },
      action2: (closeSimpleDialog) {
        if (_formKey.currentState!.validate()) {
          final data = _getData();

          widget.tasksBloc.add(
                TaskCreateEvent(
                  data: data,
                ),
              );

          closeSimpleDialog();
        }
      },
    );
  }
}
