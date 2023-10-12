import 'package:calculadora_imc_app/models/dados.dart';

class CalculadoraService {
  Future<String> calcularIMCAsync(Dados dados) async {
    await Future.delayed(const Duration(seconds: 5));
    try {
      var peso = double.parse(dados.peso);
      var altura = double.parse(dados.altura);
      var resultado = peso / (altura * altura);
      if (resultado.isNaN || resultado.isInfinite) {
        throw Exception("Dados incorretos");
      }
      var retorno = "IMC: ${resultado.toStringAsFixed(2)}.";
      if (resultado < 16) {
        return "$retorno Magreza grave";
      } else if (resultado >= 16 && resultado < 17) {
        return "$retorno Magreza moderada";
      } else if (resultado >= 17 && resultado < 18.5) {
        return "$retorno Magreza leve";
      } else if (resultado >= 18.5 && resultado < 25) {
        return "$retorno Saudável";
      } else if (resultado >= 25 && resultado < 30) {
        return "$retorno Sobrepeso";
      } else if (resultado >= 30 && resultado < 35) {
        return "$retorno Obesidade Grau I";
      } else if (resultado >= 35 && resultado < 40) {
        return "$retorno Obesidade Grau II (Severa)";
      } else {
        return "$retorno Obesidade Grau III (Mórbida)";
      }
    } catch (e) {
      return "ERRO: $e";
    }
  }
}
