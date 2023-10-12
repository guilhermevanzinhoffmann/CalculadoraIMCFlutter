import 'package:calculadora_imc_app/calculadora_imc_app.dart';
import 'package:calculadora_imc_app/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UsuarioAdapter());
  runApp(const CalculadoraIMCApp());
}
