import 'package:reflect_inject/annotations/inject.dart';
import 'package:reflect_inject/global/instances.dart';
import 'package:reflect_inject/injection/auto_inject.dart';
import 'package:flutter_test/flutter_test.dart';

import 'auto_inject_test.reflectable.dart';

abstract class RepositoryTest {
  String hello();
}

@reflection
class RepositoryTestImpl extends RepositoryTest {
  @override
  String hello() {
    return "Hello";
  }
}

@reflection
class ServiceTest with AutoInject {
  @Inject(nameSetter: "setRepository", type: RepositoryTestImpl)
  late final RepositoryTest repository;

  ServiceTest() {
    super.inject();
  }

  String hello() {
    return repository.hello();
  }

  set setRepository(RepositoryTest repository) {
    this.repository = repository;
  }
}

@reflection
class ControllerTest with AutoInject {
  @Inject(nameSetter: "setService")
  late final ServiceTest service;

  ControllerTest() {
    super.inject();
  }

  String hello() {
    return service.hello();
  }

  set setService(ServiceTest service) {
    this.service = service;
  }
}

void main() {
  late final ControllerTest controller;

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    AutoInject.init(initializeReflectable);
    controller = ControllerTest();
  });

  group("Testando as injeções de dependências\n", () {
    test("Realizando a injeção em uma classe não abstrata", () {
      expect(controller.service, isNotNull);
      expect(controller.hello(), "Hello");
    });

    test("Realizando a injeção em uma classe abstrata", () {
      expect(controller.service.repository, isNotNull);
      expect(controller.service.hello(), "Hello");
    });
  });
}