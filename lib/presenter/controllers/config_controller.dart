import 'package:flutter/material.dart';
import 'package:organizzer/repositories/i_config_repository.dart';

class ConfigController extends ChangeNotifier {
  final IConfigRepository configRepository;
  ConfigController(this.configRepository);

  init() async {
    nome = await configRepository.getNome() ?? 'Usuário';
  }

  String nome = 'Usuário';

  setNome(String value) {
    configRepository.setNome(value);
    nome = value;
    notifyListeners();
  }
}
