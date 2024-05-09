import 'package:flutter/material.dart';

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
          TextFormField(
            controller: widget.login,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
            ),
            decoration: InputDecoration(
                hintText: 'Login',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0))),
          ),
          SizedBox(height: 20.0),
          TextFormField(
            controller: widget.senha,
            obscureText: _esconderTexto,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
            ),
            decoration: InputDecoration(
                hintText: 'Senha',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                suffixIcon: Padding(
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
                )),
          ),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }
}
