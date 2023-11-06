import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo/src/core/enums/enums.dart';

import 'package:todo/src/screens/home_screen/bloc/tasks_bloc.dart';

import 'package:todo/src/screens/home_screen/components/task_form_dialog/task_form_dialog.dart';

class FloatingActionButtonWidget extends StatelessWidget {
  const FloatingActionButtonWidget({super.key});

  void _showTaskCreationDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.blue.withOpacity(0.2),
      builder: (simpleDialogContext) {
        final tasksBloc = context.read<TasksBloc>();

        return TaskFormDialog(
          formType: TaskFormType.creation,
          tasksBloc: tasksBloc,
          simpleDialogContext: simpleDialogContext,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showTaskCreationDialog(context),
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40.0),
      ),
      child: Container(
        width: 164.0,
        padding: const EdgeInsets.symmetric(
          vertical: 14.0,
        ),
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(
            width: 1.0,
            color: Colors.blue.shade900,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(40.0),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add,
              color: Colors.white,
              size: 32.0,
            ),
            SizedBox(width: 8.0),
            Text(
              'Adicionar',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
