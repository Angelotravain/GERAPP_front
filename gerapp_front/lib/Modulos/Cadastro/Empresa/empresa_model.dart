import 'dart:convert';

import 'package:intl/intl.dart';

import '../Endereco/endereco_model.dart';

class EmpresaModel {
  final int id;
  final String nome;
  final String? cnpj;
  final int estadoId; // Alterado para int
  final String telefone;
  final String? email;
  final String? webSite;
  final String? dataFundacao;
  final String? ramoAtuacao;
  final int? numeroFuncionarios;
  final String? proprietario;
  final DateTime dataCadastro;
  final String? logoEmpresa;
  final bool? ehFilial;
  final EnderecoModel? endereco;

  EmpresaModel({
    required this.id,
    required this.nome,
    this.cnpj,
    required this.estadoId,
    required this.telefone,
    this.email,
    this.webSite,
    required this.dataFundacao,
    this.ramoAtuacao,
    this.numeroFuncionarios,
    this.proprietario,
    required this.dataCadastro,
    this.logoEmpresa,
    this.ehFilial,
    required this.endereco,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nome': nome,
      'cnpj': cnpj,
      'estadoId': estadoId, // Alterado para int
      'telefone': telefone,
      'email': email,
      'webSite': webSite,
      'dataFundacao':
          DateFormat('dd/MM/yyyy').format(DateTime.parse(dataFundacao!)),
      'ramoAtuacao': ramoAtuacao,
      'numeroFuncionarios': numeroFuncionarios,
      'proprietario': proprietario,
      'dataCadastro': DateFormat('dd/MM/yyyy').format(dataCadastro),
      'logoEmpresa': logoEmpresa,
      'ehFilial': ehFilial,
      'enderecoEmpresa': endereco?.toMap(),
    };
  }

  factory EmpresaModel.fromMap(Map<String, dynamic> map) {
    return EmpresaModel(
      id: map['id'] as int ?? 0,
      nome: map['nome'] as String ?? '',
      cnpj: map['cnpj'] as String?,
      estadoId: map['estadoId'] as int ?? 0,
      telefone: map['telefone'] as String? ?? '',
      email: map['email'] as String?,
      webSite: map['webSite'] as String?,
      dataFundacao: DateTime.parse(map['dataFundacao']).toIso8601String(),
      ramoAtuacao: map['ramoAtuacao'] as String?,
      numeroFuncionarios: map['numeroFuncionarios'] as int?,
      proprietario: map['proprietario'] as String?,
      dataCadastro: DateTime.now(),
      logoEmpresa: map['logoEmpresa'] as String?,
      ehFilial: map['ehFilial'] as bool?,
      endereco: map['enderecoEmpresa'] != null
          ? EnderecoModel.fromMap(
              map['enderecoEmpresa'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory EmpresaModel.fromJson(String source) =>
      EmpresaModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
