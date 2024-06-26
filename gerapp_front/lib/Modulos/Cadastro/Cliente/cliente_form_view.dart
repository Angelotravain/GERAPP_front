import 'package:flutter/material.dart';
import 'package:gerapp_front/Helpers/Controles/entrada/show_message.dart';
import 'package:gerapp_front/Modulos/Cadastro/Cliente/cliente_form_endereco.dart';
import 'package:gerapp_front/Modulos/Cadastro/Cliente/cliente_form_principal.dart';
import 'package:gerapp_front/Modulos/Cadastro/Cliente/cliente_form_usuario.dart';
import 'package:gerapp_front/Modulos/Cadastro/Cliente/cliente_repositorio.dart';

import '../../../Helpers/Controles/entrada/appbar_cadastros.dart';
import '../../../Helpers/Cores/cores.dart';
import '../Endereco/endereco_model.dart';
import '../Usuario/usuario_model.dart';
import 'cliente_model.dart';

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
  DateTime _dataNascimento = DateTime.now();
  TextEditingController _emailCliente = TextEditingController();
  TextEditingController _telefoneCliente = TextEditingController();
  TextEditingController _nomeMae = TextEditingController();
  bool _statusCliente = true;
  TextEditingController _nomePai = TextEditingController();
  TextEditingController _nomeConjugue = TextEditingController();
  TextEditingController _imagemCliente = TextEditingController();
  List<EnderecoModel> enderecosCliente = [];
  TextEditingController _loginUsuarioCliente = TextEditingController();
  TextEditingController _senhaUsuarioCliente = TextEditingController();
  TextEditingController _logradouroCliente = TextEditingController();
  TextEditingController _cepCliente = TextEditingController();
  TextEditingController _numeroCliente = TextEditingController();
  TextEditingController _complemento = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.cliente != null) {
      print("Cliente não é nulo: ${widget.cliente}");
      PreencherCampos(widget.cliente!);
    } else {
      print("Cliente é nulo");
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBarCadastros(
          titulo: widget.cliente != null
              ? 'Edite seu cliente!'
              : 'Cadastre seu cliente!',
          funcaoSalvar: () {
            if (_nomeCliente.text.isEmpty) {
              ShowMessage.show(
                  context, 'Preencha o Nome do cliente para prosseguir!');
            } else if (_emailCliente.text.isEmpty) {
              ShowMessage.show(
                  context, 'Preencha o e-mail do cliente para prosseguir!');
            } else if (_loginUsuarioCliente.text.isEmpty) {
              ShowMessage.show(
                  context, 'Preencha o login do cliente para prosseguir!');
            } else if (_senhaUsuarioCliente.text.isEmpty) {
              ShowMessage.show(
                  context, 'Preencha a senha do cliente para prosseguir!');
            } else if (enderecosCliente.isEmpty) {
              ShowMessage.show(context,
                  'O cliente deve ter ao menos um endereço cadastrado!');
            } else {
              ClienteRepositorio()
                  .salvarEditar(
                    widget.cliente != null ? 'PUT' : 'POST',
                    _nomeCliente.text,
                    _cpfCliente.text,
                    _dataNascimento ?? DateTime.now(),
                    _emailCliente.text,
                    _telefoneCliente.text,
                    _nomeMae.text,
                    _statusCliente,
                    _nomePai.text,
                    _nomeConjugue.text,
                    _imagemCliente.text,
                    enderecosCliente,
                    UsuarioModel(
                      id: widget.cliente?.usuario!.id ?? 0,
                      login: _loginUsuarioCliente.text,
                      senha: _senhaUsuarioCliente.text,
                      usuarioClienteId: widget.cliente?.id ?? 0,
                    ),
                    widget.cliente,
                  )
                  .then((value) => Navigator.pop(context));
            }
          },
          icone: widget.cliente != null
              ? Icon(Icons.save_as, color: Cores.BRANCO)
              : Icon(Icons.save, color: Cores.BRANCO),
          toolTipEntrada: widget.cliente != null ? 'Editar' : 'Salvar',
          tipoApp: widget.cliente != null ? 'E' : 'I',
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                height: 55,
                icon: Icon(Icons.people),
                text: 'Cliente',
              ),
              Tab(
                height: 55,
                icon: Icon(Icons.streetview),
                text: 'Endereços',
              ),
              Tab(
                height: 55,
                icon: Icon(Icons.password),
                text: 'Usuário',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Center(
              child: ClientePrincipalForm(
                nome: _nomeCliente,
                cpf: _cpfCliente,
                email: _emailCliente,
                nomeConjugue: _nomeConjugue,
                nomeMae: _nomeMae,
                imagem: _imagemCliente,
                nomePai: _nomePai,
                dataNascimento: _dataNascimento,
                telefone: _telefoneCliente,
                statusCliente: _statusCliente,
              ),
            ),
            Center(
              child: ClienteFormEndereco(
                tipoCombo: 'B',
                cepCliente: _cepCliente,
                complemento: _complemento,
                logradouroCliente: _logradouroCliente,
                numeroCliente: _numeroCliente,
                enderecoAdicionado: enderecosCliente,
                clienteId: widget.cliente?.id ??
                    0, // Fornece 0 como valor padrão se cliente for nulo
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

  void PreencherCampos(ClienteModel? cliente) {
    enderecosCliente = [];
    if (cliente != null) {
      print("Preenchendo campos para o cliente: $cliente");
      _nomeCliente.text = cliente.nome ?? '';
      _cpfCliente.text = cliente.cpf ?? '';
      _dataNascimento = cliente.dataNascimento ?? DateTime.now();
      _emailCliente.text = cliente.email ?? '';
      _telefoneCliente.text = cliente.telefone ?? '';
      _nomeMae.text = cliente.nomeMae ?? '';
      _statusCliente = cliente.statusCliente ?? true;
      _nomePai.text = cliente.nomePai ?? '';
      _nomeConjugue.text = cliente.nomeConjugue ?? '';
      _imagemCliente.text = cliente.imagem ?? '';
      enderecosCliente = cliente.endereco ?? [];
      _loginUsuarioCliente.text = cliente.usuario?.login ?? '';
      _senhaUsuarioCliente.text = cliente.usuario?.senha ?? '';
    } else {
      print("Cliente é nulo em PreencherCampos");
    }
  }
}
