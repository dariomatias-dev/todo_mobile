import 'package:flutter/material.dart';

import 'package:todo/src/screens/home_screen/components/simple_dialog_widget/simple_dialog_form_widget/text_form_field_widget.dart';

class SimpleDialogFormWidget extends StatefulWidget {
  const SimpleDialogFormWidget({
    super.key,
    required this.formKey,
    required this.titleFieldController,
    required this.descriptionFieldController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController titleFieldController;
  final TextEditingController descriptionFieldController;

  @override
  State<SimpleDialogFormWidget> createState() => _SimpleDialogFormWidgetState();
}

class _SimpleDialogFormWidgetState extends State<SimpleDialogFormWidget> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          TextFormFieldWidget(
            controller: widget.titleFieldController,
            title: 'Título',
            hintText: 'Estudar Flutter',
            minLength: 3,
            maxLength: 20,
          ),
          const SizedBox(height: 16.0),
          TextFormFieldWidget(
            controller: widget.descriptionFieldController,
            title: 'Descrição',
            hintText: 'Avançar os meus estudos sobre BLoC',
            minLength: 3,
            maxLength: 128,
            maxLines: 4,
          ),
        ],
      ),
    );
  }
}
