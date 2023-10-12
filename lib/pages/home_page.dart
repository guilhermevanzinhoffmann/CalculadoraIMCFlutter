import 'package:calculadora_imc_app/models/dados.dart';
import 'package:calculadora_imc_app/pages/resultado_page.dart';
import 'package:calculadora_imc_app/widgets/numeric_input.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({super.key, required this.title});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController pesoController = TextEditingController(text: "");
  TextEditingController alturaController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text("Informe seu peso e altura",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
              NumericInput(label: "Peso", controller: pesoController),
              const SizedBox(
                height: 10,
              ),
              NumericInput(label: "Altura", controller: alturaController),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  if (pesoController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Peso deve ser informado'),
                      elevation: 8,
                      backgroundColor: Colors.red,
                    ));
                    return;
                  }
                  if (alturaController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Altura deve ser informada'),
                      elevation: 8,
                      backgroundColor: Colors.red,
                    ));
                    return;
                  }
                  var dados = Dados(pesoController.text, alturaController.text);
                  pesoController.text = "";
                  alturaController.text = "";

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => ResultadoPage(dados: dados))));
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.blue.shade200)),
                child: const Text(
                  "Calcular IMC",
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              )
            ],
          ),
        ));
  }
}
