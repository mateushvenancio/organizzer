import 'package:organizzer/entities/categoria_entity.dart';

class CreateCompraDto {
  final String nome;
  final double preco;
  final int quantidade;
  final CategoriaEntity categoria;

  CreateCompraDto({
    required this.nome,
    required this.preco,
    required this.quantidade,
    required this.categoria,
  });
}
