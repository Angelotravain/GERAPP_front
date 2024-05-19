import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gerapp_front/Helpers/Controles/entrada/appbar_grid.dart';
import 'package:gerapp_front/Helpers/Controles/entrada/montar_lista.dart';
import 'package:gerapp_front/Helpers/Cores/cores.dart';
import 'package:gerapp_front/Helpers/LocalHttp.dart';
import 'package:gerapp_front/Modulos/Cadastro/Veiculo/veiculo_form_view.dart';
import 'package:gerapp_front/Modulos/Cadastro/Veiculo/veiculo_model.dart';
import 'package:gerapp_front/Modulos/Cadastro/veiculo/veiculo_repositorio.dart';

class veiculoGrid extends StatefulWidget {
  const veiculoGrid({super.key});

  @override
  State<veiculoGrid> createState() => _veiculoGridState();
}

class _veiculoGridState extends State<veiculoGrid> {
  TextEditingController _pesquisa = TextEditingController();
  List<VeiculoModel> _veiculos = [];
  List<VeiculoModel> _filtrados = [];
  String? image = '';

  @override
  void initState() {
    _buscarTodosOsveiculos();
    // _pollingBuscarveiculos();
  }

  void _pollingBuscarveiculos() {
    const duration = Duration(seconds: 0);
    Timer.periodic(duration, (Timer timer) {
      _buscarTodosOsveiculos();
      _filtrarPorPesquisa(_pesquisa.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarGrid(
        controller: _pesquisa,
        funcaoAtualizar: () {
          _filtrarPorPesquisa(_pesquisa.text);
        },
        funcaoRota: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => VeiculoForm(
                        veiculo: null,
                      ))).then((value) {
            _buscarTodosOsveiculos();
          });
        },
        hintNegativo: 'Sem veiculos para exibir!',
        hintPositivo: 'Pesquise seu veiculo!',
        validaHint: _filtrados.isNotEmpty,
      ),
      body: MontaLista(
        apiUrl: Local.URL_VEICULO,
        controller: _pesquisa,
        deleteFunction: (p0) {
          VeiculoRepositorio().deleteVeiculo(p0);
        },
        editFunction: (p0) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => VeiculoForm(
                        veiculo: VeiculoModel.fromJson(p0),
                      ))).then((value) {
            setState(() {
              _buscarTodosOsveiculos();
            });
          });
        },
        title: 'modelo',
        subtitle: 'marca',
      ),
    );
  }

  void _filtrarPorPesquisa(String filtro) {
    if (filtro != '') {
      setState(() {
        List<VeiculoModel> veiculoFiltrado = _veiculos
            .where((x) =>
                x.modelo != '' &&
                x.modelo!.toLowerCase().contains(filtro.toLowerCase()))
            .toList();

        _filtrados = veiculoFiltrado;
      });
    } else {
      setState(() {
        _filtrados = _veiculos;
      });
    }
  }

  void _buscarTodosOsveiculos() async {
    List<VeiculoModel>? veiculos = await VeiculoRepositorio().getAllVeiculos();
    setState(() {
      _veiculos = veiculos ?? [];
      if (_filtrados.isEmpty && _pesquisa.text == '') {
        _filtrados = _veiculos;
      }
    });
  }
}
