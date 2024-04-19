import 'dart:convert';

import 'package:gerapp_front/Modulos/modelos/Cadastro/cidade_model.dart';
import 'package:http/http.dart' as http;

class CidadeRepositorio {
  Future<List<CidadeModel>> GetAllCidades() async {
    final response = await http.get(Uri.parse(
        'https://localhost:7009/api/Gerapp/Cadastro/ListarCidades?contador=600&pular=0'));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      List<CidadeModel> cidades =
          jsonData.map((e) => CidadeModel.fromJson(json.encode(e))).toList();

      return cidades;
    } else {
      throw Exception('Falha ao buscar dados no servidor');
    }
  }
}
