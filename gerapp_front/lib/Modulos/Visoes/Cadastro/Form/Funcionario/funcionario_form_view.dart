import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gerapp_front/Helpers/Controles/entrada/appbar_cadastros.dart';
import 'package:gerapp_front/Helpers/Cores/cores.dart';
import 'package:gerapp_front/Modulos/Repositorio/Cadastro/funcionario_repositorio.dart';
import 'package:gerapp_front/Modulos/Visoes/Cadastro/Form/Funcionario/funcionario_form_endereco.dart';
import 'package:gerapp_front/Modulos/Visoes/Cadastro/Form/Funcionario/funcionario_form_principal.dart';
import 'package:gerapp_front/Modulos/Visoes/Cadastro/Form/Funcionario/funcionario_form_usuario.dart';
import 'package:gerapp_front/Modulos/modelos/Cadastro/funcionario_model.dart';
import 'package:gerapp_front/Modulos/modelos/Cadastro/endereco_model.dart';
import 'package:gerapp_front/Modulos/modelos/Cadastro/usuario_model.dart';
import 'package:intl/intl.dart';

class FuncionarioForm extends StatefulWidget {
  @override
  final FuncionarioModel? funcionario;

  @override
  State<FuncionarioForm> createState() => _funcionarioFormState();
  FuncionarioForm(this.funcionario);
}

class _funcionarioFormState extends State<FuncionarioForm> {
  TextEditingController _nomefuncionario = TextEditingController();
  TextEditingController _salariofuncionario = TextEditingController();
  final TextEditingController? _imagemfuncionario = TextEditingController();
  List<EnderecoModel> enderecosFuncionario = [];
  final TextEditingController? _loginUsuariofuncionario =
      TextEditingController();
  final TextEditingController? _senhaUsuariofuncionario =
      TextEditingController();
  final TextEditingController? _logradourofuncionario = TextEditingController();
  final TextEditingController? _cepfuncionario = TextEditingController();
  final TextEditingController? _numerofuncionario = TextEditingController();
  final TextEditingController? _complemento = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    PreencherCampos(widget.funcionario ?? null);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBarCadastros(
          titulo: widget.funcionario != null
              ? 'Edite seu funcionario!'
              : 'Cadastre seu funcionario!',
          funcaoSalvar: () {
            FuncionarioRepositorio().salvarEditar(
                widget.funcionario != null ? 'PUT' : 'POST',
                _nomefuncionario.text,
                double.parse(_salariofuncionario.text),
                _imagemfuncionario?.text,
                0,
                0,
                enderecosFuncionario,
                UsuarioModel(
                    id: 0,
                    login: _loginUsuariofuncionario!.text,
                    senha: _senhaUsuariofuncionario!.text,
                    usuarioFuncionarioId: widget.funcionario!.id),
                widget.funcionario);

            Navigator.pop(context);
          },
          icone: widget.funcionario != null
              ? Icon(Icons.save_as, color: Cores.BRANCO)
              : Icon(Icons.save, color: Cores.BRANCO),
          toolTipEntrada: widget.funcionario != null ? 'Editar' : 'Salvar',
          tipoApp: widget.funcionario != null ? 'E' : 'I',
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                height: 55,
                icon: Icon(Icons.people),
                text: 'funcionario',
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
              child: FuncionarioPrincipalForm(
                nome: _nomefuncionario,
                imagem: _imagemfuncionario,
                salario: _salariofuncionario,
              ),
            ),
            Center(
              child: FuncionarioFormEndereco(
                tipoCombo: 'B',
                cepfuncionario: _cepfuncionario,
                complemento: _complemento,
                logradourofuncionario: _logradourofuncionario,
                numerofuncionario: _numerofuncionario,
                enderecoAdicionado: widget.funcionario != null
                    ? widget.funcionario!.enderecoFuncionario
                    : [],
                funcionarioId: widget.funcionario!.id,
              ),
            ),
            Center(
              child: FuncionarioFormUsuario(
                login: _loginUsuariofuncionario,
                senha: _senhaUsuariofuncionario,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void PreencherCampos(FuncionarioModel? funcionario) {
    if (funcionario != null) {
      _nomefuncionario.text = funcionario.nome;
      _imagemfuncionario!.text = funcionario.imagem;
      _salariofuncionario.text = funcionario.salario.toString();
      enderecosFuncionario = funcionario.enderecoFuncionario ?? [];
      _loginUsuariofuncionario?.text = funcionario.usuarioFuncionario != null
          ? funcionario.usuarioFuncionario!.login
          : '';
      _senhaUsuariofuncionario?.text = funcionario.usuarioFuncionario != null
          ? funcionario.usuarioFuncionario!.senha
          : '';
    }
  }
}
