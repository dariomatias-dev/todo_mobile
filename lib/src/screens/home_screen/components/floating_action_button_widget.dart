import 'package:flutter/material.dart';

import 'package:todo/src/screens/home_screen/components/task_creation_dialog_widget/task_creation_dialog_widget.dart';

class FloatingActionButtonWidget extends StatelessWidget {
  const FloatingActionButtonWidget({super.key});

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (alertDialogContext) {
        return TaskCreationDialogWidget(
          alertDialogContext: alertDialogContext,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => _showAlertDialog(context),
      icon: const Icon(Icons.add),
      label: const Text('Adicionar'),
      backgroundColor: Colors.black,
    );
  }
}
