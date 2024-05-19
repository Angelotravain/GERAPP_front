import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gerapp_front/Helpers/Controles/entrada/appbar_grid.dart';
import 'package:gerapp_front/Helpers/Controles/entrada/montar_lista.dart';
import 'package:gerapp_front/Helpers/Cores/cores.dart';
import 'package:gerapp_front/Helpers/LocalHttp.dart';
import 'package:gerapp_front/Helpers/conversor.dart';
import 'package:gerapp_front/Modulos/Cadastro/Funcionario/funcionario_repositorio.dart';
import 'package:gerapp_front/Modulos/Cadastro/Funcionario/funcionario_form_view.dart';
import 'package:gerapp_front/Modulos/Cadastro/Funcionario/funcionario_model.dart';

class FuncionarioGrid extends StatefulWidget {
  const FuncionarioGrid({super.key});

  @override
  State<FuncionarioGrid> createState() => _funcionarioGridState();
}

class _funcionarioGridState extends State<FuncionarioGrid> {
  TextEditingController _pesquisa = TextEditingController();
  List<FuncionarioModel> _funcionarios = [];
  List<FuncionarioModel> _filtrados = [];
  String? image = '';

  @override
  void initState() {
    _buscarTodosOsFuncionarios();
    _pollingBuscarfuncionarios();
  }

  void _pollingBuscarfuncionarios() {
    const duration = Duration(seconds: 0);
    Timer.periodic(duration, (Timer timer) {
      _buscarTodosOsFuncionarios();
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
                  builder: (context) => FuncionarioForm(null))).then((value) {
            _buscarTodosOsFuncionarios();
          });
        },
        hintNegativo: 'Sem Funcionarios para exibir!',
        hintPositivo: 'Pesquise seu Funcionario!',
        validaHint: _filtrados.isNotEmpty,
      ),
      body: MontaLista(
        apiUrl: Local.URL_FUNCIONARIO,
        controller: _pesquisa,
        deleteFunction: (p0) {
          FuncionarioRepositorio().deleteFuncionario(p0);
        },
        editFunction: (p0) {
          Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          FuncionarioForm(FuncionarioModel.fromMap(p0))))
              .then((value) {
            setState(() {
              _buscarTodosOsFuncionarios();
            });
          });
        },
        title: 'nome',
        subtitle: '',
      ),
    );
  }

  void _filtrarPorPesquisa(String filtro) {
    if (filtro != '') {
      setState(() {
        List<FuncionarioModel> funcionarioFiltrado = _funcionarios
            .where((x) =>
                x.nome != '' &&
                x.nome!.toLowerCase().contains(filtro.toLowerCase()))
            .toList();

        _filtrados = funcionarioFiltrado;
      });
    } else {
      setState(() {
        _filtrados = _funcionarios;
      });
    }
  }

  void _buscarTodosOsFuncionarios() async {
    List<FuncionarioModel>? funcionarios =
        await FuncionarioRepositorio().GetAllFuncionarios();
    setState(() {
      _funcionarios = funcionarios ?? [];
      if (_filtrados.isEmpty && _pesquisa.text == '') {
        _filtrados = _funcionarios;
      }
    });
  }
}
