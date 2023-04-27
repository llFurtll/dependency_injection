import 'annotations/autowired.dart';
import 'annotations/reflection.dart';
import 'injection/auto_inject.dart';

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
