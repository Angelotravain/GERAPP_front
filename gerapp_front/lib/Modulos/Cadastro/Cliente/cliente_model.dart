import 'dart:convert';

import '../Endereco/endereco_model.dart';
import '../Usuario/usuario_model.dart';

class ClienteModel {
  final int id;
  final String nome;
  final String email;
  final String? cpf;
  final String? telefone;
  final bool statusCliente;
  final String? nomeMae;
  final String? nomePai;
  final String? nomeConjugue;
  final DateTime? dataNascimento;
  final String? imagem;
  final UsuarioModel? usuario;
  final List<EnderecoModel>? endereco;

  ClienteModel({
    required this.id,
    required this.nome,
    required this.email,
    this.cpf,
    this.telefone,
    required this.statusCliente,
    this.nomeMae,
    this.nomePai,
    this.nomeConjugue,
    this.dataNascimento,
    this.imagem,
    this.usuario,
    this.endereco,
  });

  factory ClienteModel.fromMap(Map<String, dynamic> map) {
    try {
      return ClienteModel(
        id: map['id'] as int,
        nome: map['nome'] as String,
        email: map['email'] as String,
        cpf: map['cpf'] as String?,
        telefone: map['telefone'] as String?,
        statusCliente: map['statusCliente'] as bool,
        nomeMae: map['nomeMae'] as String?,
        nomePai: map['nomePai'] as String?,
        nomeConjugue: map['nomeConjugue'] as String?,
        dataNascimento: map['dataNascimento'] != null
            ? DateTime.parse(map['dataNascimento'] as String)
            : null,
        imagem: map['imagem'] as String?,
        usuario: map['usuarioCliente'] != null
            ? UsuarioModel.fromMap(
                map['usuarioCliente'] as Map<String, dynamic>)
            : null,
        endereco: map['enderecoCliente'] != null
            ? List<EnderecoModel>.from((map['enderecoCliente'] as List)
                .map((x) => EnderecoModel.fromMap(x as Map<String, dynamic>)))
            : null,
      );
    } catch (e) {
      print('Erro ao fazer o mapeamento do cliente: $e');
      rethrow;
    }
  }

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
      'dataNascimento': dataNascimento?.toIso8601String(),
      'imagem': imagem,
      'usuarioCliente': usuario?.toMap(),
      'enderecoCliente': endereco?.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  factory ClienteModel.fromJson(String source) =>
      ClienteModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
