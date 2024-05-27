import 'dart:convert';
import 'package:gerapp_front/Modulos/Cadastro/Endereco/endereco_model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../../Helpers/LocalHttp.dart';
import 'empresa_model_novo.dart';

class EmpresaRepositorio {
  static String baseUrl = '${Local.localName}/api/Gerapp/Cadastro/';

  Future<List<EmpresaModelNovo>> GetAllEmpresas() async {
    final response = await http.get(Uri.parse('$baseUrl/ListarEmpresas'));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      List<EmpresaModelNovo> empresas =
          jsonData.map((e) => EmpresaModelNovo.fromJson(e)).toList();

      return empresas;
    } else {
      throw Exception('Falha ao buscar dados no servidor');
    }
  }

  Future<String> deleteEmpresa(int id) async {
    final response =
        await http.delete(Uri.parse('$baseUrl/ExcluirEmpresas/$id'));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception(
          'Falha ao excluir a Empresa. Código de status: ${response.statusCode}');
    }
  }

  Future<void> salvarEditar(
    String tipo,
    String nome,
    String? logoEmpresa,
    String? cnpjEmpresa,
    DateTime? dataFundacaoEmpresa,
    bool? ehFilial,
    String? emailEmpresa,
    EnderecoModel enderecoEmpresa,
    int estadoId,
    int? numeroFuncionariosEmpresa,
    String? proprietarioEmpresa,
    String? ramoAtuacaoEmpresa,
    String telefoneEmpresa,
    String? webSiteEmpresa,
    EmpresaModelNovo? empresa,
  ) async {
    final DateFormat formatter = DateFormat('yyyy-MM-ddTHH:mm:ss');
    final String formattedDataFundacao = dataFundacaoEmpresa != null
        ? formatter.format(dataFundacaoEmpresa)
        : '';

    final empresaModel = EmpresaModelNovo(
      id: empresa != null ? empresa!.id : 0,
      nome: nome,
      logoEmpresa: logoEmpresa!,
      cnpj: cnpjEmpresa!,
      dataCadastro: DateTime.now(),
      dataFundacao: DateTime.parse(formattedDataFundacao),
      ehFilial: ehFilial!,
      email: emailEmpresa!,
      enderecoEmpresa: enderecoEmpresa,
      numeroFuncionarios: numeroFuncionariosEmpresa!,
      proprietario: proprietarioEmpresa!,
      ramoAtuacao: ramoAtuacaoEmpresa!,
      telefone: telefoneEmpresa,
      website: webSiteEmpresa!,
    );

    final url = Uri.parse(
        '$baseUrl${tipo == 'PUT' ? 'AtualizarEmpresas/${empresa!.id}' : 'SalvarEmpresas'}');

    try {
      final response = await (tipo == 'PUT'
          ? http.put(
              url,
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8'
              },
              body: jsonEncode(empresaModel.toJson()),
            )
          : http.post(
              url,
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8'
              },
              body: jsonEncode(empresaModel.toJson()),
            ));

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
