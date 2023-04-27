import 'package:reflectable/reflectable.dart';

import '../annotations/autowired.dart';
import '../annotations/reflection.dart';
import '../util/capitalize.dart';
import '../main.reflectable.dart';

class AutoInject {
  static final Map<Type, dynamic> _dependescies = {};
  static const reflection = Reflection();

  AutoInject() {
    initializeReflectable();
    inject();
  }

  static void register<T>(T instance) {
    _dependescies[T] = instance;
  }

  void inject() {
    final mirror = reflection.reflectType(runtimeType) as ClassMirror;

    mirror.declarations.forEach((key, variable) {
      if (variable is VariableMirror) {
        final annotations = variable.metadata;
        if (annotations.isNotEmpty) {
          for (dynamic annotation in annotations) {
            if (annotation is Autowired) {
              final property = variable.reflectedType;
              final dependency = _dependescies[property];

              if (dependency != null) {
                InstanceMirror instanceMirror = reflection.reflect(this);
                final nameMethod = "set${capitalize(variable.simpleName)}";
                instanceMirror.invokeSetter(nameMethod, dependency);
              }
            }
          }
        }
      }
    });
  }
}
