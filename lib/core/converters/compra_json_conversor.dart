import 'package:organizzer/core/converters/converter.dart';
import 'package:organizzer/entities/compra_entity.dart';

class CompraJsonConversor implements Conversor<Map<String, dynamic>, CompraEntity> {
  @override
  CompraEntity from(Map<String, dynamic> input) {
    return CompraEntity(
      id: input['id'],
      nome: input['nome'],
      descricao: input['descricao'],
      created: DateTime.parse(input['createdAt']),
      done: input['done'],
    );
  }

  @override
  Map<String, dynamic> to(CompraEntity input) {
    return {
      'id': input.id,
      'nome': input.nome,
      'createdAt': input.createdAt.toString(),
      'descricao': input.descricao,
      'done': input.done,
    };
  }
}
