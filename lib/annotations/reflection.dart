import 'package:reflectable/reflectable.dart';

class Reflection extends Reflectable {
  const Reflection() : super(
    invokingCapability,
    typingCapability,
    metadataCapability,
    reflectedTypeCapability,
  );
}