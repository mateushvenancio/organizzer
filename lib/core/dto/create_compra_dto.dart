class CreateCompraDto {
  final String nome;
  final double preco;
  final int quantidade;

  CreateCompraDto({
    required this.nome,
    required this.preco,
    required this.quantidade,
  });
}
