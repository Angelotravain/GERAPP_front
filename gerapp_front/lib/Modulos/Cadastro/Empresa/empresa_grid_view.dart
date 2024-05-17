import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gerapp_front/Helpers/Controles/entrada/appbar_grid.dart';
import 'package:gerapp_front/Modulos/Cadastro/Empresa/empresa_repositorio.dart';

import '../../../Helpers/Controles/entrada/montar_lista.dart';
import '../../../Helpers/LocalHttp.dart';
import 'empresa_form_view.dart';
import 'empresa_model.dart';

class EmpresaGrid extends StatefulWidget {
  EmpresaGrid({Key? key}) : super(key: key);
  @override
  State<EmpresaGrid> createState() => _EmpresaGridState();
}

class _EmpresaGridState extends State<EmpresaGrid> {
  void atualizarEstado() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _buscarTodosOsempresas();
    //_pollingBuscarempresas();
  }

  TextEditingController _pesquisa = TextEditingController();
  List<EmpresaModel> _empresas = [];
  List<EmpresaModel> _filtrados = [];

  void _buscarTodosOsempresas() async {
    List<EmpresaModel> empresas = await EmpresaRepositorio().GetAllEmpresas();
    if (mounted) {
      setState(() {
        _empresas = empresas;
        if (_filtrados.isEmpty && _pesquisa.text == '') {
          _filtrados = empresas;
        }
      });
    }
  }

  void _pollingBuscarempresas() {
    const duration = Duration(seconds: 0);
    Timer.periodic(duration, (Timer timer) {
      if (mounted) {
        _buscarTodosOsempresas();
        _filtrarPorPesquisa(_pesquisa.text);
      }
    });
  }

  void _filtrarPorPesquisa(String filtro) {
    if (filtro != null || filtro != '') {
      setState(() {
        List<EmpresaModel> empresaFiltrado = _empresas
            .where((x) => x.nome.toLowerCase().contains(filtro.toLowerCase()))
            .toList();

        _filtrados = empresaFiltrado;
      });
    } else {
      if (mounted) {
        setState(() {
          _filtrados = _empresas;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarGrid(
          funcaoRota: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EmpresaForm(null)),
            ).then((value) {
              if (mounted) {
                _buscarTodosOsempresas();
              }
            });
          },
          funcaoAtualizar: () {
            if (mounted) {
              _filtrarPorPesquisa(_pesquisa.text);
            }
          },
          validaHint: _filtrados.isNotEmpty,
          hintPositivo: 'Pesquise seu empresa!',
          hintNegativo: 'Sem empresas!',
          controller: _pesquisa,
        ),
        body: MontaLista(
          apiUrl: '${Local.localName}/api/Gerapp/Cadastro/ListarEmpresas',
          title: 'nome',
          subtitle: 'proprietario',
          controller: _pesquisa,
          deleteFunction: (p0) {
            EmpresaRepositorio().deleteEmpresa(p0);
          },
          editFunction: (p0) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EmpresaForm(EmpresaModel.fromMap(p0))),
            ).then((value) {
              if (mounted) {
                _buscarTodosOsempresas();
              }
            });
          },
        ));
  }
}
