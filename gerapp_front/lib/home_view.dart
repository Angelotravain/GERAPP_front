import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gerapp_front/Helpers/Controles/entrada/campo_toogle.dart';
import 'package:gerapp_front/Helpers/Cores/cores.dart';
import 'package:gerapp_front/Menu_view/cabecalho_menu.dart';
import 'package:gerapp_front/Menu_view/cadastros_menu.dart';
import 'package:gerapp_front/Menu_view/financeiro_menu.dart';
import 'package:gerapp_front/Menu_view/locacao_menu.dart';
import 'package:gerapp_front/Modulos/Cadastro/Funcionario/funcionario_login_model.dart';

class PaginaPrincipal extends StatefulWidget {
  final FuncionarioLoginDto funcionario;
  const PaginaPrincipal({super.key, required this.funcionario});

  @override
  State<PaginaPrincipal> createState() => _paginaPrincipalState();
}

class _paginaPrincipalState extends State<PaginaPrincipal> {
  final bool validaAppBar = true;
  String _nomeFuncionario = '';
  String _imagemFuncionario = '';
  @override
  void initState() {
    _nomeFuncionario =
        '${widget.funcionario!.nome} - ${widget.funcionario.descricao}';
    _imagemFuncionario = widget.funcionario!.imagem;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'GERAPP',
          style: TextStyle(
            color: Cores.BRANCO,
          ),
        ),
        backgroundColor: Cores.AZUL_FUNDO,
        actions: <Widget>[
          SizedBox(
            width: 20,
          ),
          IconButton(
            icon: const Icon(
              Icons.shopping_cart,
              color: Cores.BRANCO,
            ),
            tooltip: 'Vá para o carrinho de agendamento',
            onPressed: () {},
            alignment: Alignment.centerRight,
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            CabecalhoMenu(
              nome: _nomeFuncionario ?? null,
              imagem: _imagemFuncionario ?? null,
            ),
            Column(
              children: [
                if (widget.funcionario != null &&
                    widget.funcionario.acessaCadastro == true)
                  CadastrosMenu(),
                if (widget.funcionario != null &&
                    widget.funcionario.acessaFinanceiro == true)
                  FinanceiroMenu(),
                if (widget.funcionario != null &&
                    widget.funcionario.acessaLocacao == true)
                  LocacaoMenu(),
              ],
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Olá ${widget.funcionario.nome}, bem-vindo ao sistema GERAPP',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        tooltip: 'Converse com um de nossos consultores!',
        child: const Icon(Icons.mail), //share
      ),
    );
  }
}
