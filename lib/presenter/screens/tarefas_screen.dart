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
      appBar: MainAppBar(
        title: 'Tarefas',
        menuItems: [
          MainAppBarItem(
            icon: Icons.delete_outline,
            onTap: () {
              showDialog(
                context: context,
                builder: (_) {
                  return YesNoDialog(
                    title: 'Deletar itens concluídos?',
                    onYes: () {
                      context.read<TarefasController>().deleteTarefasConcluidas();
                    },
                  );
                },
              );
            },
          ),
          Consumer<TarefasController>(
            builder: (context, controller, child) {
              return MainAppBarItem(
                icon: controller.showDone ? Icons.check_circle_outline : Icons.check_circle,
                onTap: () {
                  controller.toggleShowArchived();
                },
              );
            },
          ),
        ],
      ),
      body: Consumer<TarefasController>(
        builder: (context, controller, child) {
          return RefreshIndicator(
            onRefresh: () async {
              await controller.atualizarHomeWidget();
            },
            child: ListView(
              children: controller.tarefas.map((e) {
                return TarefaTile(
                  tarefa: e,
                  onTap: controller.editTarefa,
                  onDelete: (value) {
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
            ),
          );
        },
      ),
    );
  }
}
