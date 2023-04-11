class TarefaEntity {
  final String id;
  final String nome;
  final bool done;
  final DateTime createdAt;

  TarefaEntity({
    required this.id,
    required this.nome,
    this.done = false,
    required this.createdAt,
  });

  TarefaEntity copyWith({
    String? nome,
    bool? done,
  }) {
    return TarefaEntity(
      id: id,
      nome: nome ?? this.nome,
      done: done ?? this.done,
      createdAt: createdAt,
    );
  }
}
