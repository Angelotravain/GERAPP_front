import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gerapp_front/Componentes_gerais/campo_valor_formatado.dart';
import 'package:gerapp_front/Helpers/Controles/Campos/text_field.dart';
import 'package:gerapp_front/Helpers/Controles/entrada/novo_combo.dart';
import 'package:gerapp_front/Helpers/Cores/cores.dart';
import 'package:gerapp_front/Helpers/LocalHttp.dart';
import 'package:gerapp_front/Helpers/conversor.dart';
import 'package:gerapp_front/Modulos/Cadastro/Bairro/bairro_model.dart';
import 'package:gerapp_front/Modulos/Cadastro/Cargo/cargo_model.dart';
import 'package:gerapp_front/Modulos/Cadastro/Empresa/empresa_model.dart';
import 'package:gerapp_front/Modulos/Cadastro/Funcionario/funcionario_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class FuncionarioPrincipalForm extends StatefulWidget {
  final TextEditingController? nome;
  final TextEditingController? salario;
  final TextEditingController? imagem;
  final TextEditingController selecionarCargo;
  final TextEditingController selecionarEmpresa;
  final TextEditingController idEmpresa;
  final TextEditingController idCargo;
  final FuncionarioModel? funcionario;
  DateTime? dataNascimento;

  FuncionarioPrincipalForm(
      {this.nome,
      this.salario,
      this.imagem,
      required this.selecionarCargo,
      required this.selecionarEmpresa,
      this.funcionario,
      required this.idCargo,
      required this.idEmpresa});

  @override
  State<FuncionarioPrincipalForm> createState() =>
      _funcionarioPrincipalFormState();
}

class _funcionarioPrincipalFormState extends State<FuncionarioPrincipalForm> {
  Future<CargoModel>? _cargoFuturo;
  Future<EmpresaModel>? _empresaFuturo;

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
          CampoTexto(
            controller: widget.nome!,
            label: 'Nome',
          ),
          CampoValorFormatado(
              controller: widget.salario!, label: 'Salário', maxLength: 30),
          ComboPesquisavel(
            apiUrl: '${Local.localName}/api/Gerapp/Cadastro/ListarCargos',
            controller: widget.selecionarCargo,
            identify: 'id',
            name: 'descricao',
            label: 'Pesquise seu cargo',
            id: widget.idCargo,
          ),
          ComboPesquisavel(
            apiUrl: '${Local.localName}/api/Gerapp/Cadastro/ListarEmpresas',
            controller: widget.selecionarEmpresa,
            identify: 'id',
            name: 'nome',
            label: 'Pesquise sua empresa',
            id: widget.idEmpresa,
          ),
        ],
      ),
    ));
  }
}
