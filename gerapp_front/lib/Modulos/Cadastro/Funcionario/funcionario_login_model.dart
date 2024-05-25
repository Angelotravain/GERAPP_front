import 'dart:convert';
import 'package:gerapp_front/Modulos/Cadastro/Endereco/endereco_model.dart';
import 'package:gerapp_front/Modulos/Cadastro/Usuario/usuario_model.dart';

class FuncionarioLoginDto {
  final int id;
  final String nome;
  final String imagem;
  final String empresa;
  final String descricao;
  final bool acessaCadastro;
  final bool acessaFinanceiro;
  final bool acessaLocacao;

  FuncionarioLoginDto({
    required this.id,
    required this.nome,
    required this.imagem,
    required this.empresa,
    required this.descricao,
    required this.acessaCadastro,
    required this.acessaFinanceiro,
    required this.acessaLocacao,
  });

  factory FuncionarioLoginDto.fromMap(Map<String, dynamic> map) {
    return FuncionarioLoginDto(
      id: map['id'] as int ?? 0,
      nome: map['nome'] as String ?? '',
      imagem: map['imagem'] as String ?? '',
      empresa: map['empresa'] as String ?? '',
      descricao: map['descricao'] as String ?? '',
      acessaCadastro: map['acessaCadastro'] as bool ?? false,
      acessaFinanceiro: map['acessaFinanceiro'] as bool ?? false,
      acessaLocacao: map['acessaLocacao'] as bool ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'imagem': imagem,
      'empresa': empresa,
      'descricao': descricao,
      'acessaCadastro': acessaCadastro,
      'acessaFinanceiro': acessaFinanceiro,
      'acessaLocacao': acessaLocacao,
    };
  }

  String toJson() => json.encode(toMap());

  factory FuncionarioLoginDto.fromJson(String source) =>
      FuncionarioLoginDto.fromMap(json.decode(source) as Map<String, dynamic>);
}
