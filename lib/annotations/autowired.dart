import 'reflection.dart';

@Reflection()
class Autowired {
  final String nameSetter;
  @Reflection()
  final Type? type;

  const Autowired({
    required this.nameSetter,
    this.type
  });
}
