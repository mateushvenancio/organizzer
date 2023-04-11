import 'package:organizzer/core/dto/create_tarefa_dto.dart';
import 'package:organizzer/core/dto/edit_tarefa_dto.dart';
import 'package:organizzer/entities/tarefa_entity.dart';

abstract class ITarefasRepository {
  Future<List<TarefaEntity>> getTarefas();
  Future<TarefaEntity> createTarefa(CreateTarefaDto dto);
  Future<TarefaEntity> editTarefa(EditTarefaDto dto);
  Future<void> deleteTarefa(String id);
}
