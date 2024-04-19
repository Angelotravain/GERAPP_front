// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:gerapp_front/Modulos/modelos/Cadastro/endereco_model.dart';

class EmpresaModel {
  final int id;
  final String nome;
  final String cnpj;
  final int estadoId;
  final String telefone;
  final String email;
  final String webSite;
  final DateTime dataFundacao;
  final String ramoAtuacao;
  final int numeroFuncionarios;
  final String proprietario;
  final DateTime dataCadastro;
  final String LogoEmpresa;
  final bool ehFilial;
  final EnderecoModel endereco;

  EmpresaModel({
    required this.id,
    required this.nome,
    required this.cnpj,
    required this.estadoId,
    required this.telefone,
    required this.email,
    required this.webSite,
    required this.dataFundacao,
    required this.ramoAtuacao,
    required this.numeroFuncionarios,
    required this.proprietario,
    required this.dataCadastro,
    required this.LogoEmpresa,
    required this.ehFilial,
    required this.endereco,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nome': nome,
      'cnpj': cnpj,
      'estadoId': estadoId,
      'telefone': telefone,
      'email': email,
      'webSite': webSite,
      'dataFundacao': dataFundacao.millisecondsSinceEpoch,
      'ramoAtuacao': ramoAtuacao,
      'numeroFuncionarios': numeroFuncionarios,
      'proprietario': proprietario,
      'dataCadastro': dataCadastro.millisecondsSinceEpoch,
      'LogoEmpresa': LogoEmpresa,
      'ehFilial': ehFilial,
      'endereco': endereco.toMap(),
    };
  }

  factory EmpresaModel.fromMap(Map<String, dynamic> map) {
    return EmpresaModel(
      id: map['id'] as int,
      nome: map['nome'] as String,
      cnpj: map['cnpj'] as String,
      estadoId: map['estadoId'] as int,
      telefone: map['telefone'] as String,
      email: map['email'] as String,
      webSite: map['webSite'] as String,
      dataFundacao:
          DateTime.fromMillisecondsSinceEpoch(map['dataFundacao'] as int),
      ramoAtuacao: map['ramoAtuacao'] as String,
      numeroFuncionarios: map['numeroFuncionarios'] as int,
      proprietario: map['proprietario'] as String,
      dataCadastro:
          DateTime.fromMillisecondsSinceEpoch(map['dataCadastro'] as int),
      LogoEmpresa: map['LogoEmpresa'] as String,
      ehFilial: map['ehFilial'] as bool,
      endereco: EnderecoModel.fromMap(map['endereco'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory EmpresaModel.fromJson(String source) =>
      EmpresaModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
