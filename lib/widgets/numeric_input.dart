import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
      ],
      decoration: InputDecoration(labelText: widget.label),
    );
  }
}
