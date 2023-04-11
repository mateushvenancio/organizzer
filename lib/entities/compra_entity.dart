class CompraEntity {
  final String id;
  final String nome;
  final String? descricao;
  final DateTime createdAt;
  final bool done;

  CompraEntity({
    required this.id,
    required this.nome,
    this.descricao,
    required this.createdAt,
    this.done = false,
  });

  CompraEntity copyWith({
    String? nome,
    String? descricao,
    bool? done,
  }) {
    return CompraEntity(
      id: id,
      nome: nome ?? this.nome,
      descricao: descricao ?? this.descricao,
      createdAt: createdAt,
      done: done ?? this.done,
    );
  }
}
