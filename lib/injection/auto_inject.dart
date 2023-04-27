import 'package:reflectable/reflectable.dart';

import '../annotations/autowired.dart';
import '../annotations/reflection.dart';
import '../util/capitalize.dart';
import '../main.reflectable.dart';

class AutoInject {
  static const reflection = Reflection();

  AutoInject() {
    initializeReflectable();
    inject();
  }

  void inject() {
    final mirror = reflection.reflectType(runtimeType) as ClassMirror;

    mirror.declarations.forEach((key, variable) {
      if (variable is VariableMirror) {
        final annotations = variable.metadata;
        if (annotations.isNotEmpty) {
          for (dynamic annotation in annotations) {
            if (annotation is Autowired) {
              final typeMirror = reflection.reflectType(annotation.type) as ClassMirror;
              InstanceMirror instanceMirror = reflection.reflect(this);
              final nameMethod = "set${capitalize(variable.simpleName)}";
              instanceMirror.invokeSetter(
                nameMethod,
                typeMirror.newInstance("", [])
              );
            }
          }
        }
      }
    });
  }
}
