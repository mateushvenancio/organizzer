import 'package:flutter/material.dart';
import 'package:organizzer/presenter/components/main_app_bar.dart';
import 'package:organizzer/presenter/components/main_text_field.dart';
import 'package:organizzer/presenter/components/primary_button.dart';
import 'package:organizzer/presenter/controllers/config_controller.dart';
import 'package:provider/provider.dart';

class ConfigScreen extends StatefulWidget {
  const ConfigScreen({super.key});

  @override
  State<ConfigScreen> createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {
  final nomeTextController = TextEditingController();

  String? errorNome;

  bool _validate() {
    if (nomeTextController.text.isEmpty) {
      setState(() {
        errorNome = 'Digite um nome válido';
      });
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(title: 'Configurações'),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Troque o nome, para aparecer na tela inicial:'),
            MainTextField(
              hint: 'Nome',
              errorText: errorNome,
              controller: nomeTextController,
            ),
            PrimaryButton(
              text: 'Salvar Nome',
              onTap: () {
                if (_validate()) {
                  context.read<ConfigController>().setNome(nomeTextController.text);
                  FocusScope.of(context).requestFocus(FocusNode());
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Nome alterado com sucesso!')),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
