class ResultadoIMC {
  String _resultado = "";
  String _descricao = "";

  ResultadoIMC(this._resultado, this._descricao);

  // ignore: unnecessary_getters_setters
  String get resultado => _resultado;
  set resultado(String resultado) => _resultado = resultado;

  // ignore: unnecessary_getters_setters
  String get descricao => _descricao;
  set descricao(String descricao) => _descricao = descricao;

  ResultadoIMC.empty();
}
