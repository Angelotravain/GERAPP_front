import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:gerapp_front/Helpers/LocalHttp.dart';
import 'package:gerapp_front/Modulos/Cadastro/Veiculo/veiculo_model.dart';

class VeiculoRepositorio {
  static final String baseUrl = '${Local.localName}/api/Gerapp/Locacao/Veiculo';

  Future<List<VeiculoModel>> getAllVeiculos() async {
    final response = await http.get(
      Uri.parse('$baseUrl/Listarveiculos'),
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      List<VeiculoModel> veiculos =
          jsonData.map((e) => VeiculoModel.fromJson(e)).toList();
      return veiculos;
    } else {
      throw Exception('Falha ao buscar dados no servidor');
    }
  }

  Future<String> deleteVeiculo(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/Excluir/$id'),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception(
          'Falha ao excluir o veiculo. Código de status: ${response.statusCode}');
    }
  }

  Future<void> salvarEditar(
    String tipo,
    int id,
    String marca,
    String modelo,
    int ano,
    String cor,
    String placa,
    String tipoCombustivel,
    double kmPorLitro,
    bool manutencaoEmDia,
    String imagem,
    VeiculoModel? veiculo,
  ) async {
    final veiculoModel = VeiculoModel(
      id: id,
      marca: marca,
      modelo: modelo,
      ano: ano,
      cor: cor,
      placa: placa,
      tipoCombustivel: tipoCombustivel,
      kmPorLitro: kmPorLitro,
      manutencaoEmDia: manutencaoEmDia,
      imagem: imagem,
    );

    final url = Uri.parse(
        '$baseUrl${tipo == 'PUT' ? '/Atualizar/${veiculo?.id}' : '/Salvar'}');

    print('veiculo caiu aqui ${veiculoModel.toJson()}');
    try {
      final response = await (tipo == 'PUT'
          ? http.put(
              url,
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8'
              },
              body: jsonEncode(veiculoModel.toJson()),
            )
          : http.post(
              url,
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8'
              },
              body: jsonEncode(veiculoModel.toJson()),
            ));

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
