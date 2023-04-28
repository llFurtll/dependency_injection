import 'package:dependency_injection/annotations/inject.dart';
import 'package:dependency_injection/annotations/reflection.dart';
import 'package:dependency_injection/injection/auto_inject.dart';
import 'package:dependency_injection_example/pages/home/home_controller.dart';
import 'package:flutter/material.dart';

@Reflection()
class Home extends StatelessWidget with AutoInject {
  @Inject(nameSetter: "setController")
  late final HomeController controller;

  Home({super.key}) {
    super.inject();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(controller.nome),
      ),
    );
  }

  set setController(HomeController controller) {
    this.controller = controller;
  }
}