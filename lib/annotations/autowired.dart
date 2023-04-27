import 'reflection.dart';

@Reflection()
class Autowired {
  @Reflection()
  final Type type;

  const Autowired({
    required this.type
  });
}
