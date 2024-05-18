import 'package:flutter/material.dart';

import '../../../Helpers/Controles/Campos/text_field.dart';

class ClienteFormUsuario extends StatefulWidget {
  final TextEditingController? login;
  final TextEditingController? senha;

  @override
  State<ClienteFormUsuario> createState() => _ClienteFormUsuarioState();
  ClienteFormUsuario({this.login, this.senha});
}

class _ClienteFormUsuarioState extends State<ClienteFormUsuario> {
  bool _esconderTexto = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CampoTexto(controller: widget.login!, label: 'Login'),
          SizedBox(height: 20.0),
          CampoTexto(
            controller: widget.senha!,
            validate: true,
            label: 'Senha',
            sufix: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  onPressed: () {
                    setState(() {
                      _esconderTexto = !_esconderTexto;
                    });
                  },
                  icon: Icon(_esconderTexto
                      ? Icons.visibility_off
                      : Icons.visibility)),
            ),
          ),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }
}
