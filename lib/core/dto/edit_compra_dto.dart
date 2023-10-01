import 'package:organizzer/entities/categoria_entity.dart';

class EditCompraDto {
  final String id;
  final bool done;
  final double? preco;
  final int? quantidade;
  final String? nome;
  final CategoriaEntity? categoria;

  EditCompraDto({
    required this.id,
    required this.done,
    this.preco,
    this.quantidade,
    this.nome,
    this.categoria,
  });
}
