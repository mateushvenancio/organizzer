import 'package:flutter/material.dart';
import 'package:organizzer/core/extensions/date_time_extension.dart';
import 'package:organizzer/entities/recordacao_entity.dart';

class CalendarioController extends ChangeNotifier {
  DateTime diaSelecionado = DateTime.now();
  List<RecordacaoEntity> recordacoes = [
    RecordacaoEntity(dia: DateTime(2023, 04, 13), acontecimentos: ['Limpei a casa', 'Joguei o lixo fora', 'Lavei a louça', 'Fiz as compras da semana'], aprendiDeNovo: ['Aprendi sobre buracos negros', 'Aprendi sobre um animal novo']),
  ];

  setDiaSelecionado(DateTime selected, DateTime focused) {
    diaSelecionado = focused;
    notifyListeners();
  }

  RecordacaoEntity? getRecordacaoByDate() {
    final result = recordacoes.where((e) => e.dia.isAtTheSameDayAs(diaSelecionado));
    if (result.isNotEmpty) return result.first;
    return null;
  }
}
