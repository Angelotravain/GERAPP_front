import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gerapp_front/Helpers/Controles/Campos/text_field.dart';
import 'package:gerapp_front/Helpers/Controles/entrada/campo_toogle.dart';
import 'package:gerapp_front/Helpers/Cores/cores.dart';
import 'package:gerapp_front/Helpers/conversor.dart';
import 'package:image_picker/image_picker.dart';

class ClientePrincipalForm extends StatefulWidget {
  final TextEditingController? nome;
  final TextEditingController? email;
  final TextEditingController? cpf;
  final TextEditingController? telefone;
  final TextEditingController? nomeMae;
  final TextEditingController? nomePai;
  final TextEditingController? nomeConjugue;
  final TextEditingController? imagem;
  bool? statusCliente;
  DateTime? dataNascimento;

  ClientePrincipalForm(
      {this.nome,
      this.email,
      this.cpf,
      this.telefone,
      this.dataNascimento,
      this.nomeMae,
      this.nomePai,
      this.nomeConjugue,
      this.imagem,
      this.statusCliente});

  @override
  State<ClientePrincipalForm> createState() => _ClientePrincipalFormState();
}

class _ClientePrincipalFormState extends State<ClientePrincipalForm> {
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
        widget.dataNascimento = picked ?? DateTime.now();
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
                          Conversor.convertBase64ToImage(widget.imagem!.text) ??
                              NetworkImage('')),
                  IconButton(
                    icon: Icon(Icons.add_a_photo),
                    onPressed: getImage,
                  ),
                ],
              ),
            ],
          ),
          CampoTexto(controller: widget.nome!, label: 'Nome'),
          CampoTexto(controller: widget.email!, label: 'E-mail'),
          CampoTexto(controller: widget.cpf!, label: 'CPF'),
          CampoTexto(controller: widget.nomeConjugue!, label: 'Conjuguê'),
          CampoTexto(controller: widget.nomeMae!, label: 'Nome da mãe'),
          CampoTexto(controller: widget.nomePai!, label: 'Nome do pai'),
          CampoTexto(
            controller: widget.telefone!,
            label: 'Telefone',
          ),
          ToogleSelecao(
              label: 'Cliente está ativo?',
              value: widget.statusCliente!,
              onChanged: (value) {
                setState(() {
                  widget.statusCliente = value;
                });
              }),
          ElevatedButton(
            onPressed: () => _selectDate(context),
            child: Text('Selecionar Data de Nascimento'),
          ),
          if (widget.dataNascimento != null)
            Text('Data de Nascimento: ${widget.dataNascimento}'),
        ],
      ),
    ));
  }
}
