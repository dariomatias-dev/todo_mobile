import 'package:flutter/material.dart';

import 'package:todo/src/screens/home_screen/components/task_creation_dialog_widget/task_creation_dialog_widget.dart';

class FloatingActionButtonWidget extends StatelessWidget {
  const FloatingActionButtonWidget({
    super.key,
    required this.screenContext,
  });

  final BuildContext screenContext;

  void _showTaskCreationDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.blue.withOpacity(0.2),
      builder: (simpleDialogContext) {
        return TaskCreationDialogWidget(
          screenContext: screenContext,
          simpleDialogContext: simpleDialogContext,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => _showTaskCreationDialog(context),
      icon: const Icon(Icons.add),
      label: const Text('Adicionar'),
      backgroundColor: Colors.black,
    );
  }
}
