import 'dart:convert';

class CargoModel {
  final int id;
  final String descricao;
  final bool acessaCadastro;
  final bool acessaFinanceiro;
  final bool acessaLocacao;

  CargoModel({
    required this.id,
    required this.descricao,
    required this.acessaCadastro,
    required this.acessaFinanceiro,
    required this.acessaLocacao,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'descricao': descricao,
      'acessaCadastro': acessaCadastro,
      'acessaFinanceiro': acessaFinanceiro,
      'acessaLocacao': acessaLocacao,
    };
  }

  factory CargoModel.fromMap(Map<String, dynamic> map) {
    return CargoModel(
        id: map['id'] as int,
        descricao: map['descricao'] as String,
        acessaCadastro: map['acessaCadastro'] is String
            ? map['acessaCadastro'] == 'true'
            : map['acessaCadastro'] as bool,
        acessaFinanceiro: map['acessaFinanceiro'] is String
            ? map['acessaFinanceiro'] == 'true'
            : map['acessaFinanceiro'] as bool,
        acessaLocacao: map['acessaLocacao'] is String
            ? map['acessaLocacao'] == 'true'
            : map['acessaLocacao'] as bool);
  }

  String toJson() => json.encode(toMap());

  factory CargoModel.fromJson(String source) =>
      CargoModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
