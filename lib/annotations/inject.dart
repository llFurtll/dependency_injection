import 'reflection.dart';

class Inject {
  final String nameSetter;
  @Reflection()
  final Type? type;

  const Inject({
    required this.nameSetter,
    this.type
  });
}
