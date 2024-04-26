import 'dart:convert';
import 'package:gerapp_front/Modulos/modelos/Cadastro/cidade_model.dart';
import 'package:http/http.dart' as http;

class CidadeRepositorio {
  Future<CidadeModel> GetCidadePorId(int? id) async {
    final response = await http.get(
      Uri.parse(
          'https://localhost:7009/api/Gerapp/Cadastro/ListarCidadesPorId/$id'),
    );

    if (response.statusCode == 200) {
      dynamic jsonData = json.decode(response.body);

      // Verifica se o jsonData é uma lista
      if (jsonData is List) {
        // Se for uma lista, verifica se não está vazia
        if (jsonData.isNotEmpty) {
          // Retorna o primeiro item da lista
          return CidadeModel.fromJson(jsonData.first);
        } else {
          // Se a lista estiver vazia, lança uma exceção
          throw Exception('Nenhuma cidade encontrada com o ID fornecido');
        }
      } else if (jsonData is Map<String, dynamic>) {
        // Se for um mapa, cria um objeto CidadeModel diretamente
        return CidadeModel.fromMap(jsonData);
      } else {
        // Se não for nem uma lista nem um mapa, lança uma exceção
        throw Exception('Resposta do servidor não está no formato esperado');
      }
    } else {
      throw Exception('Falha ao buscar dados no servidor');
    }
  }
}
