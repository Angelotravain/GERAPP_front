import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gerapp_front/Helpers/Controles/entrada/appbar_grid.dart';
import 'package:gerapp_front/Helpers/Controles/entrada/montar_lista.dart';
import 'package:gerapp_front/Helpers/Cores/cores.dart';
import 'package:gerapp_front/Helpers/HttpGeneric.dart';
import 'package:gerapp_front/Helpers/LocalHttp.dart';
import 'package:gerapp_front/Modulos/Cadastro/Equipamento/equipamento_form.dart';
import 'package:gerapp_front/Modulos/Cadastro/equipamento/equipamento_model.dart';

class EquipamentoGrid extends StatefulWidget {
  const EquipamentoGrid({super.key});

  @override
  State<EquipamentoGrid> createState() => _equipamentoGridState();
}

class _equipamentoGridState extends State<EquipamentoGrid> {
  TextEditingController _pesquisa = TextEditingController();
  String? image = '';

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarGrid(
        controller: _pesquisa,
        funcaoAtualizar: () {
          _pesquisa.text = '';
        },
        funcaoRota: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EquipamentoForm(
                        equipamento: null,
                      ))).then((value) {
            _pesquisa.text = '';
          });
        },
        hintNegativo: 'Sem equipamentos para exibir!',
        hintPositivo: 'Pesquise seu equipamento!',
        validaHint: true,
      ),
      body: MontaLista(
        apiUrl: Local.URL_LISTAR_EQUIPAMENTO,
        controller: _pesquisa,
        deleteFunction: (p0) {
          GenericHttp().Delete(p0, Local.URL_DELETE_EQUIPAMENTO);
        },
        editFunction: (p0) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EquipamentoForm(
                        equipamento: EquipamentoModel.fromJson(json.encode(p0)),
                      ))).then((value) {
            setState(() {
              _pesquisa.text = '';
            });
          });
        },
        title: 'descricao',
        subtitle: '',
      ),
    );
  }
}
