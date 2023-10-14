import 'package:calculadora_imc_app/models/dados.dart';
import 'package:calculadora_imc_app/models/resultado_imc.dart';

class CalculadoraService {
  ResultadoIMC calcularIMC(Dados dados) {
    ResultadoIMC resultado = ResultadoIMC.empty();
    try {
      var peso = double.parse(dados.peso);
      var altura = double.parse(dados.altura);
      var calculo = peso / (altura * altura);
      if (calculo.isNaN || calculo.isInfinite) {
        throw Exception("Dados incorretos");
      }
      resultado.resultado = calculo.toStringAsFixed(2);
      if (calculo < 16) {
        resultado.descricao = "Magreza grave";
      } else if (calculo >= 16 && calculo < 17) {
        resultado.descricao = "Magreza moderada";
      } else if (calculo >= 17 && calculo < 18.5) {
        resultado.descricao = "Magreza leve";
      } else if (calculo >= 18.5 && calculo < 25) {
        resultado.descricao = "Saudável";
      } else if (calculo >= 25 && calculo < 30) {
        resultado.descricao = "Sobrepeso";
      } else if (calculo >= 30 && calculo < 35) {
        resultado.descricao = "Obesidade Grau I";
      } else if (calculo >= 35 && calculo < 40) {
        resultado.descricao = "Obesidade Grau II (Severa)";
      } else {
        resultado.descricao = "Obesidade Grau III (Mórbida)";
      }

      return resultado;
    } catch (e) {
      return resultado;
    }
  }
}
