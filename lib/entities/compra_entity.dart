class CompraEntity {
  final String nome;
  final String? descricao;
  final DateTime createdAt;
  final bool done;

  CompraEntity({
    required this.nome,
    this.descricao,
    required this.createdAt,
    this.done = false,
  });
}
