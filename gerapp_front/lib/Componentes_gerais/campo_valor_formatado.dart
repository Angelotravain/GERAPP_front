import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CampoValorFormatado extends StatefulWidget {
  final String nomeCampo;
  final int maxLength;
  final Color? cor;

  const CampoValorFormatado({
    Key? key,
    required this.nomeCampo,
    required this.maxLength,
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
    _controller = TextEditingController();
    _controller.addListener(_formatValor);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _formatValor() {
    final value = _controller.text.replaceAll(RegExp(r'[^\d]'), '');

    if (value.isNotEmpty) {
      final amount = int.parse(value);
      final formattedValue = 'R\$ ${(amount / 100).toStringAsFixed(2)}';

      _controller.value = TextEditingValue(
        text: formattedValue,
        selection: TextSelection.collapsed(offset: formattedValue.length),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      maxLength: widget.maxLength,
      decoration: InputDecoration(
        labelText: widget.nomeCampo,
        hintText: 'Informe o valor',
        border: OutlineInputBorder(),
        fillColor: widget.cor,
      ),
    );
  }
}
