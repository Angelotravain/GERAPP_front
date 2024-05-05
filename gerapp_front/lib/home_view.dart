import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gerapp_front/Helpers/Cores/cores.dart';
import 'package:gerapp_front/Helpers/generic.dart';
import 'package:gerapp_front/Menu_view/cabecalho_menu.dart';
import 'package:gerapp_front/Menu_view/cadastros_menu.dart';
import 'package:gerapp_front/Menu_view/financeiro_menu.dart';
import 'package:gerapp_front/Menu_view/locacao_menu.dart';
import 'package:gerapp_front/Modulos/modelos/Cadastro/bairro_model.dart';

class paginaPrincipal extends StatefulWidget {
  const paginaPrincipal({super.key});

  @override
  State<paginaPrincipal> createState() => _paginaPrincipalState();
}

class _paginaPrincipalState extends State<paginaPrincipal> {
  final bool validaAppBar = true;

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
          IconButton(
            icon: const Icon(
              Icons.shopping_cart,
              color: Cores.BRANCO,
            ),
            tooltip: 'Vá para o carrinho de agendamento',
            onPressed: () {
              // handle the press
            },
            alignment: Alignment.centerRight,
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            CabecalhoMenu(),
            Column(
              children: [
                CadastrosMenu(),
                FinanceiroMenu(),
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
            const Text(
              'Ola',
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
