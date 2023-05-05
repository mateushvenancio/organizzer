import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:organizzer/core/dto/edit_compra_dto.dart';
import 'package:organizzer/presenter/components/compra_tile.dart';
import 'package:organizzer/presenter/components/main_card_component.dart';
import 'package:organizzer/presenter/components/tarefa_tile.dart';
import 'package:organizzer/presenter/controllers/compra_controller.dart';
import 'package:organizzer/presenter/controllers/home_controller.dart';
import 'package:organizzer/presenter/controllers/tarefas_controller.dart';
import 'package:organizzer/resources/colors.dart';
import 'package:organizzer/resources/constants.dart';
import 'package:organizzer/utils/insert_between_list.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<_AtalhoModel> get _atalhos {
    return [
      _AtalhoModel(
        icon: Icons.qr_code_2,
        onTap: () => context.push('/qr'),
      ),
      _AtalhoModel(
        icon: FontAwesomeIcons.whatsapp,
        onTap: () => context.push('/whatsapp'),
      ),
      _AtalhoModel(
        icon: Icons.calculate_outlined,
        onTap: () => context.push('/calculadora'),
      ),
      _AtalhoModel(
        icon: FontAwesomeIcons.noteSticky,
        onTap: () async {
          // try {
          //   final channel = MethodChannel('CANAL');
          //   final result = await channel.invokeMethod<String?>('InitialParam');
          //   print('Tomara que tenha dado certo: $result');
          // } catch (e) {
          //   print('Tomara que tenha dado certo ERRO: $e');
          // }
        },
      ),
    ];
  }

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
                      children: insertBetweenList<Widget>(
                        _atalhos.map((e) => Expanded(child: _Atalho(icon: e.icon, onTap: e.onTap))).toList(),
                        SizedBox(width: kMainPadding),
                      ),
                    ),
                    SizedBox(height: kMainPadding),
                    Consumer<TarefasController>(builder: (context, controller, child) {
                      return MainCardComponent(
                        title: 'Tarefas',
                        itens: controller.tarefas.map((e) {
                          return TarefaTile.collapse(
                            tarefa: e,
                            onTap: controller.editTarefa,
                          );
                        }).toList(),
                        verMais: () => context.read<HomeController>().setBottomBarIndex(2),
                      );
                    }),
                    SizedBox(height: kMainPadding),
                    Consumer<CompraController>(builder: (context, controller, child) {
                      return MainCardComponent(
                        title: 'Lista de compras',
                        itens: controller.topCompras.map((e) {
                          return CompraTile.collapsed(
                            compra: e,
                            onTap: (value) {
                              controller.editCompra(EditCompraDto(
                                id: value.id,
                                done: !value.done,
                              ));
                            },
                          );
                        }).toList(),
                        verMais: () => context.read<HomeController>().setBottomBarIndex(3),
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
  final IconData icon;
  final Function() onTap;

  const _Atalho({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Material(
        elevation: kMainElevation,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Icon(icon, size: 30),
        ),
      ),
    );
  }
}

class _AtalhoModel {
  final IconData icon;
  final Function() onTap;

  const _AtalhoModel({
    required this.icon,
    required this.onTap,
  });
}
