import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gerapp_front/Menu_view/cabecalho_menu.dart';
import 'package:gerapp_front/Menu_view/cadastros_menu.dart';
import 'package:gerapp_front/Menu_view/financeiro_menu.dart';
import 'package:gerapp_front/Menu_view/locacao_menu.dart';

class paginaPrincipal extends StatefulWidget {
  const paginaPrincipal({super.key});

  @override
  State<paginaPrincipal> createState() => _paginaPrincipalState();
}

class _paginaPrincipalState extends State<paginaPrincipal> {
  final Color corFonte = Colors.white;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'GERAPP',
          style: TextStyle(
            color: corFonte,
          ),
        ),
        backgroundColor: Colors.blueAccent,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.shopping_cart,
              color: Colors.white,
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
              'Aqui vai receber algum chart',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        tooltip: 'Converse com um de nossos consultores!',
        child: const Icon(Icons.mail), //share
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
