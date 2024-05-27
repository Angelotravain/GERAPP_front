import 'package:flutter/material.dart';
import 'package:gerapp_front/Modulos/Cadastro/Empresa/empresa_form_endereco.dart';
import 'package:gerapp_front/Modulos/Cadastro/Empresa/empresa_form_principal.dart';
import 'package:gerapp_front/Modulos/Cadastro/Empresa/empresa_model_novo.dart';
import 'package:gerapp_front/Modulos/Cadastro/Empresa/empresa_repositorio.dart';
import 'package:gerapp_front/Modulos/Cadastro/Endereco/endereco_model.dart';

import '../../../Helpers/Controles/entrada/appbar_cadastros.dart';
import '../../../Helpers/Cores/cores.dart';

class EmpresaForm extends StatefulWidget {
  @override
  final EmpresaModelNovo? empresa;

  @override
  State<EmpresaForm> createState() => _empresaFormState();
  EmpresaForm(this.empresa);
}

class _empresaFormState extends State<EmpresaForm> {
  TextEditingController _nomeEmpresa = TextEditingController();
  TextEditingController _cnpjEmpresa = TextEditingController();
  TextEditingController _estadoEmpresa = TextEditingController();
  TextEditingController _estadoIdEmpresa = TextEditingController();
  TextEditingController _telefoneEmpresa = TextEditingController();
  TextEditingController _emailEmpresa = TextEditingController();
  TextEditingController _webSiteEmpresa = TextEditingController();
  String _dataFundacaoEmpresa = '';
  TextEditingController _ramoAtuacaoEmpresa = TextEditingController();
  TextEditingController _numeroFuncionariosEmpresa = TextEditingController();
  TextEditingController _proprietarioEmpresa = TextEditingController();
  TextEditingController _logoEmpresa = TextEditingController();
  TextEditingController _cepEmpresa = TextEditingController();
  TextEditingController _bairroEmpresa = TextEditingController();
  TextEditingController _complemento = TextEditingController();
  TextEditingController _logradouroempresa = TextEditingController();
  TextEditingController _numeroempresa = TextEditingController();

  bool? _ehFilialEmpresa = false;

  @override
  void initState() {
    super.initState();
    if (widget.empresa != null) PreencherCampos(widget.empresa);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBarCadastros(
          titulo: widget.empresa != null
              ? 'Edite seu empresa!'
              : 'Cadastre seu empresa!',
          funcaoSalvar: () {
            EmpresaRepositorio()
                .salvarEditar(
                  widget.empresa != null ? 'PUT' : 'POST',
                  _nomeEmpresa.text,
                  _logoEmpresa.text,
                  _cnpjEmpresa.text,
                  DateTime.now(),
                  _ehFilialEmpresa,
                  _emailEmpresa.text,
                  EnderecoModel(
                    id: widget.empresa != null
                        ? widget.empresa!.enderecoEmpresa!.id
                        : 0,
                    logradouro: _logradouroempresa.text,
                    numero: _numeroempresa.text,
                    complemento: _complemento.text,
                    cep: _cepEmpresa.text,
                    bairroId: _estadoIdEmpresa.text.isNotEmpty
                        ? int.parse(_estadoIdEmpresa.text)
                        : 0,
                    empresaId: widget.empresa != null
                        ? widget.empresa!.enderecoEmpresa!.id
                        : 0,
                    funcionarioId: 0,
                    clienteId: 0,
                  ),
                  _estadoIdEmpresa.text.isNotEmpty
                      ? int.parse(_estadoIdEmpresa.text)
                      : 0,
                  _numeroFuncionariosEmpresa.text.isNotEmpty
                      ? int.parse(_numeroFuncionariosEmpresa.text)
                      : 0,
                  _proprietarioEmpresa.text.isNotEmpty
                      ? _proprietarioEmpresa.text
                      : null,
                  _ramoAtuacaoEmpresa.text.isNotEmpty
                      ? _ramoAtuacaoEmpresa.text
                      : null,
                  _telefoneEmpresa.text.isNotEmpty ? _telefoneEmpresa.text : '',
                  _webSiteEmpresa.text.isNotEmpty ? _webSiteEmpresa.text : null,
                  widget.empresa,
                )
                .then((value) => Navigator.pop(context));
          },
          icone: widget.empresa != null
              ? Icon(Icons.save_as, color: Cores.BRANCO)
              : Icon(Icons.save, color: Cores.BRANCO),
          toolTipEntrada: widget.empresa != null ? 'Editar' : 'Salvar',
          tipoApp: widget.empresa != null ? 'E' : 'I',
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                height: 55,
                icon: Icon(Icons.people),
                text: 'empresa',
              ),
              Tab(
                height: 55,
                icon: Icon(Icons.streetview),
                text: 'Endereços',
              )
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Center(
              child: EmpresaPrincipalForm(
                nomeEmpresa: _nomeEmpresa,
                cnpjEmpresa: _cnpjEmpresa,
                dataFundacaoEmpresa: _dataFundacaoEmpresa!,
                ehFilialEmpresa: _ehFilialEmpresa,
                emailEmpresa: _emailEmpresa,
                estadoEmpresa: _estadoEmpresa,
                estadoIdEmpresa: _estadoIdEmpresa,
                logoEmpresa: _logoEmpresa,
                numeroFuncionariosEmpresa: _numeroFuncionariosEmpresa,
                proprietarioEmpresa: _proprietarioEmpresa,
                ramoAtuacaoEmpresa: _ramoAtuacaoEmpresa,
                telefoneEmpresa: _telefoneEmpresa,
                webSiteEmpresa: _webSiteEmpresa,
              ),
            ),
            Center(
              child: EmpresaFormEndereco(
                cepEmpresa: _cepEmpresa,
                complemento: _complemento,
                logradouroEmpresa: _logradouroempresa,
                numeroEmpresa: _numeroempresa,
                empresaId: widget.empresa?.id ?? 0,
                bairroId: _estadoIdEmpresa,
                bairroController: _estadoEmpresa,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void PreencherCampos(EmpresaModelNovo? empresa) {
    if (empresa != null) {
      _cnpjEmpresa.text = empresa.cnpj ?? '';
      _dataFundacaoEmpresa =
          empresa.dataFundacao != null ? empresa.dataFundacao!.toString() : '';
      _ehFilialEmpresa = empresa.ehFilial;
      _nomeEmpresa.text = empresa.nome ?? '';
      _emailEmpresa.text = empresa.email ?? '';
      _numeroFuncionariosEmpresa.text =
          empresa.numeroFuncionarios?.toString() ?? '';
      _logoEmpresa.text = empresa.logoEmpresa ?? '';
      _proprietarioEmpresa.text = empresa.proprietario ?? '';
      _ramoAtuacaoEmpresa.text = empresa.ramoAtuacao ?? '';
      _telefoneEmpresa.text = empresa.telefone ?? '';
      _webSiteEmpresa.text = empresa.website ?? '';

      if (empresa.enderecoEmpresa != null) {
        _cepEmpresa.text = empresa.enderecoEmpresa!.cep ?? '';
        _complemento.text = empresa.enderecoEmpresa!.complemento ?? '';
        _bairroEmpresa.text =
            empresa.enderecoEmpresa!.bairroId?.toString() ?? '';
        _logradouroempresa.text = empresa.enderecoEmpresa!.logradouro ?? '';
        _numeroempresa.text = empresa.enderecoEmpresa!.numero ?? '';
      }
    }
  }
}
