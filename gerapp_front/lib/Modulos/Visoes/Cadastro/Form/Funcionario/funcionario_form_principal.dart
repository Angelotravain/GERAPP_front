import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gerapp_front/Componentes_gerais/campo_valor_formatado.dart';
import 'package:gerapp_front/Helpers/Controles/Campos/text_field.dart';
import 'package:gerapp_front/Helpers/Cores/cores.dart';
import 'package:gerapp_front/Helpers/conversor.dart';
import 'package:image_picker/image_picker.dart';

class FuncionarioPrincipalForm extends StatefulWidget {
  final TextEditingController? nome;
  final TextEditingController? salario;
  final TextEditingController? imagem;
  DateTime? dataNascimento;

  FuncionarioPrincipalForm({
    this.nome,
    this.salario,
    this.imagem,
  });

  @override
  State<FuncionarioPrincipalForm> createState() =>
      _funcionarioPrincipalFormState();
}

class _funcionarioPrincipalFormState extends State<FuncionarioPrincipalForm> {
  Future<void> getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    final bytes = await pickedFile?.readAsBytes();
    final base64Image = base64Encode(bytes!);
    setState(() {
      widget.imagem?.text = base64Image;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
        context: context,
        initialEntryMode: DatePickerEntryMode.input,
        initialDate: widget.dataNascimento ?? DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
        locale: Locale('pt', 'BR')))!;

    if (picked != null) {
      setState(() {
        widget.dataNascimento = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Column(
            children: [
              SizedBox(height: 10),
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  CircleAvatar(
                      radius: 100,
                      backgroundImage:
                          Conversor.convertBase64ToImage(widget.imagem!.text)),
                  IconButton(
                    icon: Icon(Icons.add_a_photo),
                    onPressed: getImage,
                  ),
                ],
              ),
            ],
          ),
          CampoTexto(controller: widget.nome!, label: 'Nome'),
          CampoValorFormatado(
              controller: widget.salario!, label: 'Salário', maxLength: 30)
        ],
      ),
    ));
  }
}
