import 'dart:convert';

class CargoModel {
  final int id;
  final String descricao;
  final bool acessaAuditoria;
  final bool acessaCadastro;
  final bool acessaConfiguracao;
  final bool acessaFinanceiro;
  final bool acessaLocacao;
  final bool gerarCadastro;

  CargoModel({
    required this.id,
    required this.descricao,
    required this.acessaAuditoria,
    required this.acessaCadastro,
    required this.acessaConfiguracao,
    required this.acessaFinanceiro,
    required this.acessaLocacao,
    required this.gerarCadastro,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'descricao': descricao,
      'acessaAuditoria': acessaAuditoria,
      'acessaCadastro': acessaCadastro,
      'acessaConfiguracao': acessaConfiguracao,
      'acessaFinanceiro': acessaFinanceiro,
      'acessaLocacao': acessaLocacao,
      'gerarCadastro': gerarCadastro,
    };
  }

  factory CargoModel.fromMap(Map<String, dynamic> map) {
    return CargoModel(
      id: map['id'] as int,
      descricao: map['descricao'] as String,
      acessaAuditoria: map['acessaAuditoria'] is String
          ? map['acessaAuditoria'] == 'true'
          : map['acessaAuditoria'] as bool,
      acessaCadastro: map['acessaCadastro'] is String
          ? map['acessaCadastro'] == 'true'
          : map['acessaCadastro'] as bool,
      acessaConfiguracao: map['acessaConfiguracao'] is String
          ? map['acessaConfiguracao'] == 'true'
          : map['acessaConfiguracao'] as bool,
      acessaFinanceiro: map['acessaFinanceiro'] is String
          ? map['acessaFinanceiro'] == 'true'
          : map['acessaFinanceiro'] as bool,
      acessaLocacao: map['acessaLocacao'] is String
          ? map['acessaLocacao'] == 'true'
          : map['acessaLocacao'] as bool,
      gerarCadastro: map['geraCadastro'] is String
          ? map['geraCadastro'] == 'true'
          : map['geraCadastro'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory CargoModel.fromJson(String source) =>
      CargoModel.fromMap(json.decode(source) as Map<String, dynamic>);
}