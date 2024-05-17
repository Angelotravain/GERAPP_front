import 'dart:convert';

class CidadeModel {
  final int id;
  final String nome;
  final int uf;
  final int ibge;
  final String latLon;
  final double latitude;
  final double longitude;
  final int codTom;

  CidadeModel({
    required this.id,
    required this.nome,
    required this.uf,
    required this.ibge,
    required this.latLon,
    required this.latitude,
    required this.longitude,
    required this.codTom,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nome': nome,
      'uf': uf,
      'ibge': ibge,
      'latLon': latLon,
      'latitude': latitude,
      'longitude': longitude,
      'codTom': codTom,
    };
  }

  factory CidadeModel.fromMap(Map<String, dynamic> map) {
    return CidadeModel(
      id: map['id'] as int,
      nome: map['nome'] as String,
      uf: map['uf'] as int,
      ibge: map['ibge'] as int,
      latLon: map['latLon'] as String,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
      codTom: map['codTom'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory CidadeModel.fromJson(String source) =>
      CidadeModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
