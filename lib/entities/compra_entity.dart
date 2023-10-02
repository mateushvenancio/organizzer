import 'package:organizzer/entities/categoria_entity.dart';

class CompraEntity {
  final String id;
  final String nome;
  final double preco;
  final int quantidade;
  final DateTime createdAt;
  final bool done;
  final CategoriaEntity categoria;

  CompraEntity({
    required this.id,
    required this.nome,
    required this.preco,
    required this.quantidade,
    required this.createdAt,
    required this.categoria,
    this.done = false,
  });

  CompraEntity copyWith({
    String? nome,
    double? preco,
    int? quantidade,
    bool? done,
    CategoriaEntity? categoria,
  }) {
    return CompraEntity(
      id: id,
      nome: nome ?? this.nome,
      preco: preco ?? this.preco,
      quantidade: quantidade ?? this.quantidade,
      createdAt: createdAt,
      done: done ?? this.done,
      categoria: categoria ?? this.categoria,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nome': nome,
      'preco': preco,
      'quantidade': quantidade,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'done': done,
      'categoria': categoria.toMap(),
    };
  }

  factory CompraEntity.fromMap(Map<String, dynamic> map) {
    return CompraEntity(
      id: map['id'] as String,
      nome: map['nome'] as String,
      preco: map['preco'] as double,
      quantidade: map['quantidade'] as int,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      done: map['done'] as bool,
      categoria: CategoriaEntity.fromMap(map['categoria'] as Map<String, dynamic>),
    );
  }
}
