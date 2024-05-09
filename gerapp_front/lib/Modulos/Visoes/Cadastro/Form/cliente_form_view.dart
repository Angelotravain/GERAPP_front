import 'package:flutter/material.dart';
import 'package:gerapp_front/Helpers/Controles/entrada/appbar_cadastros.dart';
import 'package:gerapp_front/Helpers/Cores/cores.dart';
import 'package:gerapp_front/Modulos/Repositorio/Cadastro/cliente_repositorio.dart';
import 'package:gerapp_front/Modulos/Visoes/Cadastro/Form/cliente_form_endereco.dart';
import 'package:gerapp_front/Modulos/Visoes/Cadastro/Form/cliente_form_principal.dart';
import 'package:gerapp_front/Modulos/Visoes/Cadastro/Form/cliente_form_usuario.dart';
import 'package:gerapp_front/Modulos/modelos/Cadastro/Cliente_model.dart';
import 'package:gerapp_front/Modulos/modelos/Cadastro/endereco_model.dart';
import 'package:gerapp_front/Modulos/modelos/Cadastro/usuario_model.dart';
import 'package:intl/intl.dart';

class ClienteForm extends StatefulWidget {
  @override
  final ClienteModel? cliente;

  @override
  State<ClienteForm> createState() => _ClienteFormState();
  ClienteForm(this.cliente);
}

class _ClienteFormState extends State<ClienteForm> {
  TextEditingController _nomeCliente = TextEditingController();
  TextEditingController _cpfCliente = TextEditingController();
  DateTime? _dataNascimento;
  TextEditingController _emailCliente = TextEditingController();
  TextEditingController _telefoneCliente = TextEditingController();
  TextEditingController _nomeMae = TextEditingController();
  bool? statusCliente;
  TextEditingController _nomePai = TextEditingController();
  TextEditingController _nomeConjugue = TextEditingController();
  TextEditingController _imagemCliente = TextEditingController();
  List<EnderecoModel> enderecosCliente = [];
  final TextEditingController? _loginUsuarioCliente = TextEditingController();
  final TextEditingController? _senhaUsuarioCliente = TextEditingController();
  final TextEditingController? _logradouroCliente = TextEditingController();
  final TextEditingController? _cepCliente = TextEditingController();
  final TextEditingController? _numeroCliente = TextEditingController();
  final TextEditingController? _complemento = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.people),
                text: 'Cliente',
              ),
              Tab(
                icon: Icon(Icons.streetview),
                text: 'Endereços',
              ),
              Tab(
                icon: Icon(Icons.password),
                text: 'Usuário',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Center(
              child: ClientePrincipalForm(),
            ),
            Center(
              child: ClienteFormEndereco(
                tipoCombo: 'B',
                cepCliente: _cepCliente,
                complemento: _complemento,
                logradouroCliente: _logradouroCliente,
                numeroCliente: _numeroCliente,
              ),
            ),
            Center(
              child: ClienteFormUsuario(
                login: _loginUsuarioCliente,
                senha: _senhaUsuarioCliente,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
