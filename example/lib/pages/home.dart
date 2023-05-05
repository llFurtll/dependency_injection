import 'package:reflect_inject/annotations/inject.dart';
import 'package:reflect_inject/global/instances.dart';
import 'package:reflect_inject/injection/auto_inject.dart';
import 'package:flutter/material.dart';

import '../controllers/home_controller.dart';

@reflection
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
        child: FutureBuilder(
          future: controller.getRandom(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
              case ConnectionState.active:
                return const CircularProgressIndicator();
              case ConnectionState.done:
                return Text("${snapshot.data}");
            }
          },
        ),
      ),
    );
  }

  set setController(HomeController controller) {
    this.controller = controller;
  }
}