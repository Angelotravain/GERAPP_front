import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UsuarioModel {
  final int id;
  final String login;
  final String senha;
  final int? usuarioClienteId;
  final int? usuarioFuncionarioId;

  UsuarioModel({
    required this.id,
    required this.login,
    required this.senha,
    this.usuarioClienteId,
    this.usuarioFuncionarioId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'login': login,
      'senha': senha,
      'usuarioClienteId': usuarioClienteId,
      'usuarioFuncionarioId': usuarioFuncionarioId,
    };
  }

  factory UsuarioModel.fromMap(Map<String, dynamic> map) {
    return UsuarioModel(
      id: map['id'] as int,
      login: map['login'] as String,
      senha: map['senha'] as String,
      usuarioClienteId: map['usuarioClienteId'] != null
          ? map['usuarioClienteId'] as int
          : null,
      usuarioFuncionarioId: map['usuarioFuncionarioId'] != null
          ? map['usuarioFuncionarioId'] as int
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UsuarioModel.fromJson(String source) =>
      UsuarioModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
