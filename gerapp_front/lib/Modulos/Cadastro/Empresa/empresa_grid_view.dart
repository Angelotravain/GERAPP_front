import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gerapp_front/Helpers/Controles/entrada/appbar_grid.dart';
import 'package:gerapp_front/Helpers/HttpGeneric.dart';
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
  TextEditingController _pesquisa = TextEditingController();

  void _filtrarPorPesquisa(String filtro) {
    if (filtro != '') {
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
              MaterialPageRoute(builder: (context) => EmpresaForm(null)),
            ).then((value) {
              setState(() {
                _pesquisa.text = '';
              });
            });
          },
          funcaoAtualizar: () {
            _filtrarPorPesquisa(_pesquisa.text);
          },
          validaHint: true,
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
            GenericHttp().Delete(p0, Local.URL_DELETE_EMPRESA);
          },
          editFunction: (p0) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EmpresaForm(EmpresaModel.fromMap(p0))),
            ).then((value) {
              setState(() {
                _pesquisa.text = '';
              });
            });
          },
        ));
  }
}
