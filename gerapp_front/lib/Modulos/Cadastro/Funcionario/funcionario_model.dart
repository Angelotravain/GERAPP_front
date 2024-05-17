import 'dart:convert';

import 'package:gerapp_front/Modulos/Cadastro/Endereco/endereco_model.dart';
import 'package:gerapp_front/Modulos/Cadastro/Usuario/usuario_model.dart';

class FuncionarioModel {
  final int id;
  final String nome;
  final double salario;
  final String imagem;
  final int empresaId;
  final int cargoId;
  final UsuarioModel? usuarioFuncionario;
  final List<EnderecoModel>? enderecoFuncionario;

  FuncionarioModel({
    required this.id,
    required this.nome,
    required this.salario,
    required this.imagem,
    required this.empresaId,
    required this.cargoId,
    required this.usuarioFuncionario,
    required this.enderecoFuncionario,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'salario': salario,
      'imagem': imagem,
      'empresaId': empresaId,
      'cargoId': cargoId,
      'usuarioFuncionario': usuarioFuncionario!.toMap(),
      'enderecoFuncionario':
          enderecoFuncionario!.map((x) => x.toMap()).toList(),
    };
  }

  factory FuncionarioModel.fromMap(Map<String, dynamic> map) {
    return FuncionarioModel(
      id: map['id'] as int ?? 0,
      nome: map['nome'] as String ?? '',
      salario: map['salario'] as double ?? 0,
      imagem: map['imagem'] as String ?? '',
      empresaId: map['empresaId'] as int ?? 0,
      cargoId: map['cargoId'] as int ?? 0,
      usuarioFuncionario: map['usuarioCliente'] ?? null,
      enderecoFuncionario: map['enderecoCliente'] ?? null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FuncionarioModel.fromJson(String source) =>
      FuncionarioModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
