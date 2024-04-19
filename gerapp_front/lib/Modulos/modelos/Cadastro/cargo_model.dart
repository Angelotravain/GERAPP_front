import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
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
      acessaAuditoria: map['acessaAuditoria'] as bool,
      acessaCadastro: map['acessaCadastro'] as bool,
      acessaConfiguracao: map['acessaConfiguracao'] as bool,
      acessaFinanceiro: map['acessaFinanceiro'] as bool,
      acessaLocacao: map['acessaLocacao'] as bool,
      gerarCadastro: map['gerarCadastro'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory CargoModel.fromJson(String source) =>
      CargoModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
