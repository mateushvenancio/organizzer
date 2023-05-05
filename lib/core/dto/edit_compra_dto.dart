class EditCompraDto {
  final String id;
  final bool done;
  final double? preco;
  final int? quantidade;
  final String? nome;

  EditCompraDto({
    required this.id,
    required this.done,
    this.preco,
    this.quantidade,
    this.nome,
  });
}
