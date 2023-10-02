import 'package:flutter/material.dart';
import 'package:organizzer/presenter/components/add_categoria_dialog.dart';
import 'package:organizzer/presenter/components/main_app_bar.dart';
import 'package:organizzer/presenter/components/yes_no_dialog.dart';
import 'package:organizzer/presenter/controllers/categorias_controller.dart';
import 'package:provider/provider.dart';

class CategoriasScreen extends StatelessWidget {
  const CategoriasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: 'Categorias',
        menuItems: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AddCategoriaDialog(
                  onCreate: context.read<CategoriasController>().createCategoria,
                ),
              );
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Consumer<CategoriasController>(
        builder: (_, controller, __) {
          return ListView(
            children: controller.categorias.map((e) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Color(e.cor),
                  child: Text(
                    e.nome.substring(0, 1),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                title: Text(e.nome),
                // trailing: IconButton(
                //   onPressed: () {
                //     showDialog(
                //       context: context,
                //       builder: (_) {
                //         return YesNoDialog(
                //           title: 'Deseja excluir essa categoria?',
                //           onYes: () => controller.deleteCategoria(e.id),
                //         );
                //       },
                //     );
                //   },
                //   icon: Icon(Icons.delete),
                // ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => AddCategoriaDialog(
                            categoria: e,
                            onEdit: context.read<CategoriasController>().editCategoria,
                            onCreate: context.read<CategoriasController>().createCategoria,
                          ),
                        );
                      },
                      icon: Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) {
                            return YesNoDialog(
                              title: 'Deseja excluir essa categoria?',
                              onYes: () => controller.deleteCategoria(e.id),
                            );
                          },
                        );
                      },
                      icon: Icon(Icons.delete),
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
