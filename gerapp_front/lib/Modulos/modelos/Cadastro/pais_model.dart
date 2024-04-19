import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class PaisModel {
  final int id;
  final String nome;
  final String nomePt;
  final String sigla;
  final int bacen;

  PaisModel({
    required this.id,
    required this.nome,
    required this.nomePt,
    required this.sigla,
    required this.bacen,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nome': nome,
      'nomePt': nomePt,
      'sigla': sigla,
      'bacen': bacen,
    };
  }

  factory PaisModel.fromMap(Map<String, dynamic> map) {
    return PaisModel(
      id: map['id'] as int,
      nome: map['nome'] as String,
      nomePt: map['nomePt'] as String,
      sigla: map['sigla'] as String,
      bacen: map['bacen'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaisModel.fromJson(String source) =>
      PaisModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
