import 'dart:convert';

import 'package:organizzer/core/converters/tarefas_json_conversor.dart';
import 'package:organizzer/entities/tarefa_entity.dart';
import 'package:organizzer/core/dto/edit_tarefa_dto.dart';
import 'package:organizzer/core/dto/create_tarefa_dto.dart';
import 'package:organizzer/repositories/i_tarefas_repository.dart';
import 'package:organizzer/utils/generate_uuid.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesTarefasRepository implements ITarefasRepository {
  final conversor = TarefasJsonConversor();
  final tarefasKey = 'TAREFAS_DB';

  _saveTarefas(List<TarefaEntity> tarefas) async {
    final prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> tarefasJson = tarefas.map((e) {
      return conversor.to(e);
    }).toList();
    await prefs.setString(tarefasKey, jsonEncode(tarefasJson));
  }

  @override
  Future<TarefaEntity> createTarefa(CreateTarefaDto dto) async {
    final novaTarefa = TarefaEntity(
      id: generateUuid(),
      nome: dto.nome,
      createdAt: DateTime.now(),
    );
    final atuais = await getTarefas();
    atuais.add(novaTarefa);
    await _saveTarefas(atuais);
    return novaTarefa;
  }

  @override
  Future<void> deleteTarefa(String id) async {
    final tarefas = await getTarefas();
    tarefas.removeWhere((e) => e.id == id);
    _saveTarefas(tarefas);
  }

  @override
  Future<TarefaEntity> editTarefa(EditTarefaDto dto) async {
    final tarefas = await getTarefas();
    final index = tarefas.indexWhere((e) => e.id == dto.id);
    tarefas[index] = tarefas[index].copyWith(done: dto.done);
    await _saveTarefas(tarefas);
    return tarefas[index];
  }

  @override
  Future<List<TarefaEntity>> getTarefas() async {
    final prefs = await SharedPreferences.getInstance();
    final tarefas = prefs.getString(tarefasKey) ?? '[]';
    final List<Map<String, dynamic>> result = [...jsonDecode(tarefas)];
    return result.map((e) {
      return conversor.from(e);
    }).toList();
  }
}
