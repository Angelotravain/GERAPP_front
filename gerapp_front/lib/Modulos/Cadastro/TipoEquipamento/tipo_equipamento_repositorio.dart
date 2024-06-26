import 'dart:convert';

import 'package:gerapp_front/Helpers/LocalHttp.dart';
import 'package:gerapp_front/Modulos/Cadastro/TipoEquipamento/tipo_equipamento_model.dart';
import 'package:http/http.dart' as http;

class TipoEquipamentoRepositorio {
  Future<List<TipoEquipamentoModel>> GetAlltipoEquipamentos() async {
    final response = await http
        .get(Uri.parse('${Local.localName}/api/Gerapp/Cadastro/ListarTodos'));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      List<TipoEquipamentoModel> tipoEquipamentos =
          jsonData.map((e) => TipoEquipamentoModel.fromJson(e)).toList();

      return tipoEquipamentos;
    } else {
      throw Exception('Falha ao buscar dados no servidor');
    }
  }

  Future<String> deleteTipoEquipamento(int id) async {
    print('caiu aqui krai ${Local.EXCLUIR_TIPO_EQUIPAMENTO}/$id');
    final response =
        await http.delete(Uri.parse('${Local.EXCLUIR_TIPO_EQUIPAMENTO}/$id'));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception(
          'Falha ao excluir o tipoEquipamento. Código de status: ${response.statusCode}');
    }
  }

  static String baseUrl =
      'https://localhost:7009/api/Gerapp/Locacao/TipoEquipamento/';
  Future<void> salvarEditar(
    String tipo,
    String descricaoTipoEquipamento,
    String modelo,
    int tempoDeManutencao,
    TipoEquipamentoModel? tipoEquipamento,
  ) async {
    final tipoEquipamentoModel = TipoEquipamentoModel(
      id: tipoEquipamento != null ? tipoEquipamento.id : 0,
      descricao: descricaoTipoEquipamento,
      modelo: modelo,
      tempoEntreManutencao: tempoDeManutencao,
    );

    final url = Uri.parse(
      '$baseUrl${tipo == 'PUT' ? 'Atualizar/${tipoEquipamento?.id}' : 'Salvar'}',
    );

    final body = jsonEncode(
        tipoEquipamentoModel.toJson()); // Convertendo para String JSON

    try {
      final response = await (tipo == 'PUT'
          ? http.put(url,
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8'
              },
              body: body)
          : http.post(url,
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8'
              },
              body: body));

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Resposta da API: ${response.body}');
      } else {
        throw Exception('Falha na requisição: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro ao fazer a requisição: $e');
    }
  }
}
