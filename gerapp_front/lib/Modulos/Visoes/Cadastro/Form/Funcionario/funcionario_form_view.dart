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
import 'package:multi_dropdown/multiselect_dropdown.dart';

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
  TextEditingController _imagemfuncionario = TextEditingController();
  List<EnderecoModel> enderecosFuncionario = [];
  TextEditingController _loginUsuarioFuncionario = TextEditingController();
  TextEditingController _senhaUsuarioFuncionario = TextEditingController();
  TextEditingController _logradouroFuncionario = TextEditingController();
  TextEditingController _cepFuncionario = TextEditingController();
  TextEditingController _numeroFuncionario = TextEditingController();
  TextEditingController _complemento = TextEditingController();
  TextEditingController _selecionarCargo = TextEditingController();
  TextEditingController _selecionarEmpresa = TextEditingController();
  TextEditingController _bairroController = TextEditingController();
  TextEditingController idEmpresa = TextEditingController();
  TextEditingController idCargo = TextEditingController();
  TextEditingController idBairro = TextEditingController();

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
                double.parse(_salariofuncionario.text.replaceAll('R\$', '')),
                _imagemfuncionario?.text,
                int.parse(idCargo.text),
                int.parse(idEmpresa.text ?? '0'),
                enderecosFuncionario,
                UsuarioModel(
                    id: 0,
                    login: _loginUsuarioFuncionario!.text,
                    senha: _senhaUsuarioFuncionario!.text,
                    usuarioFuncionarioId: widget.funcionario != null
                        ? widget.funcionario!.id
                        : 0),
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
                selecionarCargo: _selecionarCargo,
                selecionarEmpresa: _selecionarEmpresa,
                funcionario: widget.funcionario,
                idCargo: idCargo,
                idEmpresa: idEmpresa,
              ),
            ),
            Center(
              child: FuncionarioFormEndereco(
                cepFuncionario: _cepFuncionario,
                complemento: _complemento,
                logradouroFuncionario: _logradouroFuncionario,
                numeroFuncionario: _numeroFuncionario,
                enderecoAdicionado: widget.funcionario != null
                    ? widget.funcionario!.enderecoFuncionario
                    : enderecosFuncionario,
                FuncionarioId: widget.funcionario?.id ?? 0,
                bairroController: _bairroController,
                bairroId: idBairro,
              ),
            ),
            Center(
              child: FuncionarioFormUsuario(
                login: _loginUsuarioFuncionario,
                senha: _senhaUsuarioFuncionario,
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
      // _selecionarCargo.text = funcionario.cargoId.toString();
      // _selecionarEmpresa.text = funcionario.empresaId.toString();
      _salariofuncionario.text = funcionario.salario.toString();
      idCargo.text = funcionario.cargoId.toString();
      idEmpresa.text = funcionario.empresaId.toString();
      enderecosFuncionario = funcionario.enderecoFuncionario ?? [];
      _loginUsuarioFuncionario?.text = funcionario.usuarioFuncionario != null
          ? funcionario.usuarioFuncionario!.login
          : '';
      _senhaUsuarioFuncionario?.text = funcionario.usuarioFuncionario != null
          ? funcionario.usuarioFuncionario!.senha
          : '';
    }
  }
}
