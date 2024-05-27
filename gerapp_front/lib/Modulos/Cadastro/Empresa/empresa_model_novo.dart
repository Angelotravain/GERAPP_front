import 'dart:convert';

import 'package:gerapp_front/Modulos/Cadastro/Endereco/endereco_model.dart';

class EmpresaModelNovo {
  int id;
  String? nome; // Alterado para opcional
  String? cnpj;
  String? telefone;
  String? email;
  String? website;
  DateTime? dataFundacao;
  String? ramoAtuacao;
  int? numeroFuncionarios;
  String? proprietario;
  DateTime? dataCadastro;
  String? logoEmpresa;
  bool ehFilial;
  EnderecoModel enderecoEmpresa;

  EmpresaModelNovo({
    required this.id,
    this.nome, // Alterado para opcional
    this.cnpj,
    this.telefone,
    this.email,
    this.website,
    this.dataFundacao,
    this.ramoAtuacao,
    this.numeroFuncionarios,
    this.proprietario,
    this.dataCadastro,
    this.logoEmpresa,
    required this.ehFilial,
    required this.enderecoEmpresa,
  });

  factory EmpresaModelNovo.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw ArgumentError('O argumento json não pode ser nulo');
    }

    return EmpresaModelNovo(
      id: json['id'] as int? ?? 0,
      nome: json['nome'] as String?, // Alterado para opcional
      cnpj: json['cnpj'] as String?,
      telefone: json['telefone'] as String?,
      email: json['email'] as String?,
      website: json['website'] as String?,
      dataFundacao: json['dataFundacao'] != null
          ? DateTime.tryParse(json['dataFundacao'] as String)
          : null,
      ramoAtuacao: json['ramoAtuacao'] as String?,
      numeroFuncionarios: json['numeroFuncionarios'] as int?,
      proprietario: json['proprietario'] as String?,
      dataCadastro: json['dataCadastro'] != null
          ? DateTime.tryParse(json['dataCadastro'] as String)
          : null,
      logoEmpresa: json['logoEmpresa'] as String? ?? '',
      ehFilial: json['ehFilial'] as bool? ?? false,
      enderecoEmpresa: json['enderecoEmpresa'] != null
          ? EnderecoModel.fromJson(jsonEncode(json['enderecoEmpresa']))
          : EnderecoModel(id: 0, logradouro: '', numero: '', bairroId: 0),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'cnpj': cnpj,
      'telefone': telefone,
      'email': email,
      'website': website,
      'dataFundacao': dataFundacao?.toIso8601String(),
      'ramoAtuacao': ramoAtuacao,
      'numeroFuncionarios': numeroFuncionarios,
      'proprietario': proprietario,
      'dataCadastro': dataCadastro?.toIso8601String(),
      'logoEmpresa': logoEmpresa,
      'ehFilial': ehFilial,
      'enderecoEmpresa': enderecoEmpresa.toJson(),
    };
  }
}
