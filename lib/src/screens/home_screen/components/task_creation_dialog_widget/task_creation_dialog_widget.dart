import 'package:flutter/material.dart';

import 'package:todo/src/screens/home_screen/components/simple_dialog_widget/simple_dialog_widget.dart';
import 'package:todo/src/screens/home_screen/components/task_creation_dialog_widget/task_creation_dialog_form_widget/task_creation_dialog_form_widget.dart';

import 'package:todo/src/screens/home_screen/models/form_data_model.dart';

class TaskCreationDialogWidget extends StatefulWidget {
  const TaskCreationDialogWidget({
    super.key,
    required this.simpleDialogContext,
  });

  final BuildContext simpleDialogContext;

  @override
  State<TaskCreationDialogWidget> createState() =>
      _TaskCreationDialogWidgetState();
}

class _TaskCreationDialogWidgetState extends State<TaskCreationDialogWidget> {
  final _formKey = GlobalKey<FormState>();
  final _titleFieldController = TextEditingController();
  final _descriptionFieldController = TextEditingController();

  bool hasFormData() {
    final formData = getData();

    return formData.title.isNotEmpty || formData.description.isNotEmpty;
  }

  FormDataModel getData() {
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
      action1: null,
      action2: null,
    );
  }
}
