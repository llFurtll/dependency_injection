import 'package:dependency_injection/annotations/autowired.dart';
import 'package:dependency_injection/annotations/reflection.dart';
import 'package:dependency_injection/injection/dependency_injection.dart';

abstract class IRepository {}

@Reflection()
class Teste extends AutoInject {
  @Autowired()
  late final IRepository repository;

  set teste(IRepository repository) {
    this.repository = repository;
  }

  set setRepository(IRepository repository) {
    this.repository = repository;
  }
}

class Repository extends IRepository {}

void main() {
  AutoInject.register<IRepository>(Repository());
  final teste = Teste();
  print(teste.repository);
}
