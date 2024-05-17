import 'dart:convert';

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
    return {
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
      login: map['login'] as String? ?? '',
      senha: map['senha'] as String? ?? '',
      usuarioClienteId: map['usuarioClienteId'] as int ?? 0,
      usuarioFuncionarioId: map['usuarioFuncionarioId'] as int ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory UsuarioModel.fromJson(String source) =>
      UsuarioModel.fromMap(json.decode(source));
}
