import 'package:organizzer/core/converters/converter.dart';
import 'package:organizzer/entities/tarefa_entity.dart';

class TarefasJsonConversor implements Conversor<Map<String, dynamic>, TarefaEntity> {
  @override
  TarefaEntity from(Map<String, dynamic> input) {
    return TarefaEntity(
      id: input['id'],
      nome: input['nome'],
      createdAt: DateTime.parse(input['createdAt']),
      done: input['done'],
    );
  }

  @override
  Map<String, dynamic> to(TarefaEntity input) {
    return {
      'id': input.id,
      'nome': input.nome,
      'createdAt': input.createdAt.toString(),
      'done': input.done,
    };
  }
}
