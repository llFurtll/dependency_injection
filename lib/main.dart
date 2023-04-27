

import 'annotations/reflection.dart';
import 'annotations/inject.dart';
import 'injection/auto_inject.dart';

abstract class IRepository {}

@Reflection()
class Teste extends AutoInject {
  @Inject(nameSetter: "setRepository", type: Repository)
  late final IRepository repository;
  
  @Inject(nameSetter: "setOtherRepository")
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
  
}
