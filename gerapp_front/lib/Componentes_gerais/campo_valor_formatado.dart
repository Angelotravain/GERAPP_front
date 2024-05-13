import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CampoValorFormatado extends StatefulWidget {
  final String label;
  final int maxLength;
  final Color? cor;
  final TextEditingController controller;

  const CampoValorFormatado({
    Key? key,
    required this.label,
    required this.maxLength,
    required this.controller,
    this.cor,
  }) : super(key: key);

  @override
  _CampoValorFormatadoState createState() => _CampoValorFormatadoState();
}

class _CampoValorFormatadoState extends State<CampoValorFormatado> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    widget.controller?.addListener(_formatValor);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _formatValor() {
    final value = widget.controller!.text.replaceAll(RegExp(r'[^\d]'), '');

    if (value.isNotEmpty) {
      final amount = int.parse(value);
      final formattedValue = 'R\$ ${(amount / 100).toStringAsFixed(2)}';

      widget.controller!.value = TextEditingValue(
        text: formattedValue,
        selection: TextSelection.collapsed(offset: formattedValue.length),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: widget.controller!,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        maxLength: widget.maxLength,
        decoration: InputDecoration(
          labelText: widget.label,
          hintText: 'Informe o valor',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
          fillColor: widget.cor,
        ),
      ),
    );
  }
}
