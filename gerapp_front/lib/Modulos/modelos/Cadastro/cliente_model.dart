// ignore_for_file: public_member_api_docs, sort_constructors_first
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
  final UsuarioModel usuario;
  final List<EnderecoModel> endereco;

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
    required this.usuario,
    required this.endereco,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nome': nome,
      'email': email,
      'cpf': cpf,
      'telefone': telefone,
      'statusCliente': statusCliente,
      'nomeMae': nomeMae,
      'nomePai': nomePai,
      'nomeConjugue': nomeConjugue,
      'dataNascimento': dataNascimento.millisecondsSinceEpoch,
      'imagem': imagem,
      'usuario': usuario.toMap(),
      'endereco': endereco.map((x) => x.toMap()).toList(),
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
      dataNascimento:
          DateTime.fromMillisecondsSinceEpoch(map['dataNascimento'] as int),
      imagem: map['imagem'] as String,
      usuario: UsuarioModel.fromMap(map['usuario'] as Map<String, dynamic>),
      endereco: List<EnderecoModel>.from(
        (map['endereco'] as List<int>).map<EnderecoModel>(
          (x) => EnderecoModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ClienteModel.fromJson(String source) =>
      ClienteModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
