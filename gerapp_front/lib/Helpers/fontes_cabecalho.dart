import 'package:flutter/material.dart';

class FonteCabecalho extends StatelessWidget {
  final String texto;
  const FonteCabecalho({required this.texto});

  @override
  Widget build(BuildContext context) {
    return Text(
      texto,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        fontFamily: 'Roboto',
      ),
    );
  }
}
