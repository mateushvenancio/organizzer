abstract class IConfigRepository {
  Future<String?> getNome();
  Future<void> setNome(String nome);
}
