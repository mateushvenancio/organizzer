import 'package:flutter/material.dart';
import 'package:organizzer/presenter/components/compra_tile.dart';
import 'package:organizzer/presenter/components/main_app_bar.dart';
import 'package:organizzer/presenter/controllers/compra_controller.dart';
import 'package:provider/provider.dart';

class ComprasScreen extends StatelessWidget {
  const ComprasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(title: 'Compras'),
      body: Consumer<CompraController>(
        builder: (context, controller, child) {
          return ListView(
            children: controller.compras.map((e) {
              return CompraTile(
                compra: e,
                onTap: controller.editCompra,
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
