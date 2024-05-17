import 'dart:convert';

class BairroModel {
  final int? id;
  final String nome;
  final double valorFrete;
  final bool? isentaFrete;
  final int cidadeId;

  BairroModel({
    required this.id,
    required this.nome,
    required this.valorFrete,
    required this.isentaFrete,
    required this.cidadeId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nome': nome,
      'valorFrete': valorFrete,
      'isentaFrete': isentaFrete,
      'cidadeId': cidadeId,
    };
  }

  factory BairroModel.fromMap(Map<String, dynamic> map) {
    return BairroModel(
      id: map['id'] as int?,
      nome: map['nome'] as String,
      valorFrete: (map['valorFrete'] as num).toDouble(),
      isentaFrete: map['isentaFrete'] is String
          ? map['isentaFrete'] == 'true'
          : map['isentaFrete'] as bool?,
      cidadeId: map['cidadeId'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory BairroModel.fromJson(String source) =>
      BairroModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
