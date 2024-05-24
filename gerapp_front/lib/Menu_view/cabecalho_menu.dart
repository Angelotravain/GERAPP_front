import 'package:flutter/material.dart';

import '../Helpers/conversor.dart';

class CabecalhoMenu extends StatefulWidget {
  String? nome;
  String? imagem;
  CabecalhoMenu({super.key, this.nome, this.imagem});

  @override
  State<CabecalhoMenu> createState() => _CabecalhoMenuState();
}

class _CabecalhoMenuState extends State<CabecalhoMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: UserAccountsDrawerHeader(
        accountEmail: null,
        accountName: Text(widget.nome!),
        currentAccountPicture: CircleAvatar(
          backgroundImage: widget.imagem != null
              ? Conversor.convertBase64ToImage(widget.imagem!)
              : NetworkImage(
                  'https://www.google.com/imgres?q=perfil&imgurl=https%3A%2F%2Fcdn-icons-png.flaticon.com%2F512%2F3135%2F3135768.png&imgrefurl=https%3A%2F%2Fwww.flaticon.com%2Fbr%2Ficone-gratis%2Fperfil_3135768&docid=FCPgfpoJSQcmUM&tbnid=xW-dVyjmcfgAJM&vet=12ahUKEwjM4JLDxaaGAxUqgWEGHXepDNcQM3oECFIQAA..i&w=512&h=512&hcb=2&ved=2ahUKEwjM4JLDxaaGAxUqgWEGHXepDNcQM3oECFIQAA'),
        ),
      ),
    );
  }
}
