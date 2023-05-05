class CompraEntity {
  final String id;
  final String nome;
  final double preco;
  final int quantidade;
  final DateTime createdAt;
  final bool done;

  CompraEntity({
    required this.id,
    required this.nome,
    required this.preco,
    required this.quantidade,
    required this.createdAt,
    this.done = false,
  });

  CompraEntity copyWith({
    String? nome,
    double? preco,
    int? quantidade,
    bool? done,
  }) {
    return CompraEntity(
      id: id,
      nome: nome ?? this.nome,
      preco: preco ?? this.preco,
      quantidade: quantidade ?? this.quantidade,
      createdAt: createdAt,
      done: done ?? this.done,
    );
  }
}
