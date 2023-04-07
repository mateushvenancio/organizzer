import 'package:flutter/material.dart';
import 'package:organizzer/presenter/components/main_app_bar.dart';
import 'package:organizzer/presenter/components/main_card_component.dart';

class OperacoesScreen extends StatelessWidget {
  const OperacoesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: 30,
        separatorBuilder: (_, __) => SizedBox(height: 8),
        itemBuilder: (context, index) => OperacaoTile(),
      ),
    );
  }
}
