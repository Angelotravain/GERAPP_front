import 'package:flutter/material.dart';
import 'package:gerapp_front/Helpers/Controles/Campos/text_field.dart';

class FuncionarioFormUsuario extends StatefulWidget {
  final TextEditingController? login;
  final TextEditingController? senha;

  @override
  State<FuncionarioFormUsuario> createState() => _funcionarioFormUsuarioState();
  FuncionarioFormUsuario({this.login, this.senha});
}

class _funcionarioFormUsuarioState extends State<FuncionarioFormUsuario> {
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
