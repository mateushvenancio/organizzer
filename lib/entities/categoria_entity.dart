class CategoriaEntity {
  final String id;
  final String nome;
  final int cor;
  final String icone;

  CategoriaEntity({
    required this.id,
    required this.nome,
    required this.cor,
    this.icone = '',
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nome': nome,
      'cor': cor,
      'icone': icone,
    };
  }

  factory CategoriaEntity.fromMap(Map<String, dynamic> map) {
    return CategoriaEntity(
      id: map['id'] as String,
      nome: map['nome'] as String,
      cor: map['cor'] as int,
      icone: map['icone'] as String,
    );
  }

  CategoriaEntity copyWith({
    String? nome,
    int? cor,
    String? icone,
  }) {
    return CategoriaEntity(
      id: id,
      nome: nome ?? this.nome,
      cor: cor ?? this.cor,
      icone: icone ?? this.icone,
    );
  }

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) => other is CategoriaEntity && other.id == id;
}
