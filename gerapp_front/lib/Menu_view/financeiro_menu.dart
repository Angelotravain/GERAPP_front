import 'package:flutter/material.dart';
import 'package:gerapp_front/Modulos/Cadastro/formaDePagamento/forma_pagamento_grid_view.dart';

class FinanceiroMenu extends StatelessWidget {
  const FinanceiroMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ExpansionTile(
        title: Text('Financeiro'),
        children: [
          ListTile(
            title: Text('Contas a receber'),
            leading: Icon(Icons.money),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Formas de pagamento'),
            leading: Icon(Icons.monetization_on),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FormaPagamentoGrid()));
            },
          ),
        ],
      ),
    );
  }
}
