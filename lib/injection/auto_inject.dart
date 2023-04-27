import 'package:reflectable/reflectable.dart';

import '../annotations/inject.dart';
import '../annotations/reflection.dart';
import '../main.reflectable.dart';

@Reflection()
class AutoInject {
  static final Map<Type, dynamic> _dependencies = {};
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
            if (annotation is Inject) {
              final dependencie = _dependencies[variable.reflectedType];
              if (dependencie != null) {
                instanceMirror.invokeSetter(
                  annotation.nameSetter,
                  dependencie
                );
              } else {
                if (annotation.type != null) {
                  final typeMirror = reflection.reflectType(annotation.type!) as ClassMirror;
                  final newInstance = typeMirror.newInstance("", []);
                  instanceMirror.invokeSetter(
                    annotation.nameSetter,
                    newInstance
                  );
                  _dependencies[variable.reflectedType] = newInstance;
                } else {
                  final variableMirror = reflection.reflectType(variable.reflectedType) as ClassMirror;
                  final newInstance = variableMirror.newInstance("", []);
                  instanceMirror.invokeSetter(
                    annotation.nameSetter,
                    newInstance
                  );
                  _dependencies[variable.reflectedType] = newInstance;
                }
              }
            }
          }
        }
      }
    });
  }
}
