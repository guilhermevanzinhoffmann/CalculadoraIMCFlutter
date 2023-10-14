import 'package:calculadora_imc_app/pages/imc_page.dart';
import 'package:calculadora_imc_app/pages/user_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int posicaoInicial = 0;
  PageController pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Expanded(
              child: PageView(
            controller: pageController,
            onPageChanged: (value) {
              setState(() {
                posicaoInicial = value;
              });
            },
            children: const [UserPage(), IMCPage()],
          )),
          BottomNavigationBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            type: BottomNavigationBarType.fixed,
            onTap: (value) {
              pageController.jumpToPage(value);
            },
            currentIndex: posicaoInicial,
            items: const [
              BottomNavigationBarItem(
                  label: "Usuário", icon: Icon(Icons.person)),
              BottomNavigationBarItem(
                  label: "IMC", icon: Icon(Icons.auto_graph)),
            ],
          )
        ],
      ),
    ));
  }
}
