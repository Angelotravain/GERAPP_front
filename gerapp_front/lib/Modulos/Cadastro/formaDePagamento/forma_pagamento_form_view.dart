import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gerapp_front/Helpers/Controles/Campos/text_field.dart';
import 'package:gerapp_front/Helpers/Controles/entrada/campo_toogle.dart';
import 'package:gerapp_front/Helpers/Cores/cores.dart';
import 'package:gerapp_front/Modulos/Cadastro/formaDePagamento/forma_pagamento_model.dart';

import '../../../Helpers/Controles/entrada/appbar_cadastros.dart';
import '../../../Helpers/HttpGeneric.dart';
import '../../../Helpers/LocalHttp.dart';

class FormaPagamentoForm extends StatefulWidget {
  FormaPagamentoModel? formaPagamento;

  FormaPagamentoForm({this.formaPagamento});

  @override
  State<FormaPagamentoForm> createState() =>
      _formaPagamentoPrincipalFormState();
}

class _formaPagamentoPrincipalFormState extends State<FormaPagamentoForm> {
  TextEditingController _descricao = TextEditingController();
  bool _ehCredito = false;
  bool _ehDebito = false;
  bool _ehAvista = false;
  bool _ehAprazo = false;

  @override
  initState() {
    if (widget.formaPagamento != null) PreencherCampos(widget.formaPagamento);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarCadastros(
          titulo: widget.formaPagamento != null
              ? 'Edite seu formaPagamento!'
              : 'Cadastre seu formaPagamento!',
          funcaoSalvar: () {
            widget.formaPagamento != null
                ? GenericHttp().Editar(
                    widget.formaPagamento!.id,
                    jsonEncode(
                      FormaPagamentoModel(
                          id: 0,
                          descricao: _descricao.text,
                          ehAvista: _ehAvista,
                          ehCredito: _ehCredito,
                          ehDebito: _ehDebito,
                          ehPrazo: _ehAprazo),
                    ),
                    Local.URL_FORMA_PAGAMENTO_EDITAR)
                : GenericHttp().Salvar(
                    jsonEncode(FormaPagamentoModel(
                        id: 0,
                        descricao: _descricao.text,
                        ehAvista: _ehAvista,
                        ehCredito: _ehCredito,
                        ehDebito: _ehDebito,
                        ehPrazo: _ehAprazo)),
                    Local.URL_FORMA_PAGAMENTO_SALVAR);
            Navigator.pop(context);
          },
          tipoApp: widget.formaPagamento != null ? 'E' : 'I',
          icone: widget.formaPagamento != null
              ? Icon(Icons.save_as, color: Cores.BRANCO)
              : Icon(Icons.save, color: Cores.BRANCO),
          toolTipEntrada: widget.formaPagamento != null ? 'Editar' : 'Salvar',
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              CampoTexto(
                controller: _descricao,
                label: 'Descricao',
              ),
              ToogleSelecao(
                  label: 'Tipo de pagamento é Prazo?',
                  value: _ehAprazo,
                  onChanged: (value) {
                    setState(() {
                      _ehAprazo = value;
                      _ehCredito = _ehCredito != false ? !value : false;
                      _ehAvista = _ehCredito != false ? !value : false;
                      _ehDebito = _ehCredito != false ? !value : false;
                    });
                  }),
              ToogleSelecao(
                  label: 'Tipo de pagamento é Crédito?',
                  value: _ehCredito,
                  onChanged: (value) {
                    setState(() {
                      _ehAprazo = _ehAprazo != false ? !value : false;
                      _ehCredito = value;
                      _ehAvista = _ehCredito != false ? !value : false;
                      _ehDebito = _ehCredito != false ? !value : false;
                    });
                  }),
              ToogleSelecao(
                  label: 'Tipo de pagamento é A vista?',
                  value: _ehAvista,
                  onChanged: (value) {
                    setState(() {
                      _ehAprazo = _ehAprazo != false ? !value : false;
                      _ehCredito = _ehCredito != false ? !value : false;
                      _ehAvista = value;
                      _ehDebito = _ehCredito != false ? !value : false;
                    });
                  }),
              ToogleSelecao(
                  label: 'Tipo de pagamento é débito?',
                  value: _ehDebito,
                  onChanged: (value) {
                    setState(() {
                      _ehAprazo = _ehAprazo != false ? !value : false;
                      _ehCredito = _ehCredito != false ? !value : false;
                      _ehAvista = _ehCredito != false ? !value : false;
                      _ehDebito = value;
                    });
                  }),
            ],
          ),
        ));
  }

  void PreencherCampos(FormaPagamentoModel? formaPagamento) {
    if (formaPagamento != null) {
      _descricao.text = formaPagamento.descricao!;
      _ehAprazo = formaPagamento.ehPrazo ?? false;
      _ehAvista = formaPagamento.ehAvista ?? false;
      _ehCredito = formaPagamento.ehCredito ?? false;
      _ehDebito = formaPagamento.ehDebito ?? false;
    }
  }
}
