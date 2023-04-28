import 'package:dependency_injection/injection/auto_inject.dart';
import 'package:dependency_injection_example/main.reflectable.dart';
import 'package:dependency_injection_example/pages/home/home.dart';
import 'package:flutter/material.dart';

void main() {
  AutoInject.init(initializeReflectable);
  runApp(MaterialApp(
    home: Home(),
  ));
}