import 'package:flutter/material.dart';
import 'package:organizzer/entities/tarefa_entity.dart';

class TarefasController extends ChangeNotifier {
  List<TarefaEntity> tarefas = [
    TarefaEntity(nome: 'Tirar o lixo', done: true, createdAt: DateTime.now()),
    TarefaEntity(nome: 'Limpar casa', done: false, createdAt: DateTime.now()),
    TarefaEntity(nome: 'Programar', done: true, createdAt: DateTime.now()),
    TarefaEntity(nome: 'Jogar', done: false, createdAt: DateTime.now()),
    TarefaEntity(nome: 'Comer a fefe bem gostoso', done: true, createdAt: DateTime.now()),
  ];
}
