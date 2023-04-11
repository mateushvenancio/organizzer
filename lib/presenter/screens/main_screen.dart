import 'package:flutter/material.dart';
import 'package:organizzer/presenter/components/add_compra_dialog.dart';
import 'package:organizzer/presenter/components/expandable_fab.dart';
import 'package:organizzer/presenter/controllers/compra_controller.dart';
import 'package:organizzer/presenter/controllers/home_controller.dart';
import 'package:organizzer/presenter/screens/compras_screen.dart';
import 'package:organizzer/presenter/screens/home_screen.dart';
import 'package:organizzer/presenter/screens/tarefas_screen.dart';
import 'package:organizzer/resources/colors.dart';
import 'package:provider/provider.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<HomeController>(
        builder: (context, controller, child) {
          return PageView(
            controller: controller.pageController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              HomeScreen(),
              Container(),
              TarefasScreen(),
              ComprasScreen(),
            ],
          );
        },
      ),
      floatingActionButton: ExpandableFab(
        children: [
          ExpandableFabItem(
            icon: Icons.attach_money,
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => AddCompraDialog(
                  onSelect: (value) {
                    if (value != null) {
                      context.read<CompraController>().addCompra(value);
                    }
                  },
                ),
              );
            },
          ),
        ],
      ),
      // floatingActionButton: Consumer<CompraController>(
      //   builder: (context, controller, child) {
      //     return FloatingActionButton(
      //       onPressed: () {
      //         showDialog(
      //           context: context,
      //           builder: (_) => AddCompraDialog(
      //             onSelect: (value) {
      //               if (value != null) {
      //                 controller.addCompra(value);
      //               }
      //             },
      //           ),
      //         );
      //       },
      //       backgroundColor: AppColors.primaryColor,
      //       child: Icon(Icons.add),
      //     );
      //   },
      // ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      extendBody: true,
      bottomNavigationBar: Consumer<HomeController>(
        builder: (context, controller, child) {
          return StylishBottomBar(
            currentIndex: controller.bottomBarIndex,
            onTap: controller.setBottomBarIndex,
            fabLocation: StylishBarFabLocation.center,
            hasNotch: true,
            items: [
              BottomBarItem(
                icon: Icon(Icons.home_outlined),
                title: Text('Home'),
                selectedColor: AppColors.primaryColor,
                unSelectedColor: AppColors.greySecondary,
              ),
              BottomBarItem(
                icon: Icon(Icons.settings_outlined),
                title: Text('Config'),
                selectedColor: AppColors.primaryColor,
                unSelectedColor: AppColors.greySecondary,
              ),
              BottomBarItem(
                icon: Icon(Icons.pie_chart_outline),
                title: Text('Tarefas'),
                selectedColor: AppColors.primaryColor,
                unSelectedColor: AppColors.greySecondary,
              ),
              BottomBarItem(
                icon: Icon(Icons.attach_money),
                title: Text('Compras'),
                selectedColor: AppColors.primaryColor,
                unSelectedColor: AppColors.greySecondary,
              ),
            ],
            option: AnimatedBarOptions(
              backgroundColor: AppColors.primaryColor,
            ),
          );
        },
      ),
    );
  }
}
