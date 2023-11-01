import 'package:flutter/material.dart';

class TaskCreationDialogActionWidget extends StatelessWidget {
  const TaskCreationDialogActionWidget({
    super.key,
    required this.action,
    required this.title,
    required this.color,
  });

  final void Function() action;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: action,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(
            vertical: 16.0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
        ),
        child: Text(title),
      ),
    );
  }
}
