import 'package:flutter/material.dart';

import 'package:todo/src/screens/home_screen/components/simple_dialog_widget/simple_dialog_widget.dart';

class FloatingActionButtonWidget extends StatelessWidget {
  const FloatingActionButtonWidget({super.key});

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (alertDialogContext) {
        return SimpleDialogWidget(
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
