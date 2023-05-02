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
Esse processo de injeção acontece apenas quando o objeto é instanciado, é assim que conseguimos realizar as operações.<br>
Exemplo de uso:
```dart
import 'package:dependency_injection/injection/auto_inject.dart';
import 'package:dependency_injection/global/instances.dart';

@reflection
class Example with AutoInject {
  Example() {
    super.inject();
  }
}
```

<b>Observação:</b> Note que é precisso no construtor da classe chamar o método `super.inject()`, isso é necessário por ser um mixin, e no Dart não é possível obrigar o desenvolvedor a chamar uma operação no construtor utilizando esses mixins, então é sempre bom lembrar em chamar esse super caso você precise que algum atributo da sua classe seja realizado a injeção.

### 3 - Annotation `Inject`
Essa annotation é a responsável por indicar que determinado atributo da classe deverá realizar a injeção de dependência, vamos entendê-la.
Ao utilizar essa annotation você irá se deparar com um argumento obrigatório e um não obrigatório.
* <b>nameSetter:</b> Aqui você irá colocar o nome do método set que o plugin precisará invocar para realizar a injeção, como hoje no Dart não é possível já instanciar a variável diretamente pela reflection, precisamos realizar essa operação por meio de um método set, então para cada atributo que você deseja injetar a dependência em uma classe, deverá criar um método set para ela e definir nesse parâmetro.
* <b>type:</b> Você só irá utilizar esse argumento caso você deseje utilizar o princípio da inversão de dependência, no caso quando você coloca em sua classe que ela depende de um atributo do tipo abstrato e na hora de injetar a dependência é preciso injetar um objeto que implemente/extenda essa classe abstrata, nisso você irá colocar o tipo dessa classe para ser possível criar uma nova instância da mesma depois.

Bom, para ficar mais fácil entender esse processo segue um exemplo utilizando as duas formas:
```dart
import 'package:dependency_injection/annotations/inject.dart';
import 'package:dependency_injection/injection/auto_inject.dart';
import 'package:dependency_injection/global/instances.dart';

class IService {
 void update();
}

@reflection
class Service extends IService {
 @override
 void update() {}
}

@reflection
class Example with AutoInject {
 @Inject(nameSetter: "setService", type: Service) // Na hora de injetar a dependência irá criar uma nova instância de Service
 late final IService service;
 
 @Inject(nameSetter: "setOtherService") // No caso não é uma classe abstrata
 late final Service otherService;

 Example() {
  super.inject();
 }
 
 set setService(IService service) {
  this.service = service;
 }
 
 set setOtherService(Service otherService) {
  this.otherService = otherService;
 }
}
```

Como você pode ver no exemplo, a minha classe Example, configurei dois atributos para injetar as dependências, lembrando que esse processo irá acontecer quando for realizado um Example(), nisso um deles eu passei o argumento type, pois no caso é uma classe abstrata, lembrando que se você passar uma classe abstrata e não defirnir o type, a injeção não irá ocorrer e irá estourar exceptions em seu projeto. Então quando o plugin identificar que o atributo é uma classe abstrata, nesse momento ele irá criar uma nova instância para esse atributo a partir do type que foi definido.

Um ponto importante é que para cada atributo precisa de um set e também lembrar que toda classe que for preciso realizar injeções de dependências ou toda classe que será utilizada para criar uma nova instância, necessita do `@reflection` para ser possível realizar essas operações.
