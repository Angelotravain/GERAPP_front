import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class EstadoModel {
  final int id;
  final String nome;
  final String f;
  final int paisId;
  final int ibge;
  final String ddd;

  EstadoModel({
    required this.id,
    required this.nome,
    required this.f,
    required this.paisId,
    required this.ibge,
    required this.ddd,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nome': nome,
      'f': f,
      'paisId': paisId,
      'ibge': ibge,
      'ddd': ddd,
    };
  }

  factory EstadoModel.fromMap(Map<String, dynamic> map) {
    return EstadoModel(
      id: map['id'] as int,
      nome: map['nome'] as String,
      f: map['f'] as String,
      paisId: map['paisId'] as int,
      ibge: map['ibge'] as int,
      ddd: map['ddd'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory EstadoModel.fromJson(String source) =>
      EstadoModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
