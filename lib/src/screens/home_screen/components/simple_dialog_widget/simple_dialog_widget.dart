import 'package:flutter/material.dart';

import 'package:todo/src/screens/home_screen/components/simple_dialog_widget/simple_dialog_action_widget.dart';
import 'package:todo/src/screens/home_screen/components/simple_dialog_widget/simple_dialog_form_widget/simple_dialog_form_widget.dart';
import 'package:todo/src/screens/home_screen/models/form_data_model.dart';

class SimpleDialogWidget extends StatefulWidget {
  const SimpleDialogWidget({
    super.key,
    required this.alertDialogContext,
  });

  final BuildContext alertDialogContext;

  @override
  State<SimpleDialogWidget> createState() => _SimpleDialogWidgetState();
}

class _SimpleDialogWidgetState extends State<SimpleDialogWidget> {
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

  @override
  void dispose() {
    _titleFieldController.dispose();
    _descriptionFieldController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      backgroundColor: Colors.black,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          36.0,
        ),
      ),
      children: [
        const SizedBox(height: 8.0),
        Center(
          child: Container(
            height: 4.0,
            width: 32.0,
            decoration: BoxDecoration(
              color: Colors.grey.shade800.withOpacity(0.8),
              borderRadius: const BorderRadius.all(
                Radius.circular(12.0),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20.0),
        const Center(
          child: Text(
            'Criar Tarefa',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 28.0),
        SimpleDialogFormWidget(
          formKey: _formKey,
          titleFieldController: _titleFieldController,
          descriptionFieldController: _descriptionFieldController,
        ),
        const SizedBox(height: 28.0),
        Row(
          children: [
            SimpleDialogActionWidget(
              action: () {
                final thereIsData = hasFormData();

                if (thereIsData) {
                } else {
                  Navigator.pop(widget.alertDialogContext);
                }
              },
              title: 'Fechar',
              color: Colors.blueGrey.shade800.withOpacity(0.6),
            ),
            const SizedBox(width: 8.0),
            SimpleDialogActionWidget(
              action: () {
                if (_formKey.currentState!.validate()) {
                  final data = getData();

                  Navigator.pop(widget.alertDialogContext);
                }
              },
              title: 'Adicionar',
              color: Colors.blue.shade700,
            ),
          ],
        ),
        const SizedBox(height: 32.0),
        Center(
          child: Container(
            height: 3.0,
            width: 120.0,
            margin: const EdgeInsets.only(
              bottom: 12.0,
            ),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: const BorderRadius.all(
                Radius.circular(12.0),
              ),
            ),
          ),
        )
      ],
    );
  }
}
