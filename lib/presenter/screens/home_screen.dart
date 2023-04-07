import 'package:flutter/material.dart';
import 'package:organizzer/presenter/components/main_card_component.dart';
import 'package:organizzer/resources/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 175,
            decoration: BoxDecoration(
              color: AppColors.primaryVariant,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
          ),
          SafeArea(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    'Olá, Mateus!',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  MainCardComponent(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
