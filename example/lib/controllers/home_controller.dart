import 'package:reflect_inject/annotations/inject.dart';
import 'package:reflect_inject/global/instances.dart';
import 'package:reflect_inject/injection/auto_inject.dart';

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