import 'package:reflectable/reflectable.dart';

/// Annotation responsável por identificar se uma classe pode ser
/// utilizada as operações de reflexões.
class Reflection extends Reflectable {
  const Reflection() : super(
    invokingCapability,
    typingCapability,
    metadataCapability,
    reflectedTypeCapability,
  );
}