//import 'package:intl/intl.dart';

class Historico {
  int _id = -1;
  String _resultadoImc = "";
  String _estadoImc = "";
  String _nome = "";
  String _altura = "";
  String _peso = "";
  //String _data = DateFormat('dd/MM/yyyy').format(DateTime.now());
  String _data = "";

  // ignore: unnecessary_getters_setters
  int get id => _id;
  set id(int id) => _id = id;

  // ignore: unnecessary_getters_setters
  String get resultadoImc => _resultadoImc;
  set resultadoImc(String resultadoImc) => _resultadoImc = resultadoImc;

  // ignore: unnecessary_getters_setters
  String get estadoImc => _estadoImc;
  set estadoImc(String estadoImc) => _estadoImc = estadoImc;

  // ignore: unnecessary_getters_setters
  String get nome => _nome;
  set nome(String nome) => _nome = nome;

  // ignore: unnecessary_getters_setters
  String get peso => _peso;
  set peso(String peso) => _peso = peso;

  // ignore: unnecessary_getters_setters
  String get altura => _altura;
  set altura(String altura) => _altura = altura;

  // ignore: unnecessary_getters_setters
  String get data => _data;
  set data(String data) => _data = data;

  Historico(this._nome, this._altura, this._peso, this._estadoImc,
      this._resultadoImc, this._data);

  Historico.empty();
}
