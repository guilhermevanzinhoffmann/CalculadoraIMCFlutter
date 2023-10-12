import 'package:calculadora_imc_app/pages/home_page.dart';
import 'package:flutter/material.dart';

class CalculadoraIMCApp extends StatelessWidget {
  const CalculadoraIMCApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora IMC',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
