import 'package:flutter/material.dart';

class CampoTexto extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final int? maxLenght;
  Widget? sufix;
  CampoTexto(
      {required this.controller,
      required this.label,
      this.sufix,
      this.maxLenght});

  @override
  Widget build(BuildContext context) {
    const String FONTE_PADRAO = 'Roboto';

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        maxLength: maxLenght,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: FONTE_PADRAO,
        ),
        decoration: InputDecoration(
            labelText: label,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
            suffixIcon: sufix),
      ),
    );
  }
}
