class BairroModel {
  final int id;
  final String nome;
  final double valorFrete;
  final bool isentaFrete;
  final int estadoId;

  BairroModel({
    required this.id,
    required this.nome,
    required this.valorFrete,
    required this.isentaFrete,
    required this.estadoId,
  });

  factory BairroModel.fromJson(Map<String, dynamic> json) {
    return BairroModel(
      id: json['id'] as int,
      nome: json['nome'] as String,
      valorFrete: json['valorFrete'] as double,
      isentaFrete: json['isentaFrete'] as bool,
      estadoId: json['estadoId'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'valorFrete': valorFrete,
      'isentaFrete': isentaFrete,
      'estadoId': estadoId,
    };
  }
}
