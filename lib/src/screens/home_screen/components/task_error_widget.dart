import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:todo/src/core/result_types/either.dart';

import 'package:todo/src/utils/handle_error_util.dart';

class TaskErrorWidget extends StatefulWidget {
  const TaskErrorWidget({
    super.key,
    required this.failure,
  });

  final Failure failure;

  @override
  State<TaskErrorWidget> createState() => _TaskErrorWidgetState();
}

class _TaskErrorWidgetState extends State<TaskErrorWidget> {
  late TapGestureRecognizer _tapRecognizer;

  @override
  void initState() {
    _tapRecognizer = TapGestureRecognizer()..onTap = _handleTap;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      handleErrorUtil(
        context,
        _tapRecognizer,
        widget.failure,
      );
    });

    super.initState();
  }

  @override
  void dispose() {
    _tapRecognizer.dispose();

    super.dispose();
  }

  void _handleTap() {
    // Create a feature for sending user error feedback.
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Não foi possível carregar os dados',
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
