import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gerapp_front/Helpers/Controles/Campos/text_field.dart';
import 'package:gerapp_front/Helpers/Controles/entrada/appbar_cadastros.dart';
import 'package:gerapp_front/Helpers/Cores/cores.dart';
import 'package:gerapp_front/Helpers/HttpGeneric.dart';
import 'package:gerapp_front/Helpers/LocalHttp.dart';
import 'package:gerapp_front/Modulos/Cadastro/TipoEquipamento/tipo_equipamento_model.dart';
import 'package:gerapp_front/Modulos/Cadastro/TipoEquipamento/tipo_equipamento_repositorio.dart';

class TipoEquipamentoForm extends StatefulWidget {
  final TipoEquipamentoModel? tipoEquipamento;

  TipoEquipamentoForm({this.tipoEquipamento});

  @override
  State<TipoEquipamentoForm> createState() => _tipoequipamentoFormState();
}

class _tipoequipamentoFormState extends State<TipoEquipamentoForm> {
  TextEditingController _tempoEntreManutencao = TextEditingController();
  TextEditingController _modelo = TextEditingController();
  TextEditingController _descricao = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    PreencherCampos(widget.tipoEquipamento ?? null);
  }

  void PreencherCampos(TipoEquipamentoModel? tipoequipamento) {
    if (tipoequipamento != null) {
      _tempoEntreManutencao.text =
          tipoequipamento.tempoEntreManutencao.toString();
      _descricao.text = tipoequipamento.descricao;
      _modelo.text = tipoequipamento.modelo;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarCadastros(
          titulo: widget.tipoEquipamento != null
              ? 'Edite seu veículo!'
              : 'Cadastre seu veículo!',
          funcaoSalvar: () {
            widget.tipoEquipamento != null
                ? GenericHttp()
                    .Editar(
                        widget.tipoEquipamento!.id,
                        jsonEncode(TipoEquipamentoModel(
                            id: widget.tipoEquipamento!.id,
                            descricao: _descricao.text,
                            modelo: _modelo.text,
                            tempoEntreManutencao:
                                _tempoEntreManutencao.text != ''
                                    ? int.parse(_tempoEntreManutencao.text)
                                    : 0)),
                        Local.EDITAR_TIPO_EQUIPAMENTO)
                    .then((value) => Navigator.pop(context))
                : GenericHttp()
                    .Salvar(
                        jsonEncode(TipoEquipamentoModel(
                            id: 0,
                            descricao: _descricao.text,
                            modelo: _modelo.text,
                            tempoEntreManutencao:
                                _tempoEntreManutencao.text != ''
                                    ? int.parse(_tempoEntreManutencao.text)
                                    : 0)),
                        Local.SALVAR_TIPO_EQUIPAMENTO)
                    .then((value) => Navigator.pop(context));
          },
          icone: widget.tipoEquipamento != null
              ? Icon(Icons.save_as, color: Cores.BRANCO)
              : Icon(Icons.save, color: Cores.BRANCO),
          toolTipEntrada: widget.tipoEquipamento != null ? 'Editar' : 'Salvar',
          tipoApp: widget.tipoEquipamento != null ? 'E' : 'I',
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              CampoTexto(controller: _descricao, label: 'Descrição'),
              CampoTexto(controller: _modelo, label: 'Modelo'),
              CampoTexto(
                  controller: _tempoEntreManutencao,
                  label: 'Tempo de manutenção')
            ],
          ),
        ));
  }
}
