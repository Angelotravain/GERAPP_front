import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gerapp_front/Helpers/Controles/Campos/text_field.dart';
import 'package:gerapp_front/Helpers/Controles/entrada/campo_toogle.dart';
import 'package:gerapp_front/Helpers/Controles/entrada/novo_combo.dart';
import 'package:gerapp_front/Helpers/LocalHttp.dart';
import 'package:gerapp_front/Modulos/Cadastro/Endereco/endereco_model.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Helpers/conversor.dart';

class EmpresaPrincipalForm extends StatefulWidget {
  TextEditingController? nomeEmpresa;
  TextEditingController? cnpjEmpresa;
  TextEditingController? estadoEmpresa;
  TextEditingController? estadoIdEmpresa;
  TextEditingController? telefoneEmpresa;
  TextEditingController? emailEmpresa;
  TextEditingController? webSiteEmpresa;
  String? dataFundacaoEmpresa;
  TextEditingController? ramoAtuacaoEmpresa;
  TextEditingController? numeroFuncionariosEmpresa;
  TextEditingController? proprietarioEmpresa;
  TextEditingController? logoEmpresa;
  bool? ehFilialEmpresa;
  EnderecoModel? enderecosEmpresa;

  EmpresaPrincipalForm(
      {this.nomeEmpresa,
      this.cnpjEmpresa,
      this.estadoEmpresa,
      this.estadoIdEmpresa,
      this.telefoneEmpresa,
      this.emailEmpresa,
      this.webSiteEmpresa,
      this.dataFundacaoEmpresa,
      this.ramoAtuacaoEmpresa,
      this.numeroFuncionariosEmpresa,
      this.proprietarioEmpresa,
      this.logoEmpresa,
      this.ehFilialEmpresa});

  @override
  State<EmpresaPrincipalForm> createState() => _EmpresaPrincipalFormState();
}

class _EmpresaPrincipalFormState extends State<EmpresaPrincipalForm> {
  TextEditingController? _nomeEmpresa;
  TextEditingController? _cnpjEmpresa;
  TextEditingController? _estadoEmpresa;
  TextEditingController? _estadoIdEmpresa;
  TextEditingController? _telefoneEmpresa;
  TextEditingController? _emailEmpresa;
  TextEditingController? _webSiteEmpresa;
  TextEditingController? _ramoAtuacaoEmpresa;
  TextEditingController? _numeroFuncionariosEmpresa;
  TextEditingController? _proprietarioEmpresa;
  TextEditingController? _logoEmpresa;
  bool? _ehFilialEmpresa;
  String? _dataFundacaoEmpresa;

  @override
  void initState() {
    super.initState();
    _nomeEmpresa = widget.nomeEmpresa;
    _cnpjEmpresa = widget.cnpjEmpresa;
    _estadoEmpresa = widget.estadoEmpresa;
    _estadoIdEmpresa = widget.estadoIdEmpresa;
    _telefoneEmpresa = widget.telefoneEmpresa;
    _emailEmpresa = widget.emailEmpresa;
    _webSiteEmpresa = widget.webSiteEmpresa;
    _ramoAtuacaoEmpresa = widget.ramoAtuacaoEmpresa;
    _numeroFuncionariosEmpresa = widget.numeroFuncionariosEmpresa;
    _proprietarioEmpresa = widget.proprietarioEmpresa;
    _logoEmpresa = widget.logoEmpresa;
    _ehFilialEmpresa = widget.ehFilialEmpresa;
    _dataFundacaoEmpresa =
        widget.dataFundacaoEmpresa ?? DateTime.now().toIso8601String();
  }

  Future<void> getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    final bytes = await pickedFile?.readAsBytes();
    final base64Image = base64Encode(bytes!);
    setState(() {
      _logoEmpresa?.text = base64Image;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
        context: context,
        initialEntryMode: DatePickerEntryMode.input,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
        locale: Locale('pt', 'BR')))!;

    if (picked != null) {
      setState(() {
        _dataFundacaoEmpresa = picked.toIso8601String() ?? '';
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
                          Conversor.convertBase64ToImage(_logoEmpresa!.text) ??
                              NetworkImage(''),
                    ),
                    IconButton(
                      icon: Icon(Icons.add_a_photo),
                      onPressed: getImage,
                    ),
                  ],
                ),
              ],
            ),
            CampoTexto(controller: _nomeEmpresa!, label: 'Nome'),
            CampoTexto(controller: _cnpjEmpresa!, label: 'CNPJ'),
            CampoTexto(controller: _emailEmpresa!, label: 'e-mail'),
            CampoTexto(controller: _webSiteEmpresa!, label: 'WebSite'),
            CampoTexto(controller: _telefoneEmpresa!, label: 'Telefone'),
            CampoTexto(
                controller: _ramoAtuacaoEmpresa!, label: 'Ramo de atuação'),
            CampoTexto(
                controller: _numeroFuncionariosEmpresa!,
                label: 'Número de funcionários'),
            CampoTexto(
                controller: _proprietarioEmpresa!, label: 'Proprietário'),
            ToogleSelecao(
              label: 'Empresa é uma filial?',
              value: _ehFilialEmpresa!,
              onChanged: (value) {
                setState(() {
                  _ehFilialEmpresa = value;
                });
              },
            ),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: Text('Selecionar Data de fundação'),
            ),
            if (_dataFundacaoEmpresa != null)
              Text('Data de Fundação: ${_dataFundacaoEmpresa}'),
          ],
        ),
      ),
    );
  }
}
