import '../global/instances.dart';

/// Responsável por indicar que determinado atributo da classe
/// deverá realizar a injeção de dependência.
/// 
/// [nameSetter] O nome do método setq ue o plugin precisará invocar
/// para realizar a injeção.
/// 
/// [type] Caso deseje utilizar o princípio da inversão de dependência, passe
/// o tipo da classe que você deseja que o plugin cria uma nova instância.
/// 
/// [global] Define se a dependência será guardada de forma global, onde
/// outros objetos poderá utilizar da mesma instância.
class Inject {
  final String nameSetter;
  @reflection
  final Type? type;
  final bool global;

  const Inject({
    required this.nameSetter,
    this.type,
    this.global = false
  });
}
