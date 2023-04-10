import 'dart:math';

class CompraEntity {
  final String id;
  final String nome;
  final String? descricao;
  final DateTime createdAt;
  final bool done;

  CompraEntity({
    String? id,
    required this.nome,
    this.descricao,
    DateTime? created,
    this.done = false,
  })  : id = id ?? Random().nextInt(9999).toString(),
        createdAt = created ?? DateTime.now();

  CompraEntity copyWith({
    String? nome,
    String? descricao,
    bool? done,
  }) {
    return CompraEntity(
      id: id,
      nome: nome ?? this.nome,
      descricao: descricao ?? this.descricao,
      created: createdAt,
      done: done ?? this.done,
    );
  }
}
