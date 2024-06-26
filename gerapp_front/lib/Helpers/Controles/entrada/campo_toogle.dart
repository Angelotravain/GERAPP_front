import 'package:flutter/material.dart';
import 'package:gerapp_front/Helpers/Cores/cores.dart';

class ToogleSelecao extends StatelessWidget {
  final String label;
  final bool value;
  final Function(bool)? onChanged;

  const ToogleSelecao(
      {required this.label, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Cores.VERDE,
        ),
      ],
    );
  }
}
