import 'package:flutter/material.dart';

import 'package:todo/src/screens/home_screen/components/floating_action_button_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Lista de Tarefas'),
      ),
      body: const Center(
        child: Text('Development'),
      ),
      floatingActionButton: const FloatingActionButtonWidget(),
    );
  }
}
