/// Converte um conteúdo para
/// um Entity, e vice versa.
/// R -> Raw
/// E -> Entity
abstract class Conversor<R, E> {
  R to(E input);
  E from(R input);
}
