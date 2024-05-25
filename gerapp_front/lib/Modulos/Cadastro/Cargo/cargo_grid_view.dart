import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gerapp_front/Helpers/Controles/entrada/appbar_grid.dart';
import 'package:gerapp_front/Helpers/Controles/entrada/campo_toogle.dart';
import 'package:gerapp_front/Helpers/Cores/cores.dart';
import 'package:gerapp_front/Modulos/Cadastro/Cargo/cargo_form_view.dart';
import 'package:gerapp_front/Modulos/Cadastro/Cargo/cargo_model.dart';
import 'package:gerapp_front/Modulos/Cadastro/Cargo/cargo_repositorio.dart';

import '../../../Helpers/Controles/entrada/montar_lista.dart';
import '../../../Helpers/LocalHttp.dart';

class CargoGrid extends StatefulWidget {
  const CargoGrid({super.key});

  @override
  State<CargoGrid> createState() => _CargoGridState();
}

TextEditingController _pesquisa = TextEditingController();
List<CargoModel> _cargos = [];
List<CargoModel> _filtrados = [];

class _CargoGridState extends State<CargoGrid> {
  @override
  void initState() {
    super.initState();
    _buscarTodosOsCargos();
    _pollingBuscarCargos();
  }

  void _buscarTodosOsCargos() async {
    List<CargoModel> cargos = await CargoRepositorio().GetAllCargos();
    setState(() {
      _cargos = cargos;
      if (_filtrados.isEmpty && _pesquisa.text == '') {
        _filtrados = cargos;
      }
    });
  }

  void _pollingBuscarCargos() {
    const duration = Duration(seconds: 0);
    Timer.periodic(duration, (Timer timer) {
      _buscarTodosOsCargos();
      _filtrarPorPesquisa(_pesquisa.text);
    });
  }

  void _filtrarPorPesquisa(String filtro) {
    if (filtro != null || filtro != '') {
      setState(() {
        List<CargoModel> bairroFiltrado = _cargos
            .where(
                (x) => x.descricao.toLowerCase().contains(filtro.toLowerCase()))
            .toList();

        _filtrados = bairroFiltrado;
      });
    } else {
      setState(() {
        _filtrados = _cargos;
      });
    }
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
            Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CargoForm(null)))
                .then((value) {
              _buscarTodosOsCargos();
            });
          },
          hintNegativo: 'Sem cargos para exibir!',
          hintPositivo: 'Pesquise seu cargo!',
          validaHint: _filtrados.isNotEmpty,
        ),
        body: MontaLista(
            apiUrl: Local.URL_BUSCAR_CARGO,
            title: 'descricao',
            subtitle: '',
            controller: _pesquisa,
            editFunction: (p0) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          CargoForm(CargoModel.fromMap(p0)))).then((value) {
                _buscarTodosOsCargos();
              });
            },
            deleteFunction: ((p0) {
              CargoRepositorio().deleteCargo(p0);
            })));
  }

  List<Widget> _buildToogleSelecao(CargoModel cargo) {
    return [
      ToogleSelecao(
        label: 'Visualiza cadastro?',
        value: cargo.acessaCadastro,
        onChanged: (value) {},
      ),
      ToogleSelecao(
        label: 'Visualiza Financeiro?',
        value: cargo.acessaFinanceiro,
        onChanged: (value) {},
      ),
      ToogleSelecao(
        label: 'Visualiza Locação?',
        value: cargo.acessaLocacao,
        onChanged: (value) {},
      )
    ];
  }
}
