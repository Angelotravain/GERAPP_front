import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gerapp_front/Helpers/Controles/Campos/text_field.dart';
import 'package:gerapp_front/Helpers/Controles/entrada/campo_toogle.dart';
import 'package:gerapp_front/Helpers/Controles/entrada/novo_combo.dart';
import 'package:gerapp_front/Helpers/Cores/cores.dart';
import 'package:gerapp_front/Helpers/conversor.dart';
import 'package:gerapp_front/Modulos/Cadastro/equipamento/equipamento_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

import '../../../Helpers/Controles/entrada/appbar_cadastros.dart';
import '../../../Helpers/HttpGeneric.dart';
import '../../../Helpers/LocalHttp.dart';

class EquipamentoForm extends StatefulWidget {
  EquipamentoModel? equipamento;

  EquipamentoForm({this.equipamento});

  @override
  State<EquipamentoForm> createState() => _equipamentoPrincipalFormState();
}

class _equipamentoPrincipalFormState extends State<EquipamentoForm> {
  TextEditingController _imagem = TextEditingController();
  TextEditingController _descricao = TextEditingController();
  TextEditingController _quantidade = TextEditingController();
  TextEditingController _vrUnitario = TextEditingController();
  TextEditingController _tipoEquipamento = TextEditingController();
  TextEditingController _idTipoEquipamento = TextEditingController();
  bool? _estaDisponivel = false;

  @override
  initState() {
    if (widget.equipamento != null) PreencherCampos(widget.equipamento);
  }

  Future<void> getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    final bytes = await pickedFile?.readAsBytes();
    final base64Image = base64Encode(bytes!);
    setState(() {
      _imagem.text = base64Image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarCadastros(
          titulo: widget.equipamento != null
              ? 'Edite seu equipamento!'
              : 'Cadastre seu equipamento!',
          funcaoSalvar: () {
            widget.equipamento != null
                ? GenericHttp().Editar(
                    widget.equipamento!.id,
                    jsonEncode(
                      EquipamentoModel(
                          id: 0,
                          descricao: _descricao.text,
                          tipoEquipamentoId: _idTipoEquipamento.text != ''
                              ? int.parse(_idTipoEquipamento.text)
                              : 0,
                          quantidade: _quantidade.text != ''
                              ? int.parse(_quantidade.text)
                              : 0,
                          valorTotal: _vrUnitario.text != ''
                              ? double.parse(_vrUnitario.text)
                              : 0,
                          estaDisponivel: _estaDisponivel!,
                          imagem: _imagem.text != '' ? _imagem.text : ''),
                    ),
                    Local.URL_EDITAR_EQUIPAMENTO)
                : GenericHttp().Salvar(
                    jsonEncode(EquipamentoModel(
                        id: 0,
                        descricao: _descricao.text,
                        tipoEquipamentoId: _idTipoEquipamento.text != ''
                            ? int.parse(_idTipoEquipamento.text)
                            : 0,
                        quantidade: _quantidade.text != ''
                            ? int.parse(_quantidade.text)
                            : 0,
                        valorTotal: _vrUnitario.text != ''
                            ? double.parse(_vrUnitario.text)
                            : 0,
                        estaDisponivel: _estaDisponivel!,
                        imagem: _imagem.text != '' ? _imagem.text : '')),
                    Local.URL_SALVAR_EQUIPAMENTO);
            Navigator.pop(context);
          },
          tipoApp: widget.equipamento != null ? 'E' : 'I',
          icone: widget.equipamento != null
              ? Icon(Icons.save_as, color: Cores.BRANCO)
              : Icon(Icons.save, color: Cores.BRANCO),
          toolTipEntrada: widget.equipamento != null ? 'Editar' : 'Salvar',
        ),
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
                              Conversor.convertBase64ToImage(_imagem.text)),
                      IconButton(
                        icon: Icon(Icons.add_a_photo),
                        onPressed: getImage,
                      ),
                    ],
                  ),
                ],
              ),
              CampoTexto(
                controller: _descricao,
                label: 'Descricao',
              ),
              CampoTexto(
                controller: _quantidade,
                label: 'Quantidade (estoque)',
              ),
              CampoTexto(
                controller: _vrUnitario,
                label: 'Valor unitário (Aluguel)',
              ),
              ToogleSelecao(
                  label: 'Está disponível?',
                  value: _estaDisponivel!,
                  onChanged: (value) {
                    setState(() {
                      _estaDisponivel = value;
                    });
                  }),
              ComboPesquisavel(
                  apiUrl: Local.URL_TIPO_EQUIPAMENTO_LISTA,
                  controller: _tipoEquipamento,
                  name: 'descricao',
                  identify: 'id',
                  label: 'Tipo de equipamento',
                  id: _idTipoEquipamento),
            ],
          ),
        ));
  }

  void PreencherCampos(EquipamentoModel? equipamento) {
    if (equipamento != null) {
      _descricao.text = equipamento.descricao!;
      _idTipoEquipamento.text = equipamento.tipoEquipamentoId.toString();
      _vrUnitario.text = equipamento.valorTotal.toString();
      _imagem.text = equipamento.imagem ?? '';
      _estaDisponivel = equipamento.estaDisponivel;
      _quantidade.text = equipamento.quantidade.toString();
    }
  }
}
