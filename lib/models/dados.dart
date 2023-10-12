class Dados {
  final String _peso;
  final String _altura;

  const Dados(this._peso, this._altura);

  String get peso => _peso.trim();

  String get altura => _altura.trim();
}
