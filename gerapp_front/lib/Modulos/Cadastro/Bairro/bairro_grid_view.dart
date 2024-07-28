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
    setState(() {
      _pesquisa.text = '';
    });
  }

  @override
  void initState() {}

  TextEditingController _pesquisa = TextEditingController();

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
            _pesquisa.text = '';
          });
        },
        funcaoAtualizar: () {
          _pesquisa.text = '';
        },
        validaHint: true,
        hintPositivo: 'Pesquise seu bairro!',
        hintNegativo: 'Sem bairros!',
        controller: _pesquisa,
      ),
      body: MontaLista(
        apiUrl: Local.URL_BAIRRO,
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
            setState(() {
              _pesquisa.clear();
            });
          });
        },
      ),
    );
  }
}
