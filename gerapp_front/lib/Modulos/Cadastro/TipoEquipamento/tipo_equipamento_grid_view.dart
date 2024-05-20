import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gerapp_front/Helpers/Controles/entrada/appbar_grid.dart';
import 'package:gerapp_front/Helpers/Controles/entrada/montar_lista.dart';
import 'package:gerapp_front/Helpers/LocalHttp.dart';
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
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => TipoEquipamentoForm(
          //               validarFrete: false,
          //             ))).then((value) {
          //   _filtrarPorPesquisa(_pesquisa.text);
          //   _buscarTodosOstipoEquipamentos();
          // });
        },
        funcaoAtualizar: () {
          _filtrarPorPesquisa(_pesquisa.text);
        },
        validaHint: true,
        hintPositivo: 'Pesquise seu tipoEquipamento!',
        hintNegativo: 'Sem tipoEquipamentos!',
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
          // Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //             builder: (context) => tipoEquipamentoForm(
          //                 validarFrete: false,
          //                 tipoEquipamento: tipoEquipamentoModel.fromMap(p0))))
          //     .then((value) {
          //   _filtrarPorPesquisa(_pesquisa.text);
          //   _buscarTodosOstipoEquipamentos();
          // });
        },
      ),
    );
  }
}
