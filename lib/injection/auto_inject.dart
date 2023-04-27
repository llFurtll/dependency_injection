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
            InstanceMirror instanceMirror = reflection.reflect(this);
            if (annotation is Autowired) {
              if (annotation.type != null) {
                final typeMirror = reflection.reflectType(annotation.type!) as ClassMirror;
                instanceMirror.invokeSetter(
                  annotation.nameSetter,
                  typeMirror.newInstance("", [])
                );
              } else {
                final variableMirror = reflection.reflectType(variable.reflectedType) as ClassMirror;
                instanceMirror.invokeSetter(
                  annotation.nameSetter,
                  variableMirror.newInstance("", [])
                );
              }
            }
          }
        }
      }
    });
  }
}
