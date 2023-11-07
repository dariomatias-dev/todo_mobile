import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:todo/src/core/result_types/either.dart';

import 'package:todo/src/screens/home_screen/components/simple_dialog_widget/simple_dialog_widget.dart';

void handleErrorUtil(
  BuildContext context,
  TapGestureRecognizer tapRecognizer,
  Failure failure, {
  String? content,
  String actionTitle1 = 'Fechar',
  void Function(
    VoidCallback closeSimpleDialog,
  )? action1,
  String? actionTitle2,
  void Function(
    VoidCallback closeSimpleDialog,
  )? action2,
}) {
  bool showErrorHelp = true;
  RichText? errorHelpWidget;

  String title = 'Erro';

  void action1Default(VoidCallback closeSimpleDialog) {
    closeSimpleDialog();
  }

  if (content == null) {
    if (failure.type == FailureType.fileSystem) {
      content = 'Ocorreu um erro no sistema.';
    } else if (failure.type == FailureType.openFailed) {
      content = 'Não foi possível abrir o banco de dados.';
    } else if (failure.type == FailureType.databaseClosed) {
      content = 'O banco de dados fechou inesperadamente.';
    } else if (failure.type == FailureType.platform) {
      content = 'Algo deu errado ao se comunicar com o dispositivo.';
    } else if (failure.type == FailureType.unsupported) {
      content =
          'O seu dispositivo é incompatível com o sistema de armazenamento utilizado.';
      showErrorHelp = false;
    } else {
      content = 'Ocorreu um problema ao carregar os dados.';
    }
  }

  if (showErrorHelp) {
    errorHelpWidget = RichText(
      textAlign: TextAlign.justify,
      text: TextSpan(
        text:
            '$content\nPor favor, tente novamente ou volte mais tarde.\nCaso persista envie um ',
        style: TextStyle(
          color: Colors.blueGrey.shade200,
          fontSize: 15.5,
        ),
        children: <TextSpan>[
          TextSpan(
            text: 'feedback',
            style: const TextStyle(
              color: Colors.blue,
            ),
            recognizer: tapRecognizer,
          ),
          const TextSpan(
            text: '.',
          ),
        ],
      ),
    );
  }

  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.blue.withOpacity(0.2),
    builder: (simpleDialogContext) {
      return SimpleDialogWidget(
        simpleDialogContext: simpleDialogContext,
        title: title,
        content: !showErrorHelp ? content : null,
        body: showErrorHelp ? errorHelpWidget : null,
        actionTitle1: actionTitle1,
        actionTitle2: actionTitle2,
        action1: action1 ?? action1Default,
        action2: action2,
      );
    },
  );
}
