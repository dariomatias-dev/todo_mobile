import 'package:flutter/material.dart';
import 'package:msh_checkbox/msh_checkbox.dart';

import 'package:todo/src/screens/home_screen/models/task_model.dart';

class TaskCardWidget extends StatefulWidget {
  const TaskCardWidget({
    super.key,
    required this.task,
  });

  final TaskModel task;

  @override
  State<TaskCardWidget> createState() => _TaskCardWidgetState();
}

class _TaskCardWidgetState extends State<TaskCardWidget> {
  late bool _checked;

  void _handleChange() {
    setState(() {
      _checked = !_checked;
    });
  }

  @override
  void initState() {
    _checked = widget.task.isDone;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final task = widget.task;

    return InkWell(
      onTap: _handleChange,
      child: Ink(
        padding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 12.0,
        ),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(_checked ? 0.9 : 0.92),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          children: [
            MSHCheckbox(
              value: _checked,
              style: MSHCheckboxStyle.stroke,
              size: 24.0,
              colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
                checkedColor: Colors.grey.shade600,
                uncheckedColor: Colors.white,
              ),
              onChanged: (_) {},
            ),
            const SizedBox(width: 16.0),
            Column(
              children: [
                Text(
                  task.title,
                  style: TextStyle(
                    color: _checked ? Colors.grey.shade600 : Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  task.description,
                  style: TextStyle(
                    color: _checked ? Colors.grey.shade600 : Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
