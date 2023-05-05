import 'package:reflect_inject/annotations/inject.dart';
import 'package:reflect_inject/injection/auto_inject.dart';
import 'package:reflect_inject/global/instances.dart';

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