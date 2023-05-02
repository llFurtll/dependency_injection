import 'package:dependency_injection/annotations/inject.dart';
import 'package:dependency_injection/injection/auto_inject.dart';
import 'package:dependency_injection/global/instances.dart';

import '../repositories/home_repository.dart';

@reflection
class HomeService with AutoInject {
  @Inject(nameSetter: "setRepository", type: HomeRepositoryImpl)
  late final HomeRepository repository;

  HomeService() {
    super.inject();
  }

  Future<int> getRandom() async {
    await Future.delayed(const Duration(seconds: 1));
    return repository.getRandom();
  }

  set setRepository(HomeRepository repository) {
    this.repository = repository;
  }
}