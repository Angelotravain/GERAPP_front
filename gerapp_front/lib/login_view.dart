import 'package:flutter/material.dart';
import 'package:gerapp_front/Helpers/Controles/Campos/text_field.dart';
import 'package:gerapp_front/Helpers/Cores/cores.dart';
import 'package:gerapp_front/home_view.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _login = TextEditingController();
    TextEditingController _senha = TextEditingController();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 400.0),
      child: Card(
        elevation: 10,
        shadowColor: Cores.AZUL_FUNDO,
        child: Center(
          child: Column(
            children: [
              Icon(Icons.people),
              CampoTexto(controller: _login, label: 'Login'),
              SizedBox(
                height: 20,
              ),
              Icon(Icons.key),
              CampoTexto(
                controller: _senha,
                label: 'Senha',
                validate: true,
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => paginaPrincipal()));
                  },
                  child: Text('Fazer login')),
            ],
          ),
        ),
      ),
    );
  }
}
