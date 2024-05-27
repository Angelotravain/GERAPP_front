import 'package:flutter/material.dart';
import 'package:gerapp_front/Helpers/Controles/Campos/text_field.dart';
import 'package:gerapp_front/Helpers/Controles/entrada/show_message.dart';
import 'package:gerapp_front/Helpers/Cores/cores.dart';
import 'package:gerapp_front/Helpers/HttpGeneric.dart';
import 'package:gerapp_front/Helpers/LocalHttp.dart';
import 'package:gerapp_front/Modulos/Cadastro/Funcionario/funcionario_login_model.dart';
import 'package:gerapp_front/Modulos/Cadastro/Funcionario/funcionario_model.dart';
import 'package:gerapp_front/home_view.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _login = TextEditingController();
    TextEditingController _senha = TextEditingController();
    String _retornoDados = '';
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              'https://locadoraequiloc.com.br/wp-content/uploads/2022/10/locacao-de-equipamento-para-construcao-civil-scaled.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_retornoDados),
              Row(
                children: [
                  Icon(Icons.people),
                  SizedBox(width: 10),
                  Expanded(
                    child: CampoTexto(controller: _login, label: 'Login'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Icon(Icons.key),
                  SizedBox(width: 10),
                  Expanded(
                    child: CampoTexto(
                      controller: _senha,
                      label: 'Senha',
                      validate: true,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  var funcionario = await GenericHttp().GetTwoArguments(
                      Local.URL_LOGIN_FUNCIONARIO, _login.text, _senha.text);
                  if (funcionario == null) {
                    ShowMessage.show(
                        context, 'Login ou senha incorretos, tente novamente!');
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaginaPrincipal(
                          funcionario: FuncionarioLoginDto.fromMap(funcionario),
                        ),
                      ),
                    );
                  }
                },
                child: Text('Fazer login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
