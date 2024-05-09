import 'dart:convert';
import 'package:gerapp_front/Helpers/LocalHttp.dart';
import 'package:gerapp_front/Modulos/modelos/Cadastro/cidade_model.dart';
import 'package:http/http.dart' as http;

class CidadeRepositorio {
  Future<CidadeModel> GetCidadePorId(int? id) async {
    final response = await http.get(
      Uri.parse(
          '${Local.localName}/api/Gerapp/Cadastro/ListarCidadesPorId/$id'),
    );

    if (response.statusCode == 200) {
      dynamic jsonData = json.decode(response.body);

      if (jsonData is List) {
        if (jsonData.isNotEmpty) {
          return CidadeModel.fromJson(jsonData.first);
        } else {
          throw Exception('Nenhuma cidade encontrada com o ID fornecido');
        }
      } else if (jsonData is Map<String, dynamic>) {
        return CidadeModel.fromMap(jsonData);
      } else {
        throw Exception('Resposta do servidor não está no formato esperado');
      }
    } else {
      throw Exception('Falha ao buscar dados no servidor');
    }
  }
}
