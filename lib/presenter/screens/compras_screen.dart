import 'package:flutter/material.dart';
import 'package:organizzer/core/dto/edit_compra_dto.dart';
import 'package:organizzer/core/extensions/num_extension.dart';
import 'package:organizzer/presenter/components/add_compra_dialog.dart';
import 'package:organizzer/presenter/components/compra_tile.dart';
import 'package:organizzer/presenter/components/main_app_bar.dart';
import 'package:organizzer/presenter/components/yes_no_dialog.dart';
import 'package:organizzer/presenter/controllers/compra_controller.dart';
import 'package:organizzer/resources/colors.dart';
import 'package:provider/provider.dart';

class ComprasScreen extends StatelessWidget {
  const ComprasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: 'Compras',
        menuItems: [
          MainAppBarItem(
            icon: Icons.delete_forever_outlined,
            iconColor: AppColors.primaryVariant,
            onTap: () {
              showDialog(
                context: context,
                builder: (_) {
                  return YesNoDialog(
                    title: 'Limpar a lista?',
                    onYes: () {
                      context.read<CompraController>().deleteTodos();
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Consumer<CompraController>(
        builder: (context, controller, child) {
          return ListView(
            children: [
              ...controller.groupByCategorias.entries.map((item) {
                return ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    Container(
                      color: Color(item.key.cor),
                      padding: const EdgeInsets.symmetric(vertical: 8).copyWith(
                        left: 16,
                      ),
                      child: Text(
                        item.key.nome,
                        style: TextStyle(
                          color: Color(item.key.cor).computeLuminance() > 0.5 ? Colors.black : Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    ...item.value.map((e) {
                      return CompraTile(
                        compra: e,
                        onTap: (value) {
                          controller.editCompra(EditCompraDto(
                            id: value.id,
                            done: !value.done,
                          ));
                        },
                        onEdit: (value) {
                          showDialog(
                            context: context,
                            builder: (_) => AddCompraDialog(
                              onCreate: context.read<CompraController>().addCompra,
                              onEdit: context.read<CompraController>().editCompra,
                              compra: value,
                            ),
                          );
                        },
                        onDelete: (value) async {
                          bool retorna = false;
                          await showDialog(
                            context: context,
                            builder: (_) {
                              return YesNoDialog(
                                title: 'Deletar este item?',
                                onYes: () {
                                  controller.deleteCompra(value);
                                  retorna = true;
                                },
                              );
                            },
                          );
                          return retorna;
                        },
                      );
                    }),
                  ],
                );
              }).toList(),
              // ...controller.compras.map((e) {
              //   return CompraTile(
              //     compra: e,
              //     onTap: (value) {
              //       controller.editCompra(EditCompraDto(
              //         id: value.id,
              //         done: !value.done,
              //       ));
              //     },
              //     onEdit: (value) {
              //       showDialog(
              //         context: context,
              //         builder: (_) => AddCompraDialog(
              //           onCreate: context.read<CompraController>().addCompra,
              //           onEdit: context.read<CompraController>().editCompra,
              //           compra: value,
              //         ),
              //       );
              //     },
              //     onDelete: (value) {
              //       showDialog(
              //         context: context,
              //         builder: (_) {
              //           return YesNoDialog(
              //             title: 'Deletar este item?',
              //             onYes: () {
              //               controller.deleteCompra(value);
              //             },
              //           );
              //         },
              //       );
              //     },
              //   );
              // }).toList(),
              ListTile(
                title: Text('Total'),
                trailing: Text('R\$ ${controller.total.toPrice()}'),
              ),
            ],
          );
        },
      ),
    );
  }
}
