import 'dart:convert';

import 'package:gerapp_front/Modulos/modelos/Cadastro/cargo_model.dart';
import 'package:http/http.dart' as http;
import 'package:multi_dropdown/multiselect_dropdown.dart';

class CargoRepositorio {
  Future<List<CargoModel>> GetAllCargos() async {
    final response = await http.get(
        Uri.parse('https://localhost:7009/api/Gerapp/Cadastro/ListarCargos'));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      List<CargoModel> cargos =
          jsonData.map((e) => CargoModel.fromJson(json.encode(e))).toList();

      return cargos;
    } else {
      throw Exception('Falha ao buscar dados no servidor');
    }
  }

  Future<String> deleteCargo(int id) async {
    final response = await http.delete(Uri.parse(
        'https://localhost:7009/api/Gerapp/Cadastro/ExcluirCargo/$id'));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception(
          'Falha ao excluir o cargo. Código de status: ${response.statusCode}');
    }
  }

  static const String baseUrl = 'https://localhost:7009/api/Gerapp/Cadastro/';
  Future<void> salvarEditar(
    String tipo,
    String descricaoCargo,
    bool? auditoria,
    bool? cadastro,
    bool? configuracao,
    bool? financeiro,
    bool? locacao,
    bool? gerarCadastro,
    CargoModel? cargo,
  ) async {
    final cargoModel = CargoModel(
        id: 0,
        descricao: descricaoCargo,
        acessaAuditoria: auditoria!,
        acessaCadastro: cadastro!,
        acessaConfiguracao: configuracao!,
        acessaFinanceiro: financeiro!,
        acessaLocacao: locacao!,
        gerarCadastro: gerarCadastro!);

    final url = Uri.parse(
        '$baseUrl${tipo == 'PUT' ? 'AtualizarCargo/${cargo?.id}' : 'SalvarCargo'}');

    try {
      final response = await (tipo == 'PUT'
          ? http.put(headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8'
            }, url, body: cargoModel.toJson())
          : http.post(headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8'
            }, url, body: cargoModel.toJson()));

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
