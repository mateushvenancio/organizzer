class TarefaEntity {
  final String nome;
  final bool done;
  final DateTime createdAt;

  TarefaEntity({
    required this.nome,
    this.done = false,
    required this.createdAt,
  });
}
