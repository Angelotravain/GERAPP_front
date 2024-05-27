import 'dart:convert';
import 'package:http/http.dart' as http;

class GenericHttp {
  Future<String> Salvar(String body, String urlSalvar) async {
    final url = Uri.parse(urlSalvar);

    try {
      final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      } else {
        return 'Falha na requisição: ${response.statusCode}';
      }
    } catch (e) {
      return 'Erro ao fazer a requisição: $e';
    }
  }

  Future<String> Editar(int id, String body, String urlSalvar) async {
    final url = Uri.parse('${urlSalvar}/$id');

    try {
      final response = await http.put(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      } else {
        return 'Falha na requisição: ${response.statusCode}';
      }
    } catch (e) {
      return 'Erro ao fazer a requisição: $e';
    }
  }

  Future<String> Delete(int id, String urlEntrada) async {
    print('caiu excluir aqui' + '${urlEntrada}/${id}');
    final response = await http.delete(Uri.parse('${urlEntrada}/${id}'));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception(
          'Falha ao excluir o tipoEquipamento. Código de status: ${response.statusCode}');
    }
  }

  Future<dynamic> GetTwoArguments(
      String UrlEntrada, String item1, String item2) async {
    final response =
        await http.get(Uri.parse('${UrlEntrada}/${item1}/${item2}'));

    if (response.statusCode == 200) {
      dynamic jsonData = json.decode(response.body);

      return jsonData;
    } else if (response.statusCode == 404) {
      return null;
    } else {
      throw Exception('Falha ao buscar dados no servidor');
    }
  }
}
