import 'package:flutter/material.dart';
import 'package:organizzer/core/dto/create_tarefa_dto.dart';
import 'package:organizzer/core/dto/edit_tarefa_dto.dart';
import 'package:organizzer/entities/tarefa_entity.dart';
import 'package:organizzer/repositories/i_tarefas_repository.dart';

class TarefasController extends ChangeNotifier {
  final ITarefasRepository tarefasRepository;
  TarefasController(this.tarefasRepository);

  List<TarefaEntity> tarefas = [];

  init() async {
    tarefas = await tarefasRepository.getTarefas();
    notifyListeners();
  }

  addTarefa(CreateTarefaDto dto) async {
    final result = await tarefasRepository.createTarefa(dto);
    tarefas.add(result);
    notifyListeners();
  }

  editTarefa(TarefaEntity value) async {
    final index = tarefas.indexWhere((e) => e.id == value.id);
    tarefas[index] = await tarefasRepository.editTarefa(
      EditTarefaDto(id: value.id, done: !value.done),
    );
    notifyListeners();
  }

  deleteTarefa(TarefaEntity value) async {
    final index = tarefas.indexWhere((e) => e.id == value.id);
    await tarefasRepository.deleteTarefa(value.id);
    tarefas.removeAt(index);
    notifyListeners();
  }
}
