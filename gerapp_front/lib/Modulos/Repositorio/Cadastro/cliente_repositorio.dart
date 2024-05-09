import 'dart:convert';

import 'package:gerapp_front/Helpers/LocalHttp.dart';
import 'package:gerapp_front/Modulos/modelos/Cadastro/Cliente_model.dart';
import 'package:gerapp_front/Modulos/modelos/Cadastro/endereco_model.dart';
import 'package:gerapp_front/Modulos/modelos/Cadastro/usuario_model.dart';
import 'package:http/http.dart' as http;
import 'package:multi_dropdown/multiselect_dropdown.dart';

class ClienteRepositorio {
  Future<List<ClienteModel>> GetAllClientes() async {
    final response = await http.get(
        Uri.parse('${Local.localName}/api/Gerapp/Cadastro/ListarClientes'));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      List<ClienteModel> Clientes =
          jsonData.map((e) => ClienteModel.fromJson(json.encode(e))).toList();

      return Clientes;
    } else {
      throw Exception('Falha ao buscar dados no servidor');
    }
  }

  Future<String> deleteCliente(int id) async {
    final response = await http.delete(
        Uri.parse('${Local.localName}/api/Gerapp/Cadastro/ExcluirCliente/$id'));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception(
          'Falha ao excluir o Cliente. Código de status: ${response.statusCode}');
    }
  }

  static String baseUrl = '${Local.localName}/api/Gerapp/Cadastro/';
  Future<void> salvarEditar(
    String tipo,
    String nomeCliente,
    String? cpfCliente,
    DateTime? dataNascimento,
    String? emailCliente,
    String? telefoneCliente,
    String? nomeMae,
    bool? statusCliente,
    String? nomePai,
    String? nomeConjugue,
    String? imagem,
    List<EnderecoModel> enderecosCliente,
    UsuarioModel usuarioCliente,
    ClienteModel? cliente,
  ) async {
    final clienteModel = ClienteModel(
        id: 0,
        nome: nomeCliente,
        cpf: cpfCliente!,
        dataNascimento: dataNascimento!,
        email: emailCliente!,
        endereco: enderecosCliente,
        usuario: usuarioCliente,
        imagem: imagem!,
        nomeMae: nomeMae!,
        nomePai: nomePai!,
        nomeConjugue: nomeConjugue!,
        statusCliente: statusCliente!,
        telefone: telefoneCliente!);

    final url = Uri.parse(
        '$baseUrl${tipo == 'PUT' ? 'AtualizarCliente/${cliente?.id}' : 'SalvarCliente'}');

    try {
      final response = await (tipo == 'PUT'
          ? http.put(headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8'
            }, url, body: clienteModel.toJson())
          : http.post(headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8'
            }, url, body: clienteModel.toJson()));

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
