import 'annotations/autowired.dart';
import 'annotations/reflection.dart';
import 'injection/auto_inject.dart';

abstract class IRepository {}

@Reflection()
class Teste extends AutoInject {
  @Autowired(nameSetter: "setRepository", type: Repository)
  late final IRepository repository;
  
  @Autowired(nameSetter: "setOtherRepository")
  late final Repository otherRepository;
  
  set setRepository(IRepository repository) {
    this.repository = repository;
  }

  set setOtherRepository(Repository repository) {
    otherRepository = repository;
  }
}

@Reflection()
class Repository extends IRepository {}

void main() {
  final teste = Teste();
  print(teste.repository);
  print(teste.otherRepository);
}
