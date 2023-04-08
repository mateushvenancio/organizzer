import 'package:flutter/material.dart';
import 'package:organizzer/presenter/components/main_app_bar.dart';
import 'package:organizzer/presenter/controllers/tarefas_controller.dart';
import 'package:provider/provider.dart';

class TarefasScreen extends StatelessWidget {
  const TarefasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(title: 'Tarefas'),
      body: Consumer<TarefasController>(
        builder: (context, controller, child) {
          return ListView(
            padding: const EdgeInsets.all(20),
            children: [],
          );
        },
      ),
    );
  }
}
