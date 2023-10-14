import 'package:calculadora_imc_app/enums/boxes.dart';
import 'package:calculadora_imc_app/models/usuario.dart';
import 'package:hive/hive.dart';

class UsuarioRepository {
  final String _usuarioKey = "usuario";
  static late Box _box;

  UsuarioRepository.create();

  static Future<UsuarioRepository> load() async {
    if (Hive.isBoxOpen(Boxes.usuarioBox.toString())) {
      _box = Hive.box(Boxes.usuarioBox.toString());
    } else {
      _box = await Hive.openBox(Boxes.usuarioBox.toString());
    }

    return UsuarioRepository.create();
  }

  save(Usuario usuario) {
    _box.put(_usuarioKey, usuario);
  }

  Usuario getUsuario() {
    var usuario = _box.get(_usuarioKey);

    if (usuario == null) return Usuario();

    return usuario;
  }
}
