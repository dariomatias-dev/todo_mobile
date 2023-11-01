import 'package:flutter/material.dart';

import 'package:todo/src/screens/home_screen/components/floating_action_button_widget.dart';

import 'package:todo/src/services/database_client_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final databaseService = DatabaseClientService();

  Future<void> initializeDatabase() async {
    await databaseService.init();
  }

  @override
  void initState() {
    initializeDatabase();

    super.initState();
  }

  @override
  void dispose() {
    databaseService.dispose();

    super.dispose();
  }

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
      floatingActionButton: FloatingActionButtonWidget(
        screenContext: context,
      ),
    );
  }
}
