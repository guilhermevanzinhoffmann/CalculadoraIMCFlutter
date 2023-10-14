import 'package:calculadora_imc_app/models/card_detail.dart';
import 'package:calculadora_imc_app/models/dados.dart';
import 'package:calculadora_imc_app/models/historico.dart';
import 'package:calculadora_imc_app/models/resultado_imc.dart';
import 'package:calculadora_imc_app/models/usuario.dart';
import 'package:calculadora_imc_app/repositories/usuario_repository.dart';
import 'package:calculadora_imc_app/services/calculadora_service.dart';
import 'package:calculadora_imc_app/services/historico_service.dart';
import 'package:calculadora_imc_app/widgets/numeric_input.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class IMCPage extends StatefulWidget {
  const IMCPage({super.key});

  @override
  State<IMCPage> createState() => _IMCPageState();
}

class _IMCPageState extends State<IMCPage> {
  List<CardDetail> cards = [];
  HistoricoService service = HistoricoService();
  CalculadoraService calculadoraService = CalculadoraService();
  TextEditingController pesoController = TextEditingController(text: "");
  Usuario usuario = Usuario();
  late UsuarioRepository repository;

  @override
  void initState() {
    carregarDados();
    super.initState();
  }

  void carregarDados() async {
    repository = await UsuarioRepository.load();
    usuario = repository.getUsuario();
    cards = await service.obterDados();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("IMC"),
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: ListView(
          children: usuario.nome.isEmpty
              ? [
                  const Card(
                    elevation: 10,
                    shadowColor: Colors.deepOrange,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Column(
                        children: [
                          Text(
                              "Usuário não cadastrado. Cadastre um usuário antes de começar."),
                        ],
                      ),
                    ),
                  )
                ]
              : cards.isEmpty
                  ? [
                      const Card(
                        elevation: 10,
                        shadowColor: Colors.deepOrange,
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Column(
                            children: [
                              Text("Nenum registro encontrado"),
                            ],
                          ),
                        ),
                      )
                    ]
                  : cards
                      .map((cardDetail) => Hero(
                            tag: cardDetail.id,
                            child: Card(
                              elevation: 10,
                              shadowColor: Colors.red,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                        textAlign: TextAlign.justify,
                                        "Data: ${cardDetail.data}"),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Text("Nome: ${cardDetail.nome}",
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400)),
                                        const SizedBox(
                                          width: 18,
                                        ),
                                        Text(
                                            textAlign: TextAlign.justify,
                                            "Peso: ${cardDetail.peso}"),
                                        const SizedBox(
                                          width: 18,
                                        ),
                                        Text(
                                            textAlign: TextAlign.justify,
                                            "Altura: ${cardDetail.altura}"),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                        textAlign: TextAlign.justify,
                                        "IMC: ${cardDetail.estadoImc}"),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                        width: double.infinity,
                                        alignment: Alignment.centerRight,
                                        child: InkWell(
                                            onTap: () async {
                                              await service
                                                  .remover(cardDetail.id);
                                              carregarDados();
                                            },
                                            child: const Icon(Icons.delete))),
                                  ],
                                ),
                              ),
                            ),
                          ))
                      .toList(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (usuario.nome.isEmpty) return;
            pesoController.text = "";
            showDialog(
                context: context,
                builder: (BuildContext bc) {
                  return AlertDialog(
                      title: const Text("Calcular IMC"),
                      content: NumericInput(
                          label: "Peso (em Kg)", controller: pesoController),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Cancelar")),
                        TextButton(
                            onPressed: () async {
                              if (pesoController.text.isEmpty) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text('Peso deve ser informado'),
                                  elevation: 8,
                                  backgroundColor: Colors.red,
                                ));
                                return;
                              }
                              ResultadoIMC resultadoIMC =
                                  calculadoraService.calcularIMC(Dados(
                                      pesoController.text,
                                      usuario.altura.toStringAsFixed(2)));
                              Historico historico = Historico(
                                  usuario.nome,
                                  usuario.altura.toStringAsFixed(2),
                                  pesoController.text,
                                  resultadoIMC.descricao,
                                  resultadoIMC.resultado,
                                  DateFormat('dd/MM/yyyy')
                                      .format(DateTime.now()));

                              await service.salvar(historico);

                              carregarDados();

                              if (context.mounted) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text('Registro salvo com sucesso!'),
                                  elevation: 8,
                                  backgroundColor: Colors.green,
                                ));

                                Navigator.pop(context);
                              } else {
                                return;
                              }
                            },
                            child: const Text("Calcular IMC"))
                      ]);
                });
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
