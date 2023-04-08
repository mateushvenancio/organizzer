import 'package:flutter/material.dart';
import 'package:organizzer/presenter/components/compra_tile.dart';
import 'package:organizzer/presenter/components/main_card_component.dart';
import 'package:organizzer/presenter/components/tarefa_tile.dart';
import 'package:organizzer/presenter/controllers/compra_controller.dart';
import 'package:organizzer/presenter/controllers/tarefas_controller.dart';
import 'package:organizzer/resources/colors.dart';
import 'package:organizzer/resources/constants.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: kHomeHeaderSize,
                decoration: BoxDecoration(
                  color: AppColors.primaryVariant,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(32),
                    bottomRight: Radius.circular(32),
                  ),
                ),
                padding: const EdgeInsets.all(kMainPadding),
                child: Text(
                  'Olá, Mateus',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(kMainPadding),
                child: Column(
                  children: [
                    SizedBox(height: kHomeHeaderSize / 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(child: _Atalho()),
                        SizedBox(width: kMainPadding),
                        Expanded(child: _Atalho()),
                        SizedBox(width: kMainPadding),
                        Expanded(child: _Atalho()),
                        SizedBox(width: kMainPadding),
                        Expanded(child: _Atalho()),
                      ],
                    ),
                    SizedBox(height: kMainPadding),
                    Consumer<TarefasController>(builder: (context, controller, child) {
                      return MainCardComponent(
                        title: 'Tarefas',
                        itens: controller.tarefas.getRange(0, 3).map((e) {
                          return TarefaTile(tarefa: e);
                        }).toList(),
                      );
                    }),
                    SizedBox(height: kMainPadding),
                    Consumer<CompraController>(builder: (context, controller, child) {
                      return MainCardComponent(
                        title: 'Lista de compras',
                        itens: controller.compras.getRange(0, 3).map((e) {
                          return CompraTile(compra: e);
                        }).toList(),
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Atalho extends StatelessWidget {
  const _Atalho();

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Material(
        elevation: kMainElevation,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {},
          child: Icon(
            Icons.qr_code_2,
            size: 30,
          ),
        ),
      ),
    );
  }
}
