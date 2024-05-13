import 'dart:convert';
import 'package:gerapp_front/Modulos/modelos/Cadastro/endereco_model.dart';
import 'package:gerapp_front/Modulos/modelos/Cadastro/usuario_model.dart';

class ClienteModel {
  final int id;
  final String nome;
  final String email;
  final String cpf;
  final String telefone;
  final bool statusCliente;
  final String nomeMae;
  final String nomePai;
  final String nomeConjugue;
  final DateTime dataNascimento;
  final String imagem;
  final UsuarioModel? usuario;
  final List<EnderecoModel>? endereco;

  ClienteModel({
    required this.id,
    required this.nome,
    required this.email,
    required this.cpf,
    required this.telefone,
    required this.statusCliente,
    required this.nomeMae,
    required this.nomePai,
    required this.nomeConjugue,
    required this.dataNascimento,
    required this.imagem,
    this.usuario,
    this.endereco,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'cpf': cpf,
      'telefone': telefone,
      'statusCliente': statusCliente,
      'nomeMae': nomeMae,
      'nomePai': nomePai,
      'nomeConjugue': nomeConjugue,
      'dataNascimento': dataNascimento.toIso8601String(),
      'imagem': imagem,
      'usuarioCliente': usuario?.toMap(),
      'enderecoCliente': endereco?.map((x) => x.toMap()).toList(),
    };
  }

  factory ClienteModel.fromMap(Map<String, dynamic> map) {
    return ClienteModel(
      id: map['id'] as int,
      nome: map['nome'] as String,
      email: map['email'] as String,
      cpf: map['cpf'] as String,
      telefone: map['telefone'] as String,
      statusCliente: map['statusCliente'] as bool,
      nomeMae: map['nomeMae'] as String,
      nomePai: map['nomePai'] as String,
      nomeConjugue: map['nomeConjugue'] as String,
      dataNascimento: DateTime.parse(map['dataNascimento'] as String),
      imagem: map['imagem'] as String,
      usuario: map['usuarioCliente'] != null
          ? UsuarioModel.fromMap(map['usuarioCliente'] as Map<String, dynamic>)
          : null,
      endereco: map['enderecoCliente'] != null
          ? List<EnderecoModel>.from((map['enderecoCliente'] as List)
              .map((x) => EnderecoModel.fromMap(x as Map<String, dynamic>)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ClienteModel.fromJson(String source) =>
      ClienteModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
