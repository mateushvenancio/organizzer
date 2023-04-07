import 'package:flutter/material.dart';
import 'package:organizzer/presenter/controllers/home_controller.dart';
import 'package:organizzer/presenter/screens/home_screen.dart';
import 'package:organizzer/presenter/screens/operacoes_screen.dart';
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
              OperacoesScreen(),
              Container(),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primaryColor,
        child: Icon(Icons.add),
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
                icon: Icon(Icons.pie_chart_outline),
                title: Text('Operações'),
                selectedColor: AppColors.primaryColor,
                unSelectedColor: AppColors.greySecondary,
              ),
              BottomBarItem(
                icon: Icon(Icons.format_list_bulleted_rounded),
                title: Text('Stats'),
                selectedColor: AppColors.primaryColor,
                unSelectedColor: AppColors.greySecondary,
              ),
              BottomBarItem(
                icon: Icon(Icons.settings_outlined),
                title: Text('Config'),
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
