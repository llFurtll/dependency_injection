import 'package:dependency_injection/annotations/inject.dart';
import 'package:dependency_injection/global/instances.dart';
import 'package:dependency_injection/injection/auto_inject.dart';

import '../services/home_service.dart';

@reflection
class HomeController with AutoInject {
  @Inject(nameSetter: "setService")
  late final HomeService service;
  
  HomeController() {
    super.inject();
  }

  Future<int> getRandom() async {
    return service.getRandom();
  }

  set setService(HomeService service) {
    this.service = service;
  }
}