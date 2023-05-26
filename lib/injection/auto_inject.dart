import 'package:reflectable/reflectable.dart';

import '../annotations/inject.dart';
import '../global/instances.dart';

/// Mixin responsável por realizar as injeções de dependências em uma classe
/// onde extenda esse Mixin, no momento que o objeto for instanciado o método
/// inject será chamado e irá percorrer todos os atributos da classe e criando
/// as instâncias de cada um e injetando por meio de um método set.
/// 
/// O método [inject] deverá ser chamado no construtor da classe chamando ele
/// da seguinte forma: super.inject()
mixin AutoInject {
  static final Map<Type, dynamic> _dependencies = {};
  
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
                  if (annotation.global) {
                    _dependencies[variable.reflectedType] = newInstance;
                  }
                } else {
                  final variableMirror = reflection.reflectType(variable.reflectedType) as ClassMirror;
                  final newInstance = variableMirror.newInstance("", []);
                  instanceMirror.invokeSetter(
                    annotation.nameSetter,
                    newInstance
                  );
                  if (annotation.global) {
                    _dependencies[variable.reflectedType] = newInstance;
                  }
                }
              }
            }
          }
        }
      }
    });
  }

  static void init(void Function() initializeReflectable) {
    initializeReflectable();
  }
}
