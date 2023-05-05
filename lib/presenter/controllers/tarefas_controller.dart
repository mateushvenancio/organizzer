import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:organizzer/core/dto/create_tarefa_dto.dart';
import 'package:organizzer/core/dto/edit_tarefa_dto.dart';
import 'package:organizzer/entities/tarefa_entity.dart';
import 'package:organizzer/repositories/i_tarefas_repository.dart';

class TarefasController extends ChangeNotifier {
  final ITarefasRepository tarefasRepository;
  TarefasController(this.tarefasRepository);

  List<TarefaEntity> _tarefas = [];
  bool showDone = false;

  List<TarefaEntity> get tarefas {
    if (!showDone) {
      return _tarefas.where((e) => !e.done).toList();
    }
    return _tarefas;
  }

  init() async {
    _tarefas = await tarefasRepository.getTarefas();
    notifyListeners();
    atualizarHomeWidget();
  }

  addTarefa(CreateTarefaDto dto) async {
    final result = await tarefasRepository.createTarefa(dto);
    _tarefas.add(result);
    notifyListeners();
    atualizarHomeWidget();
  }

  editTarefa(TarefaEntity value) async {
    final index = _tarefas.indexWhere((e) => e.id == value.id);
    _tarefas[index] = await tarefasRepository.editTarefa(
      EditTarefaDto(id: value.id, done: !value.done),
    );
    notifyListeners();
    atualizarHomeWidget();
  }

  deleteTarefa(TarefaEntity value) async {
    final index = _tarefas.indexWhere((e) => e.id == value.id);
    await tarefasRepository.deleteTarefa(value.id);
    _tarefas.removeAt(index);
    notifyListeners();
    atualizarHomeWidget();
  }

  deleteTarefasConcluidas() async {
    final deletar = _tarefas.where((e) => e.done).toList();
    for (final item in deletar) {
      await deleteTarefa(item);
    }
    notifyListeners();
    atualizarHomeWidget();
  }

  toggleShowArchived() {
    showDone = !showDone;
    notifyListeners();
  }

  atualizarHomeWidget() async {
    final channel = MethodChannel('CANAL');
    await channel.invokeMethod('UpdateTarefasWidget');
  }
}
