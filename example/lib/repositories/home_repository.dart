import 'dart:math';
import 'package:dependency_injection/annotations/reflection.dart';

abstract class HomeRepository {
  Future<int> getRandom();
}

@Reflection()
class HomeRepositoryImpl extends HomeRepository {
  @override
  Future<int> getRandom() async {
    return Random().nextInt(1000000);
  }
}