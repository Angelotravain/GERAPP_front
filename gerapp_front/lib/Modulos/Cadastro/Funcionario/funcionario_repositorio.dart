import 'dart:convert';

import 'package:gerapp_front/Helpers/LocalHttp.dart';
import 'package:gerapp_front/Helpers/conversor.dart';
import 'package:gerapp_front/Modulos/Cadastro/Cargo/cargo_model.dart';
import 'package:gerapp_front/Modulos/Cadastro/Empresa/empresa_model.dart';
import 'package:gerapp_front/Modulos/Cadastro/Endereco/endereco_model.dart';
import 'package:gerapp_front/Modulos/Cadastro/Funcionario/funcionario_model.dart';
import 'package:gerapp_front/Modulos/Cadastro/Usuario/usuario_model.dart';
import 'package:http/http.dart' as http;
import 'package:multi_dropdown/multiselect_dropdown.dart';

class FuncionarioRepositorio {
  Future<List<FuncionarioModel>> GetAllFuncionarios() async {
    final response = await http.get(
        Uri.parse('${Local.localName}/api/Gerapp/Cadastro/ListarFuncionarios'));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      List<FuncionarioModel> funcionarios = jsonData
          .map((e) => FuncionarioModel.fromJson(json.encode(e)))
          .toList();

      return funcionarios;
    } else {
      throw Exception('Falha ao buscar dados no servidor');
    }
  }

  Future<String> deleteFuncionario(int id) async {
    final response = await http.delete(Uri.parse(
        '${Local.localName}/api/Gerapp/Cadastro/Excluirfuncionarios/$id'));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception(
          'Falha ao excluir o funcionario. Código de status: ${response.statusCode}');
    }
  }

  static String baseUrl = '${Local.localName}/api/Gerapp/Cadastro/';
  Future<void> salvarEditar(
    String tipo,
    String nomefuncionario,
    double? salario,
    String? imagem,
    int? cargo,
    int? empresa,
    List<EnderecoModel> enderecosfuncionario,
    UsuarioModel usuariofuncionario,
    FuncionarioModel? funcionario,
  ) async {
    final funcionarioModel = FuncionarioModel(
        id: 0,
        nome: nomefuncionario,
        enderecoFuncionario: enderecosfuncionario,
        usuarioFuncionario: usuariofuncionario,
        imagem: imagem!,
        salario: salario!,
        cargoId: cargo!,
        empresaId: empresa!);

    final url = Uri.parse(
        '$baseUrl${tipo == 'PUT' ? 'Atualizarfuncionarios/${funcionario?.id}' : 'Salvarfuncionarios'}');

    print(funcionarioModel.toJson());
    try {
      final response = await (tipo == 'PUT'
          ? http.put(headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8'
            }, url, body: funcionarioModel.toJson())
          : http.post(headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8'
            }, url, body: funcionarioModel.toJson()));

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
