import 'package:calculadora_imc_app/models/dados.dart';
import 'package:calculadora_imc_app/services/calculadora_service.dart';
import 'package:flutter/material.dart';

class ResultadoPage extends StatefulWidget {
  final Dados dados;
  const ResultadoPage({super.key, required this.dados});

  @override
  State<ResultadoPage> createState() => _ResultadoPageState();
}

class _ResultadoPageState extends State<ResultadoPage> {
  CalculadoraService service = CalculadoraService();
  String resultado = "";
  bool calculouResultado = false;

  @override
  void initState() {
    super.initState();
    calcularIMC();
  }

  void calcularIMC() async {
    //resultado = await service.calcularIMCAsync(widget.dados);

    setState(() {
      calculouResultado = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return !calculouResultado
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              title: const Text("Calculadora IMC"),
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              centerTitle: true,
            ),
            body: Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    const Text(
                      "Resultado",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                    ),
                    Text(
                      resultado,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 8,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.blue.shade200)),
                          child: const Text("Calcular novamente",
                              style: TextStyle(color: Colors.black)),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ));
  }
}
