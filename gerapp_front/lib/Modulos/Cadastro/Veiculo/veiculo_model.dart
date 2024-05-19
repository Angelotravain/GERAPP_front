class VeiculoModel {
  final int id;
  final String marca;
  final String modelo;
  final int ano;
  final String cor;
  final String placa;
  final String tipoCombustivel;
  final double kmPorLitro;
  final bool manutencaoEmDia;
  final String imagem;

  VeiculoModel({
    required this.id,
    required this.marca,
    required this.modelo,
    required this.ano,
    required this.cor,
    required this.placa,
    required this.tipoCombustivel,
    required this.kmPorLitro,
    required this.manutencaoEmDia,
    required this.imagem,
  });

  factory VeiculoModel.fromJson(Map<String, dynamic> json) {
    return VeiculoModel(
      id: json['id'] as int? ?? 0,
      marca: json['marca'] as String? ?? '',
      modelo: json['modelo'] as String? ?? '',
      ano: json['ano'] as int? ?? 0,
      cor: json['cor'] as String? ?? '',
      placa: json['placa'] as String? ?? '',
      tipoCombustivel: json['tipoCombustivel'] as String? ?? '',
      kmPorLitro: (json['kmPorLitro'] as num?)?.toDouble() ?? 0.0,
      manutencaoEmDia: json['manutencaoEmDia'] as bool? ?? false,
      imagem: json['imagem'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'marca': marca,
      'modelo': modelo,
      'ano': ano,
      'cor': cor,
      'placa': placa,
      'tipoCombustivel': tipoCombustivel,
      'kmPorLitro': kmPorLitro,
      'manutencaoEmDia': manutencaoEmDia,
      'imagem': imagem,
    };
  }
}
