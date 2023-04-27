import 'package:dependency_injection/annotations/autowired.dart';
import 'package:dependency_injection/annotations/reflection.dart';
import 'package:dependency_injection/injection/dependency_injection.dart';

abstract class IRepository {}

@Reflection()
class Teste extends AutoInject {
  @Autowired(type: Repository)
  late final IRepository repository;
  
  set setRepository(IRepository repository) {
    this.repository = repository;
  }
}

@Reflection()
class Repository extends IRepository {}

void main() {
  final teste = Teste();
  print(teste.repository);
}
