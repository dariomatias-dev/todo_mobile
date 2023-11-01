import 'package:flutter/material.dart';

import 'package:todo/src/screens/home_screen/components/simple_dialog_widget/simple_dialog_form_widget/text_form_field_widget.dart';

class SimpleDialogFormWidget extends StatefulWidget {
  const SimpleDialogFormWidget({super.key});

  @override
  State<SimpleDialogFormWidget> createState() => _SimpleDialogFormWidgetState();
}

class _SimpleDialogFormWidgetState extends State<SimpleDialogFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _titleFieldController = TextEditingController();
  final _descriptionFieldController = TextEditingController();

  @override
  void dispose() {
    _titleFieldController.dispose();
    _descriptionFieldController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormFieldWidget(
            controller: _titleFieldController,
            title: 'Título',
            hintText: 'Estudar Flutter',
          ),
          const SizedBox(height: 16.0),
          TextFormFieldWidget(
            controller: _descriptionFieldController,
            title: 'Descrição',
            hintText: 'Avançar os meus estudos sobre BLoC',
            maxLines: 4,
          ),
        ],
      ),
    );
  }
}
