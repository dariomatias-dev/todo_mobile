import 'package:flutter/material.dart';

class SimpleDialogWidget extends StatelessWidget {
  const SimpleDialogWidget({
    super.key,
    required this.alertDialogContext,
  });

  final BuildContext alertDialogContext;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          36.0,
        ),
      ),
      backgroundColor: Colors.black,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      children: [
        SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.8,
          child: IntrinsicHeight(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 8.0),
                Container(
                  height: 4.0,
                  width: 32.0,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade800.withOpacity(0.8),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Criar Tarefa',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 28.0),

                ///
                /// Form
                ///

                const SizedBox(height: 28.0),
                Row(
                  children: [
                    SimpleDialogAction(
                      action: () {
                        Navigator.pop(alertDialogContext);
                      },
                      title: 'Fechar',
                      color: Colors.blueGrey.shade800.withOpacity(0.6),
                    ),
                    const SizedBox(width: 8.0),
                    SimpleDialogAction(
                      action: () {
                        Navigator.pop(alertDialogContext);
                      },
                      title: 'Adicionar',
                      color: Colors.blue.shade700,
                    ),
                  ],
                ),
                const SizedBox(height: 32.0),
                Container(
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
              ],
            ),
          ),
        )
      ],
    );
  }
}

class SimpleDialogAction extends StatelessWidget {
  const SimpleDialogAction({
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
            vertical: 20.0,
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
