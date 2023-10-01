import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:organizzer/presenter/controllers/home_controller.dart';
import 'package:organizzer/presenter/screens/categorias_screen.dart';
import 'package:organizzer/presenter/screens/compras_screen.dart';
import 'package:organizzer/presenter/screens/config_screen.dart';
import 'package:organizzer/presenter/screens/home_screen.dart';
import 'package:organizzer/resources/colors.dart';
import 'package:provider/provider.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: context.read<HomeController>().pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          HomeScreen(),
          ConfigScreen(),
          CategoriasScreen(),
          ComprasScreen(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        child: Icon(Icons.add),
        onPressed: () {
          context.read<HomeController>().setBottomBarIndex(3);
          context.push('/compra_form');
          // showDialog(
          //   context: context,
          //   builder: (_) => AddCompraDialog(
          //     onCreate: context.read<CompraController>().addCompra,
          //   ),
          // );
        },
      ),
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
                icon: Icon(Icons.sell_outlined),
                title: Text('Categorias'),
                selectedColor: AppColors.primaryColor,
                unSelectedColor: AppColors.greySecondary,
              ),
              // BottomBarItem(
              //   icon: Icon(Icons.task_alt),
              //   title: Text('Tarefas'),
              //   selectedColor: AppColors.primaryColor,
              //   unSelectedColor: AppColors.greySecondary,
              // ),
              BottomBarItem(
                icon: Icon(Icons.shopping_cart_outlined),
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
