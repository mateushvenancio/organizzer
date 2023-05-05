import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    atualizarHomeWidget();
  }

  addTarefa(CreateTarefaDto dto) async {
    final result = await tarefasRepository.createTarefa(dto);
    tarefas.add(result);
    notifyListeners();
    atualizarHomeWidget();
  }

  editTarefa(TarefaEntity value) async {
    final index = tarefas.indexWhere((e) => e.id == value.id);
    tarefas[index] = await tarefasRepository.editTarefa(
      EditTarefaDto(id: value.id, done: !value.done),
    );
    notifyListeners();
    atualizarHomeWidget();
  }

  deleteTarefa(TarefaEntity value) async {
    final index = tarefas.indexWhere((e) => e.id == value.id);
    await tarefasRepository.deleteTarefa(value.id);
    tarefas.removeAt(index);
    notifyListeners();
    atualizarHomeWidget();
  }

  atualizarHomeWidget() async {
    final channel = MethodChannel('CANAL');
    await channel.invokeMethod('UpdateTarefasWidget');
  }
}
