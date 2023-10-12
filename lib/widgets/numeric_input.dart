import 'package:flutter/material.dart';

class NumericInput extends StatefulWidget {
  final String label;

  final TextEditingController controller;

  const NumericInput(
      {super.key, required this.label, required this.controller});

  @override
  State<NumericInput> createState() => _NumericInputState();
}

class _NumericInputState extends State<NumericInput> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      keyboardType:
          const TextInputType.numberWithOptions(signed: false, decimal: true),
      decoration: InputDecoration(labelText: widget.label),
    );
  }
}
