import 'dart:math';
import 'package:dependency_injection/global/instances.dart';

abstract class HomeRepository {
  Future<int> getRandom();
}

@reflection
class HomeRepositoryImpl extends HomeRepository {
  @override
  Future<int> getRandom() async {
    return Random().nextInt(1000000);
  }
}