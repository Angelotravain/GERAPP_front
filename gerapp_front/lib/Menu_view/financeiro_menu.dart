import 'package:flutter/material.dart';

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
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
