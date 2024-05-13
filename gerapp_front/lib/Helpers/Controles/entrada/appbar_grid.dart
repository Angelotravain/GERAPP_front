import 'package:flutter/material.dart';
import 'package:gerapp_front/Helpers/Cores/cores.dart';

class AppBarGrid extends StatelessWidget implements PreferredSizeWidget {
  final void Function()? funcaoRota;
  final void Function()? funcaoAtualizar;
  final bool? validaHint;
  final String? hintPositivo;
  final String? hintNegativo;
  final TextEditingController? controller;

  const AppBarGrid({
    this.controller,
    super.key,
    this.funcaoRota,
    this.funcaoAtualizar,
    this.validaHint,
    this.hintPositivo,
    this.hintNegativo,
  });

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: kToolbarHeight + 70,
      backgroundColor: Cores.AZUL_FUNDO,
      title: Padding(
        padding: const EdgeInsets.only(left: 15.0, top: 28),
        child: TextFormField(
          controller: controller,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto',
            color: Cores.PRETO,
          ),
          onChanged: (value) {
            if (value.length >= 1) funcaoAtualizar;
          },
          decoration: InputDecoration(
            labelText: validaHint == true ? hintPositivo : hintNegativo,
            fillColor: Cores.BRANCO,
            filled: true,
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Cores.PRETO),
              borderRadius: BorderRadius.circular(15.0),
            ),
            contentPadding:
                EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            labelStyle: TextStyle(color: Cores.PRETO),
          ),
          maxLength: 80,
        ),
      ),
      actions: [
        Card(
          color: Cores.AZUL_FUNDO,
          child: IconButton(
            onPressed: funcaoAtualizar,
            icon: Icon(
              Icons.search,
              color: Cores.BRANCO,
            ),
            tooltip: 'Pesquisar',
          ),
        ),
        Card(
          color: Cores.AZUL_FUNDO,
          child: IconButton(
            onPressed: funcaoRota,
            icon: Icon(
              Icons.add,
              color: Cores.BRANCO,
            ),
            tooltip: 'Adicionar',
          ),
        ),
      ],
    );
  }
}
