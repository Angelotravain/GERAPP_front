import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gerapp_front/Helpers/Controles/entrada/appbar_grid.dart';
import 'package:gerapp_front/Helpers/Controles/entrada/montar_lista.dart';
import 'package:gerapp_front/Helpers/HttpGeneric.dart';
import 'package:gerapp_front/Helpers/LocalHttp.dart';
import 'package:gerapp_front/Modulos/Cadastro/formaDePagamento/forma_pagamento_form_view.dart';
import 'package:gerapp_front/Modulos/Cadastro/formaDePagamento/forma_pagamento_model.dart';

class FormaPagamentoGrid extends StatefulWidget {
  const FormaPagamentoGrid({super.key});

  @override
  State<FormaPagamentoGrid> createState() => _formaPagamentoGridState();
}

class _formaPagamentoGridState extends State<FormaPagamentoGrid> {
  TextEditingController _pesquisa = TextEditingController();
  String? image = '';

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarGrid(
        controller: _pesquisa,
        funcaoAtualizar: () {
          _pesquisa.text = '';
        },
        funcaoRota: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FormaPagamentoForm(
                        formaPagamento: null,
                      ))).then((value) {
            _pesquisa.text = '';
          });
        },
        hintNegativo: 'Sem formaPagamentos para exibir!',
        hintPositivo: 'Pesquise seu formaPagamento!',
        validaHint: true,
      ),
      body: MontaLista(
        apiUrl: Local.URL_FORMA_PAGAMENTO_LISTA,
        controller: _pesquisa,
        deleteFunction: (p0) {
          GenericHttp().Delete(p0, Local.URL_FORMA_PAGAMENTO_EXCLUIR);
        },
        editFunction: (p0) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FormaPagamentoForm(
                        formaPagamento:
                            FormaPagamentoModel.fromJson(json.encode(p0)),
                      ))).then((value) {
            setState(() {
              _pesquisa.text = '';
            });
          });
        },
        title: 'descricao',
        subtitle: '',
      ),
    );
  }
}
