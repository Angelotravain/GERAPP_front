import 'package:flutter/material.dart';

class CabecalhoMenu extends StatefulWidget {
  const CabecalhoMenu({super.key});

  @override
  State<CabecalhoMenu> createState() => _CabecalhoMenuState();
}

class _CabecalhoMenuState extends State<CabecalhoMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: UserAccountsDrawerHeader(
        accountEmail: null,
        accountName: Text("Seu zé - Gerente"),
        currentAccountPicture: CircleAvatar(
          child: Text('SZ'),
        ),
      ),
    );
  }
}
