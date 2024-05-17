import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

import '../../../Helpers/LocalHttp.dart';
import 'empresa_model.dart';
import 'empresa_model_novo.dart';

ValueItem cidadeSelecionada = ValueItem(label: '', value: 0);

class EmpresaRepositorio {
  Future<List<EmpresaModel>> GetAllEmpresas() async {
    final response = await http.get(
        Uri.parse('${Local.localName}/api/Gerapp/Cadastro/ListarEmpresas'));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      List<EmpresaModel> empresas = jsonData
          .map((e) => EmpresaModel.fromJson(json.encode(e) as String))
          .toList();

      return empresas;
    } else {
      throw Exception('Falha ao buscar dados no servidor');
    }
  }

  Future<String> deleteEmpresa(int id) async {
    final response = await http.delete(Uri.parse(
        '${Local.localName}/api/Gerapp/Cadastro/ExcluirEmpresas/$id'));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception(
          'Falha ao excluir a Empresa. Código de status: ${response.statusCode}');
    }
  }

  void atualizaCidadeParaEnviar(ValueItem first) {
    cidadeSelecionada = first;
  }

  static String baseUrl = '${Local.localName}/api/Gerapp/Cadastro/';
  Future<void> salvarEditar(
    String tipo,
    String nome,
    String? logoEmpresa,
    String? cnpjEmpresa,
    DateTime? dataFundacaoEmpresa,
    bool? ehFilial,
    String? emailEmpresa,
    Endereco enderecoEmpresa,
    int estadoId,
    int? numeroFuncionariosEmpresa,
    String? proprietarioEmpresa,
    String? ramoAtuacaoEmpresa,
    String telefoneEmpresa,
    String? webSiteEmpresa,
    EmpresaModel? empresa,
  ) async {
    final DateFormat formatter = DateFormat('yyyy-MM-ddTHH:mm:ss');
    final String formattedDataFundacao = dataFundacaoEmpresa != null
        ? formatter.format(dataFundacaoEmpresa)
        : '';

    final empresaModel = EmpresaModelNovo(
      id: empresa!.id ?? 0,
      nome: nome,
      logoEmpresa: logoEmpresa!,
      cnpj: cnpjEmpresa!,
      dataCadastro: DateTime.now(),
      dataFundacao: dataFundacaoEmpresa!,
      ehFilial: ehFilial!,
      email: emailEmpresa!,
      enderecoEmpresa: enderecoEmpresa,
      estadoId: estadoId,
      numeroFuncionarios: numeroFuncionariosEmpresa!,
      proprietario: proprietarioEmpresa!,
      ramoAtuacao: ramoAtuacaoEmpresa!,
      telefone: telefoneEmpresa,
      website: webSiteEmpresa!,
    );

    final url = Uri.parse(
        '$baseUrl${tipo == 'PUT' ? 'AtualizarEmpresas/${empresa?.id}' : 'SalvarEmpresas'}');

    try {
      print(empresaModel.toJson());
      final response = await (tipo == 'PUT'
          ? http.put(headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8'
            }, url, body: jsonEncode(empresaModel.toJson()))
          : http.post(headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8'
            }, url, body: jsonEncode(empresaModel.toJson())));

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Resposta da API: ${response.body}');
      } else {
        throw Exception(
            'Falha na requisição: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      throw Exception('Erro ao fazer a requisição: $e');
    }
  }
}
