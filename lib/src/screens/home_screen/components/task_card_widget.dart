import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import 'package:todo/src/core/enums/enums.dart';
import 'package:todo/src/screens/home_screen/bloc/tasks_bloc.dart';
import 'package:todo/src/screens/home_screen/components/simple_dialog_widget/simple_dialog_widget.dart';
import 'package:todo/src/screens/home_screen/components/task_form_dialog/task_form_dialog.dart';

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

  void _showConfirmTaskDeletion() {
    const title = 'Confirmar';
    const content =
        'Se excluir a tarefa não será possível recuperá-la.\nDeseja excluí-la mesmo assim?';
    const actionTitle1 = 'Não';
    const actionTitle2 = 'Sim';

    void action1(VoidCallback closeSimpleDialog) {
      closeSimpleDialog();
    }

    void action2(VoidCallback closeSimpleDialog) {
      closeSimpleDialog();

      context.read<TasksBloc>().add(
            TasksDeleteEvent(
              taskId: widget.task.id,
            ),
          );
    }

    showDialog(
      context: context,
      barrierColor: Colors.blue.withOpacity(0.2),
      builder: (simpleDialogContext) {
        return SimpleDialogWidget(
          simpleDialogContext: simpleDialogContext,
          title: title,
          content: content,
          actionTitle1: actionTitle1,
          actionTitle2: actionTitle2,
          action1: action1,
          action2: action2,
        );
      },
    );
  }

  void _showTaskFormDialog() {
    final tasksBloc = context.read<TasksBloc>();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (simpleDialogContext) {
        return TaskFormDialog(
          formType: TaskFormType.update,
          taskId: widget.task.id,
          tasksBloc: tasksBloc,
          simpleDialogContext: simpleDialogContext,
        );
      },
    );
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
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: PopupMenuButton(
                  color: Colors.black,
                  icon: const Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                  itemBuilder: (context) => <PopupMenuItem>[
                    PopupMenuItem(
                      onTap: _showTaskFormDialog,
                      child: const Text(
                        'Atualizar',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      onTap: _showConfirmTaskDeletion,
                      child: const Text(
                        'Excluir',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
