class CreateCompraDto {
  final String nome;
  final String? descricao;

  CreateCompraDto({
    required this.nome,
    this.descricao,
  });
}
