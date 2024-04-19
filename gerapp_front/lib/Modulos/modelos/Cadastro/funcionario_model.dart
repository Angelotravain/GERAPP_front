// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:gerapp_front/Modulos/modelos/Cadastro/endereco_model.dart';
import 'package:gerapp_front/Modulos/modelos/Cadastro/usuario_model.dart';

class FuncionarioModel {
  final int id;
  final String nome;
  final double salario;
  final String imagem;
  final int empresaId;
  final int cargoId;
  final UsuarioModel usuario;
  final List<EnderecoModel> endereco;

  FuncionarioModel({
    required this.id,
    required this.nome,
    required this.salario,
    required this.imagem,
    required this.empresaId,
    required this.cargoId,
    required this.usuario,
    required this.endereco,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nome': nome,
      'salario': salario,
      'imagem': imagem,
      'empresaId': empresaId,
      'cargoId': cargoId,
      'usuario': usuario.toMap(),
      'endereco': endereco.map((x) => x.toMap()).toList(),
    };
  }

  factory FuncionarioModel.fromMap(Map<String, dynamic> map) {
    return FuncionarioModel(
      id: map['id'] as int,
      nome: map['nome'] as String,
      salario: map['salario'] as double,
      imagem: map['imagem'] as String,
      empresaId: map['empresaId'] as int,
      cargoId: map['cargoId'] as int,
      usuario: UsuarioModel.fromMap(map['usuario'] as Map<String, dynamic>),
      endereco: List<EnderecoModel>.from(
        (map['endereco'] as List<int>).map<EnderecoModel>(
          (x) => EnderecoModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory FuncionarioModel.fromJson(String source) =>
      FuncionarioModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
