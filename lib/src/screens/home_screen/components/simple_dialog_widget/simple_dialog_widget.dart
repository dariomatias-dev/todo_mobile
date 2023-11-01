import 'package:flutter/material.dart';

import 'package:todo/src/screens/home_screen/components/simple_dialog_widget/simple_dialog_action_widget.dart';

class SimpleDialogWidget extends StatelessWidget {
  const SimpleDialogWidget({
    super.key,
    required this.simpleDialogContext,
    required this.title,
    this.content,
    this.body,
    required this.actionTitle1,
    required this.actionTitle2,
    required this.action1,
    required this.action2,
  })  : assert(
          (content == null && body == null) == false,
          'The "content" or "body" must be filled in.',
        ),
        assert(
          (content != null && body != null) == false,
          'Fill in only the "content" or "body".',
        );

  final BuildContext simpleDialogContext;
  final String title;
  final String? content;
  final Widget? body;
  final String actionTitle1;
  final String actionTitle2;
  final void Function()? action1;
  final void Function()? action2;

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
        const Center(
          child: SizedBox(height: 8.0),
        ),
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
        Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 28.0),
        if (content != null)
          Text(
            content!,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.blueGrey.shade200,
              fontSize: 14.0,
            ),
          ),
        if (body != null) body!,
        const SizedBox(height: 28.0),
        Row(
          children: [
            SimpleDialogActionWidget(
              action: () {
                Navigator.pop(simpleDialogContext);

                if (action1 != null) action1!();
              },
              title: actionTitle1,
              color: Colors.blueGrey.shade800.withOpacity(0.6),
            ),
            const SizedBox(width: 8.0),
            SimpleDialogActionWidget(
              action: () {
                Navigator.pop(simpleDialogContext);

                if (action2 != null) action2!();
              },
              title: actionTitle2,
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
        ),
      ],
    );
  }
}
