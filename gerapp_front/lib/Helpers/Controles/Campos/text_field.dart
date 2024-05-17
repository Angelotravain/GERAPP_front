import 'package:flutter/material.dart';

class CampoTexto extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final int? maxLenght;
  bool? validate = false;
  Widget? sufix;
  CampoTexto(
      {required this.controller,
      required this.label,
      this.sufix,
      this.maxLenght,
      this.validate});

  @override
  Widget build(BuildContext context) {
    const String FONTE_PADRAO = 'Roboto';

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        maxLength: maxLenght,
        obscureText: validate ?? false,
        validator: validate == true
            ? (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, preencha o campo!';
                }
              }
            : (value) {},
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
