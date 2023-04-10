import 'package:flutter/material.dart';
import 'package:organizzer/presenter/components/main_app_bar.dart';
import 'package:organizzer/presenter/components/main_text_field.dart';
import 'package:organizzer/presenter/components/primary_button.dart';
import 'package:organizzer/resources/constants.dart';

class CalculadoraScreen extends StatefulWidget {
  const CalculadoraScreen({super.key});
  @override
  State<CalculadoraScreen> createState() => _CalculadoraScreenState();
}

class _CalculadoraScreenState extends State<CalculadoraScreen> {
  final primeiroNumero = TextEditingController();
  final segundoNumero = TextEditingController();
  final terceiroNumero = TextEditingController();
  final quartoNumero = TextEditingController();

  final primeiroFocusNode = FocusNode();
  final segundoFocusNode = FocusNode();
  final terceiroFocusNode = FocusNode();

  String? primeiroErro;
  String? segundoErro;
  String? terceiroErro;

  _calcular() {
    final numPrimeiro = num.tryParse(primeiroNumero.text);
    final numSegundo = num.tryParse(segundoNumero.text);
    final numTerceiro = num.tryParse(terceiroNumero.text);

    setState(() {
      primeiroErro = numPrimeiro == null ? 'Digite um número válido' : null;
      segundoErro = numSegundo == null ? 'Digite um número válido' : null;
      terceiroErro = numTerceiro == null ? 'Digite um número válido' : null;
    });

    if (numPrimeiro == null || numSegundo == null || numTerceiro == null) {
      quartoNumero.text = '';
      return;
    }

    quartoNumero.text = ((numTerceiro * numSegundo) / numPrimeiro).toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(title: 'Calculadora'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(kMainPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Titulo('Regra de 3'),
              Row(
                children: [
                  Expanded(
                    child: MainTextField(
                      hint: 'Primeiro Nº',
                      inputType: TextInputType.number,
                      controller: primeiroNumero,
                      errorText: primeiroErro,
                      focusNode: primeiroFocusNode,
                      onEnter: () => segundoFocusNode.requestFocus(),
                    ),
                  ),
                  SizedBox(width: kMainPadding),
                  Icon(Icons.arrow_forward),
                  SizedBox(width: kMainPadding),
                  Expanded(
                    child: MainTextField(
                      hint: 'Segundo Nº',
                      inputType: TextInputType.number,
                      controller: segundoNumero,
                      errorText: segundoErro,
                      focusNode: segundoFocusNode,
                      onEnter: () => terceiroFocusNode.requestFocus(),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: MainTextField(
                      hint: 'Terceiro Nº',
                      inputType: TextInputType.number,
                      controller: terceiroNumero,
                      errorText: terceiroErro,
                      focusNode: terceiroFocusNode,
                      onEnter: () => _calcular(),
                    ),
                  ),
                  SizedBox(width: kMainPadding),
                  Icon(Icons.arrow_forward),
                  SizedBox(width: kMainPadding),
                  Expanded(
                    child: MainTextField(
                      hint: '',
                      inputType: TextInputType.number,
                      controller: quartoNumero,
                      enabled: false,
                    ),
                  ),
                ],
              ),
              SizedBox(height: kMainPadding),
              Row(
                children: [
                  Expanded(
                    child: PrimaryButton(
                      text: 'Limpar',
                      onTap: () {
                        primeiroNumero.clear();
                        segundoNumero.clear();
                        terceiroNumero.clear();
                        quartoNumero.clear();

                        primeiroFocusNode.requestFocus();

                        setState(() {
                          primeiroErro = null;
                          segundoErro = null;
                          terceiroErro = null;
                        });
                      },
                    ),
                  ),
                  SizedBox(width: kMainPadding),
                  Expanded(
                    child: PrimaryButton(
                      text: 'Calcular',
                      onTap: () => _calcular(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Titulo extends StatelessWidget {
  final String text;
  const _Titulo(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 24,
        decoration: TextDecoration.underline,
      ),
    );
  }
}
