class TipoEquipamentoModel {
  final int id;
  final String descricao;
  final String modelo;
  final int tempoEntreManutencao;

  TipoEquipamentoModel({
    required this.id,
    required this.descricao,
    required this.modelo,
    required this.tempoEntreManutencao,
  });

  factory TipoEquipamentoModel.fromJson(Map<String, dynamic> json) {
    return TipoEquipamentoModel(
      id: json['id'] as int? ?? 0,
      descricao: json['descricao'] as String? ?? '',
      modelo: json['modelo'] as String? ?? '',
      tempoEntreManutencao: json['tempoEntreManutencao'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'descricao': descricao,
      'modelo': modelo,
      'tempoEntreManutencao': tempoEntreManutencao,
    };
  }
}
