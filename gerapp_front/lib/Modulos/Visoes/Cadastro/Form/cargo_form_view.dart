import 'package:flutter/material.dart';
import 'package:gerapp_front/Helpers/Controles/Campos/text_field.dart';
import 'package:gerapp_front/Helpers/Controles/entrada/appbar_cadastros.dart';
import 'package:gerapp_front/Helpers/Controles/entrada/campo_toogle.dart';
import 'package:gerapp_front/Helpers/Cores/cores.dart';
import 'package:gerapp_front/Modulos/Repositorio/Cadastro/cargo_repositorio.dart';
import 'package:gerapp_front/Modulos/modelos/Cadastro/cargo_model.dart';

class CargoForm extends StatefulWidget {
  @override
  final CargoModel? cargo;

  _CargoScreenState createState() => _CargoScreenState();
  CargoForm(this.cargo);
}

class _CargoScreenState extends State<CargoForm> {
  bool _acessaAuditoria = false;
  bool _acessaCadastro = false;
  bool _acessaConfiguracao = false;
  bool _acessaFinanceiro = false;
  bool _acessaLocacao = false;
  bool _gerarCadastro = false;
  TextEditingController _descricaoController = TextEditingController();

  @override
  void initState() {
    _PreencheCampos(widget.cargo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCadastros(
        titulo:
            widget.cargo != null ? 'Edite seu cargo!' : 'Cadastre seu cargo!',
        funcaoSalvar: () {
          CargoRepositorio().salvarEditar(
              widget.cargo != null ? 'PUT' : 'POST',
              _descricaoController.text,
              _acessaAuditoria!,
              _acessaCadastro!,
              _acessaConfiguracao!,
              _acessaFinanceiro!,
              _acessaLocacao!,
              _gerarCadastro!,
              widget.cargo != null ? widget.cargo : null);
          Navigator.pop(context);
        },
        tipoApp: widget.cargo != null ? 'E' : 'I',
        icone: widget.cargo != null
            ? Icon(Icons.save_as, color: Cores.BRANCO)
            : Icon(Icons.save, color: Cores.BRANCO),
        toolTipEntrada: widget.cargo != null ? 'Editar' : 'Salvar',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 20,
          ),
          CampoTexto(
            controller: _descricaoController,
            label: 'Descrição do Cargo',
          ),
          SizedBox(height: 20.0),
          ToogleSelecao(
              label: 'Acessa Auditoria',
              value: _acessaAuditoria,
              onChanged: (value) {
                setState(() {
                  _acessaAuditoria = value;
                });
              }),
          ToogleSelecao(
              label: 'Acessa Cadastro',
              value: _acessaCadastro,
              onChanged: (value) {
                setState(() {
                  _acessaCadastro = value;
                });
              }),
          ToogleSelecao(
              label: 'Acessa Configuração',
              value: _acessaConfiguracao,
              onChanged: (value) {
                setState(() {
                  _acessaConfiguracao = value;
                });
              }),
          ToogleSelecao(
              label: 'Acessa Financeiro',
              value: _acessaFinanceiro,
              onChanged: (value) {
                setState(() {
                  _acessaFinanceiro = value;
                });
              }),
          ToogleSelecao(
              label: 'Acessa Locação',
              value: _acessaLocacao,
              onChanged: (value) {
                setState(() {
                  _acessaLocacao = value;
                });
              }),
          ToogleSelecao(
              label: 'Gera Cadastro',
              value: _gerarCadastro,
              onChanged: (value) {
                setState(() {
                  _gerarCadastro = value;
                });
              }),
        ],
      ),
    );
  }

  void _PreencheCampos(CargoModel? cargo) {
    if (cargo == null) return;
    _acessaAuditoria = cargo.acessaAuditoria!;
    _acessaCadastro = cargo.acessaCadastro!;
    _acessaConfiguracao = cargo.acessaConfiguracao!;
    _acessaFinanceiro = cargo.acessaFinanceiro!;
    _acessaLocacao = cargo.acessaLocacao!;
    _gerarCadastro = cargo.gerarCadastro!;
    _descricaoController.text = cargo.descricao!;
  }
}
