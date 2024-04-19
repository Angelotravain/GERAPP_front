import 'dart:convert';

import 'package:gerapp_front/Modulos/modelos/Cadastro/bairro_model.dart';
import 'package:http/http.dart' as http;

class BairroRepositorio {
  Future<List<BairroModel>> GetAllBairros() async {
    final response = await http.get(
        Uri.parse('https://localhost:7009/api/Gerapp/Cadastro/ListarBairros'));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      List<BairroModel> bairros =
          jsonData.map((e) => BairroModel.fromJson(json.encode(e))).toList();

      return bairros;
    } else {
      throw Exception('Falha ao buscar dados no servidor');
    }
  }

  Future<String> deleteBairro(int id) async {
    final response = await http.delete(Uri.parse(
        'https://localhost:7009/api/Gerapp/Cadastro/ExcluirBairro/$id'));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception(
          'Falha ao excluir o bairro. Código de status: ${response.statusCode}');
    }
  }
}
