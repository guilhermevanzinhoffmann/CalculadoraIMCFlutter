import 'package:hive/hive.dart';
part 'usuario.g.dart';

@HiveType(typeId: 0)
class Usuario extends HiveObject {
  @HiveField(0)
  String nome = "";

  @HiveField(1)
  double altura = 0;

  Usuario();

  Usuario.create(this.nome, this.altura);
}
