import 'dart:convert';

import 'package:gerapp_front/Helpers/LocalHttp.dart';
import 'package:gerapp_front/Modulos/Cadastro/Bairro/bairro_model.dart';
import 'package:http/http.dart' as http;
import 'package:multi_dropdown/models/value_item.dart';

ValueItem cidadeSelecionada = ValueItem(label: '', value: 0);

class BairroRepositorio {
  Future<List<BairroModel>> GetAllBairros() async {
    final response = await http.get(Uri.parse('${Local.URL_BAIRRO}'));

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
    final response = await http.delete(Uri.parse('${Local.URL_BAIRRO}$id'));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception(
          'Falha ao excluir o bairro. Código de status: ${response.statusCode}');
    }
  }

  void atualizaCidadeParaEnviar(ValueItem first) {
    cidadeSelecionada = first;
  }

  static String baseUrl = Local.URL_BAIRRO;
  Future<void> salvarEditar(
    String tipo,
    String nome,
    String valor,
    bool? isentarFrete,
    int cidadeId,
    BairroModel? bairro,
  ) async {
    final bairroModel = BairroModel(
        id: 0,
        nome: nome,
        valorFrete:
            double.parse(valor.replaceAll('R\$', '').replaceAll(',', '.')),
        isentaFrete: isentarFrete,
        cidadeId: cidadeId);

    final url = Uri.parse('$baseUrl${tipo == 'PUT' ? '${bairro?.id}' : ''}');

    try {
      print(bairroModel.toJson());
      final response = await (tipo == 'PUT'
          ? http.put(headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8'
            }, url, body: bairroModel.toJson())
          : http.post(headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8'
            }, url, body: bairroModel.toJson()));

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Resposta da API: ${response.body}');
      } else {
        throw Exception('Falha na requisição: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao fazer a requisição: $e');
    }
  }
}
