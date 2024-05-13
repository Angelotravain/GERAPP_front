import 'dart:convert';

class EnderecoModel {
  final int id;
  final String logradouro;
  final String numero;
  final String complemento;
  final String cep;
  final int bairroId;
  final int? clienteId;
  final int? funcionarioId;
  final int? empresaId;

  EnderecoModel({
    required this.id,
    required this.logradouro,
    required this.numero,
    required this.complemento,
    required this.cep,
    required this.bairroId,
    this.clienteId,
    this.funcionarioId,
    this.empresaId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'logradouro': logradouro,
      'numero': numero,
      'complemento': complemento,
      'cep': cep,
      'bairroId': bairroId,
      'clienteId': clienteId,
      'funcionarioId': funcionarioId,
      'empresaId': empresaId,
    };
  }

  factory EnderecoModel.fromMap(Map<String, dynamic> map) {
    return EnderecoModel(
      id: map['id'] as int,
      logradouro: map['logradouro'] as String? ?? '',
      numero: map['numero'] as String? ?? '',
      complemento: map['complemento'] as String? ?? '',
      cep: map['cep'] as String? ?? '',
      bairroId: map['bairroId'] as int,
      clienteId: map['clienteId'] as int?,
      funcionarioId: map['funcionarioId'] as int?,
      empresaId: map['empresaId'] as int?,
    );
  }

  String toJson() => json.encode(toMap());

  factory EnderecoModel.fromJson(String source) =>
      EnderecoModel.fromMap(json.decode(source));
}
