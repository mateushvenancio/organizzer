import 'package:flutter/material.dart';
import 'package:organizzer/presenter/components/main_app_bar.dart';
import 'package:organizzer/presenter/components/tarefa_tile.dart';
import 'package:organizzer/presenter/components/yes_no_dialog.dart';
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
            children: controller.tarefas.map((e) {
              return TarefaTile(
                tarefa: e,
                onTap: controller.editTarefa,
                onLongTap: (value) {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return YesNoDialog(
                        title: 'Deletar este item?',
                        onYes: () => controller.deleteTarefa(value),
                      );
                    },
                  );
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
