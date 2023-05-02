# DependencyInjection

<a href="https://www.buymeacoffee.com/danielmelonari" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/default-orange.png" alt="Buy Me A Coffee" height="41" width="174"></a>

## Por que?
Esse projeto teve como iniciativa novamente por meio de estudos, como atualmente utilizo Spring Boot no Java fiquei pensando como poderia funcionar as injeções de dependências dele. Ao conversar com um amigo, ele me explicou que isso poderia ser utilizando reflexões, nisso realizei uma busca em Dart para ver se o mesmo suporta, percebi que teve algumas mudanças nas reflexões em dart, porém mesmo assim resolvi tentar realizar algum plugin que pudesse ajudar a realizar as injeções com base no Spring Boot, e vou dizer que fiquei muito feliz com o resultado.

## Observações
Como dito anteriormente, o suporte de reflexões no Flutter é algo que não é completo, existe seus poréns nesse caso, mas ainda não fiz um teste em um aplicativo maior para ver se pode ter perda de desempenho por usar reflexões nas injeções de dependências. Acredito que essa ideia deverá ser amadurecida, mas até o momento, os testes realizados utilizando dessa forma foi bem sucedida.

## Vamos começar
Se você verificar, nesse projeto já existe um projeto de exemplo, mas irei como de costume documentar também as partes para ser possível entender como funciona todo o processo.
 
 ### 1 - Annotation `reflection`
A primeira parte é entendermos a Annotation `reflection`, essa Annotation indica que a classe que você deseja realizar injeções pode ser realizado operações de reflexões, um dos casos que é utilizada é percorrer suas declarações.<br>
Então nesse caso toda classe que conter essa Annotation será possível realizar operações de reflexão e injetar as dependências que você necessita.<br>
Exemplo de uso:
```dart
import import 'package:dependency_injection/global/instances.dart';

@reflection
class Example {}
```

### 2 - Mixin `AutoInject`
Além da Annotation de reflexão, toda classe que você deseja que realize as injeções de dependências deverá também extender o mixin `AutoInject`, isso é necessário pois esse mixin contém o método onde irá realizar a reflexão na classe que está herdando e percorrer todas as variáveis declaradas e validar quais deverão ser injetadas as dependências, um ponto importante que aqui também é salvo em uma variável estática as dependências, onde caso outra classe dependa de uma mesma dependência, seja possível reaproveitar a instância antiga já criada.<br>
Esse porjeto de injeção acontece apenas quando o objeto é instanciado, é assim que conseguimos realizar as operações.<br>
Exemplo de uso:
```dart
import 'package:dependency_injection/annotations/inject.dart';
import 'package:dependency_injection/injection/auto_inject.dart';
import 'package:dependency_injection/global/instances.dart';

@reflection
class Example with AutoInject {
  Example() {
    super.inject();
  }
}
```

*Observação:* Note que é precisso no construtor da classe chamar o método `super.inject()`, isso é necessário por ser um mixin, e no Dart não é possível obrigar o desenvolvedor a chamar uma operação no construtor utilizando esses mixins, então é sempre bom lembrar em chamar esse super caso você precise que algum atributo da sua classe seja realizado a injeção.

### 3 - Annotation `Inject`
