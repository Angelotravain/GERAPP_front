import 'dart:convert';

class EnderecoModel {
  int id;
  String logradouro;
  String numero;
  String? complemento;
  String? cep;
  int bairroId;
  int? clienteId;
  int? funcionarioId;
  int empresaId;

  EnderecoModel({
    required this.id,
    required this.logradouro,
    required this.numero,
    this.complemento,
    this.cep,
    required this.bairroId,
    this.clienteId,
    this.funcionarioId,
    required this.empresaId,
  });

  factory EnderecoModel.fromJson(Map<String, dynamic> json) {
    return EnderecoModel(
      id: json['id'] as int? ?? 0,
      logradouro: json['logradouro'] as String? ?? '',
      numero: json['numero'] as String? ?? '',
      complemento: json['complemento'] as String?,
      cep: json['cep'] as String?,
      bairroId: json['bairroId'] as int? ?? 0,
      clienteId: json['clienteId'] as int?,
      funcionarioId: json['funcionarioId'] as int?,
      empresaId: json['empresaId'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'logradouro': logradouro,
      'numero': numero,
      'complemento': complemento,
      'cep': cep,
      'bairroId': bairroId,
      'clienteId': clienteId,
      'funcionarioId': funcionarioId,
      'empresaId': empresaId,
    };
  }
}

class EmpresaModelNovo {
  int id;
  String? nome;
  String? cnpj;
  String? telefone;
  String? email;
  String? website;
  String? ramoAtuacao;
  int? numeroFuncionarios;
  String? proprietario;
  String? logoEmpresa;
  bool ehFilial;
  EnderecoModel enderecoEmpresa;

  EmpresaModelNovo({
    required this.id,
    this.nome,
    this.cnpj,
    this.telefone,
    this.email,
    this.website,
    this.ramoAtuacao,
    this.numeroFuncionarios,
    this.proprietario,
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
      nome: json['nome'] as String?,
      cnpj: json['cnpj'] as String?,
      telefone: json['telefone'] as String?,
      email: json['email'] as String?,
      website: json['website'] as String?,
      ramoAtuacao: json['ramoAtuacao'] as String?,
      numeroFuncionarios: json['numeroFuncionarios'] as int?,
      proprietario: json['proprietario'] as String?,
      logoEmpresa: json['logoEmpresa'] as String?,
      ehFilial: json['ehFilial'] as bool? ?? false,
      enderecoEmpresa: json['enderecoEmpresa'] != null
          ? EnderecoModel.fromJson(
              json['enderecoEmpresa'] as Map<String, dynamic>)
          : EnderecoModel(
              id: 0, logradouro: '', numero: '', bairroId: 0, empresaId: 0),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome ?? '',
      'cnpj': cnpj ?? '',
      'telefone': telefone ?? '',
      'email': email ?? '',
      'website': website ?? '',
      'ramoAtuacao': ramoAtuacao ?? '',
      'numeroFuncionarios': numeroFuncionarios ?? 0,
      'proprietario': proprietario ?? '',
      'logoEmpresa': logoEmpresa ?? '',
      'ehFilial': ehFilial,
      'enderecoEmpresa': enderecoEmpresa.toJson(),
    };
  }
}
