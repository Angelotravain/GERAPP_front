import 'dart:convert';

class FormaPagamentoModel {
  final int id;
  final String descricao;
  final bool? ehCredito;
  final bool? ehDebito;
  final bool? ehAvista;
  final bool? ehPrazo;

  FormaPagamentoModel({
    required this.id,
    required this.descricao,
    this.ehCredito,
    this.ehDebito,
    this.ehAvista,
    this.ehPrazo,
  });

  factory FormaPagamentoModel.fromJson(String source) {
    try {
      final Map<String, dynamic> jsonMap = json.decode(source);
      return FormaPagamentoModel(
        id: jsonMap['id'] as int? ?? 0,
        descricao: jsonMap['descricao'] as String? ?? '',
        ehCredito: jsonMap['ehCredito'] as bool? ?? false,
        ehDebito: jsonMap['ehDebito'] as bool? ?? false,
        ehAvista: jsonMap['ehAvista'] as bool? ?? false,
        ehPrazo: jsonMap['ehPrazo'] as bool? ?? false,
      );
    } catch (e) {
      print('Erro ao decodificar JSON: $e');
      throw Exception('Erro ao decodificar JSON: $e');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'descricao': descricao,
      'ehCredito': ehCredito ?? false,
      'ehDebito': ehDebito ?? false,
      'ehAvista': ehAvista ?? false,
      'ehPrazo': ehPrazo ?? false,
    };
  }
}
