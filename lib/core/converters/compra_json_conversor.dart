import 'package:organizzer/core/converters/converter.dart';
import 'package:organizzer/entities/categoria_entity.dart';
import 'package:organizzer/entities/compra_entity.dart';

class CompraJsonConversor implements Conversor<Map<String, dynamic>, CompraEntity> {
  @override
  CompraEntity from(Map<String, dynamic> input) {
    return CompraEntity(
      id: input['id'],
      nome: input['nome'],
      preco: input['preco'],
      quantidade: input['quantidade'],
      createdAt: DateTime.parse(input['createdAt']),
      done: input['done'],
      categoria: CategoriaEntity.fromMap({}),
    );
  }

  @override
  Map<String, dynamic> to(CompraEntity input) {
    return {
      'id': input.id,
      'nome': input.nome,
      'createdAt': input.createdAt.toString(),
      'preco': input.preco,
      'quantidade': input.quantidade,
      'done': input.done,
    };
  }
}
