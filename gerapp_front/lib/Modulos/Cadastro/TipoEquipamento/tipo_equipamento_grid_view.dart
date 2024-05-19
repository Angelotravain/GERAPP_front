import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gerapp_front/Helpers/Controles/entrada/appbar_grid.dart';
import 'package:gerapp_front/Helpers/Controles/entrada/montar_lista.dart';
import 'package:gerapp_front/Helpers/LocalHttp.dart';
import 'package:gerapp_front/Modulos/Cadastro/TipoEquipamento/tipo_equipamento_model.dart';
import 'package:gerapp_front/Modulos/Cadastro/TipoEquipamento/tipo_equipamento_repositorio.dart';

class TipoEquipamentoGrid extends StatefulWidget {
  TipoEquipamentoGrid({super.key});
  @override
  State<TipoEquipamentoGrid> createState() => _tipoEquipamentoGridState();
}

class _tipoEquipamentoGridState extends State<TipoEquipamentoGrid> {
  void atualizarEstado() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _buscarTodosOstipoEquipamentos();
    _pollingBuscartipoEquipamentos();
  }

  TextEditingController _pesquisa = TextEditingController();
  List<TipoEquipamentoModel> _tipoEquipamentos = [];
  List<TipoEquipamentoModel> _filtrados = [];

  void _buscarTodosOstipoEquipamentos() async {
    List<TipoEquipamentoModel> tipoEquipamentos =
        await TipoEquipamentoRepositorio().GetAlltipoEquipamentos();
    setState(() {
      _tipoEquipamentos = tipoEquipamentos;
      if (_filtrados.isEmpty && _pesquisa.text == '') {
        _filtrados = tipoEquipamentos;
      }
    });
  }

  void _pollingBuscartipoEquipamentos() {
    const duration = Duration(seconds: 0);
    Timer.periodic(duration, (Timer timer) {
      _filtrarPorPesquisa(_pesquisa.text);
    });
  }

  void _filtrarPorPesquisa(String filtro) {
    if (filtro != null || filtro != '') {
      setState(() {
        List<TipoEquipamentoModel> tipoEquipamentoFiltrado = _tipoEquipamentos
            .where(
                (x) => x.descricao.toLowerCase().contains(filtro.toLowerCase()))
            .toList();

        _filtrados = tipoEquipamentoFiltrado;
      });
    } else {
      setState(() {
        _filtrados = _tipoEquipamentos;
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
