import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gerapp_front/Helpers/Controles/entrada/appbar_grid.dart';
import 'package:gerapp_front/Helpers/Controles/entrada/montar_lista.dart';
import 'package:gerapp_front/Helpers/LocalHttp.dart';
import 'package:gerapp_front/Modulos/Cadastro/Bairro/bairro_form_view.dart';
import 'package:gerapp_front/Modulos/Cadastro/Bairro/bairro_model.dart';
import 'package:gerapp_front/Modulos/Cadastro/Bairro/bairro_repositorio.dart';

class BairroGrid extends StatefulWidget {
  BairroGrid({super.key});
  @override
  State<BairroGrid> createState() => _BairroGridState();
}

class _BairroGridState extends State<BairroGrid> {
  void atualizarEstado() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _buscarTodosOsBairros();
    _pollingBuscarBairros();
  }

  TextEditingController _pesquisa = TextEditingController();
  List<BairroModel> _bairros = [];
  List<BairroModel> _filtrados = [];

  void _buscarTodosOsBairros() async {
    List<BairroModel> bairros = await BairroRepositorio().GetAllBairros();
    setState(() {
      _bairros = bairros;
      if (_filtrados.isEmpty && _pesquisa.text == '') {
        _filtrados = bairros;
      }
    });
  }

  void _pollingBuscarBairros() {
    const duration = Duration(seconds: 0);
    Timer.periodic(duration, (Timer timer) {
      _filtrarPorPesquisa(_pesquisa.text);
    });
  }

  void _filtrarPorPesquisa(String filtro) {
    if (filtro != null || filtro != '') {
      setState(() {
        List<BairroModel> bairroFiltrado = _bairros
            .where((x) => x.nome.toLowerCase().contains(filtro.toLowerCase()))
            .toList();

        _filtrados = bairroFiltrado;
      });
    } else {
      setState(() {
        _filtrados = _bairros;
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
                  builder: (context) => BairroForm(
                        validarFrete: false,
                      ))).then((value) {
            _filtrarPorPesquisa(_pesquisa.text);
            _buscarTodosOsBairros();
          });
        },
        funcaoAtualizar: () {
          _filtrarPorPesquisa(_pesquisa.text);
        },
        validaHint: true,
        hintPositivo: 'Pesquise seu bairro!',
        hintNegativo: 'Sem bairros!',
        controller: _pesquisa,
      ),
      body: MontaLista(
        apiUrl: '${Local.localName}/api/Gerapp/Cadastro/ListarBairros',
        controller: _pesquisa,
        deleteFunction: (p0) {
          BairroRepositorio().deleteBairro(p0);
        },
        subtitle: '',
        title: 'nome',
        editFunction: (p0) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BairroForm(
                      validarFrete: false,
                      bairro: BairroModel.fromMap(p0)))).then((value) {
            _filtrarPorPesquisa(_pesquisa.text);
            _buscarTodosOsBairros();
          });
        },
      ),
    );
  }
}
