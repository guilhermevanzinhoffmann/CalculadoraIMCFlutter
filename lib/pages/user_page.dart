import 'package:calculadora_imc_app/models/usuario.dart';
import 'package:calculadora_imc_app/repositories/usuario_repository.dart';
import 'package:calculadora_imc_app/widgets/numeric_input.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late UsuarioRepository repository;
  Usuario usuario = Usuario();
  TextEditingController nomeController = TextEditingController(text: "");
  TextEditingController alturaController = TextEditingController(text: "");

  bool salvando = false;

  @override
  void initState() {
    carregarDados();
    super.initState();
  }

  void carregarDados() async {
    repository = await UsuarioRepository.load();
    usuario = repository.getUsuario();
    nomeController.text = usuario.nome;
    alturaController.text = usuario.altura.toString();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Text("Dados do usuário"),
              centerTitle: true,
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            ),
            body: salvando
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text("Informe seu nome e sua altura",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w800)),
                        TextField(
                          controller: nomeController,
                          decoration: const InputDecoration(labelText: "Nome"),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        NumericInput(
                            label: "Altura (em metros)",
                            controller: alturaController),
                        const SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              salvando = false;
                            });
                            if (nomeController.text.isEmpty) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('Nome deve ser informado'),
                                elevation: 8,
                                backgroundColor: Colors.red,
                              ));
                              return;
                            }
                            if (alturaController.text.isEmpty) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('Altura deve ser informada'),
                                elevation: 8,
                                backgroundColor: Colors.red,
                              ));
                              return;
                            }

                            usuario.nome = nomeController.text;
                            usuario.altura =
                                double.tryParse(alturaController.text) ?? 0;
                            repository.save(usuario);
                            setState(() {
                              salvando = true;
                            });
                            Future.delayed(
                              const Duration(seconds: 1),
                              () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        backgroundColor: Colors.green,
                                        content:
                                            Text('Dados salvos com sucesso!')));
                              },
                            );
                            setState(() {
                              salvando = false;
                            });
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.blue.shade200)),
                          child: const Text(
                            "Salvar",
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        )
                      ],
                    ),
                  )));
  }
}
