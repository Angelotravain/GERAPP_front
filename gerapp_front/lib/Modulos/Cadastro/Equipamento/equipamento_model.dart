import 'dart:convert';

class EquipamentoModel {
  final int id;
  final int tipoEquipamentoId;
  final String? descricao;
  final int quantidade;
  final double valorTotal;
  final bool estaDisponivel;
  final String? imagem;

  EquipamentoModel({
    required this.id,
    required this.tipoEquipamentoId,
    required this.quantidade,
    required this.valorTotal,
    required this.estaDisponivel,
    this.imagem,
    this.descricao,
  });

  factory EquipamentoModel.fromJson(String source) {
    try {
      final Map<String, dynamic> jsonMap = json.decode(source);
      return EquipamentoModel(
          id: jsonMap['id'] as int? ?? 0,
          tipoEquipamentoId: jsonMap['tipoEquipamentoId'] as int? ?? 0,
          quantidade: jsonMap['quantidade'] as int? ?? 0,
          valorTotal: jsonMap['valorTotal'] as double? ?? 0,
          estaDisponivel: jsonMap['estaDisponivel'] as bool? ?? false,
          imagem: jsonMap['imagem'].toString() ?? '',
          descricao: jsonMap['descricao'].toString() ?? '');
    } catch (e) {
      print('Erro ao decodificar JSON: $e');
      throw Exception('Erro ao decodificar JSON: $e');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tipoEquipamentoId': tipoEquipamentoId,
      'quantidade': quantidade,
      'valorTotal': valorTotal,
      'estaDisponivel': estaDisponivel,
      'imagem': imagem,
      'descricao': descricao,
    };
  }
}
