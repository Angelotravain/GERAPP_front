import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gerapp_front/Helpers/Controles/entrada/appbar_grid.dart';
import 'package:gerapp_front/Helpers/Controles/entrada/montar_lista.dart';
import 'package:gerapp_front/Helpers/HttpGeneric.dart';
import 'package:gerapp_front/Helpers/LocalHttp.dart';
import 'package:gerapp_front/Modulos/Cadastro/TipoEquipamento/tipo_equipamento_form_view.dart';
import 'package:gerapp_front/Modulos/Cadastro/TipoEquipamento/tipo_equipamento_model.dart';
import 'package:gerapp_front/Modulos/Cadastro/TipoEquipamento/tipo_equipamento_repositorio.dart';

class TipoEquipamentoGrid extends StatefulWidget {
  TipoEquipamentoGrid({super.key});
  @override
  State<TipoEquipamentoGrid> createState() => _tipoEquipamentoGridState();
}

class _tipoEquipamentoGridState extends State<TipoEquipamentoGrid> {
  TextEditingController _pesquisa = TextEditingController();

  void _filtrarPorPesquisa(String filtro) {
    if (filtro != null || filtro != '') {
      setState(() {
        _pesquisa.text = filtro;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarGrid(
        funcaoRota: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TipoEquipamentoForm(
                        tipoEquipamento: null,
                      ))).then((value) {
            _filtrarPorPesquisa(_pesquisa.text);
          });
        },
        funcaoAtualizar: () {
          _pesquisa.text = '';
        },
        validaHint: true,
        hintPositivo: 'Pesquise seu tipo de equipamento!',
        hintNegativo: 'Sem tipos de equipamentos!',
        controller: _pesquisa,
      ),
      body: MontaLista(
        apiUrl: Local.URL_TIPO_EQUIPAMENTO_LISTA,
        controller: _pesquisa,
        deleteFunction: (p0) {
          TipoEquipamentoRepositorio().deleteTipoEquipamento(p0);
        },
        subtitle: 'modelo',
        title: 'descricao',
        editFunction: (p0) {
          Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TipoEquipamentoForm(
                          tipoEquipamento: TipoEquipamentoModel.fromJson(p0))))
              .then((value) {
            setState(() {
              _pesquisa.text = '';
            });
          });
        },
      ),
    );
  }
}
