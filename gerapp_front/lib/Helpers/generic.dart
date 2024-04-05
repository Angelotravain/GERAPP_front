import 'dart:convert';
import 'package:http/http.dart' as http;

class Generic {
  final String apiUrl;
  final String metodoGet;

  Generic(this.apiUrl, this.metodoGet);

  Future<List<dynamic>> consumirApiGet() async {
    final cliente = http.Client(); // Inicializa um novo cliente HTTP
    try {
      final resposta = await cliente.get(Uri.parse(apiUrl + "/" + metodoGet));

      if (resposta.statusCode == 200) {
        final jsonData = json.decode(resposta.body);
        print(jsonData);
        return jsonData;
      } else {
        throw Exception('Falha ao executar a operação: ${resposta.statusCode}');
      }
    } catch (e) {
      throw Exception('Falha ao executar a operação: $e');
    } finally {
      cliente.close(); // Fecha o cliente HTTP após a conclusão da requisição
    }
  }

  Future<void> consumirApiPost(dynamic data) async {
    final cliente = http.Client();
    try {
      final resposta = await cliente.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );

      if (resposta.statusCode == 201) {
        final jsonData = json.decode(resposta.body);
        print(jsonData);
      } else {
        throw Exception('Falha ao executar a operação: ${resposta.statusCode}');
      }
    } catch (e) {
      throw Exception('Falha ao executar a operação: $e');
    } finally {
      cliente.close();
    }
  }

  Future<void> consumirApiDelete(String id) async {
    final cliente = http.Client();
    try {
      final resposta = await cliente.delete(
        Uri.parse('$apiUrl/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (resposta.statusCode == 200) {
        final jsonData = json.decode(resposta.body);
        print(jsonData);
      } else {
        throw Exception('Falha ao executar a operação: ${resposta.statusCode}');
      }
    } catch (e) {
      throw Exception('Falha ao executar a operação: $e');
    } finally {
      cliente.close();
    }
  }

  Future<void> consumirApiPut(String id, dynamic data) async {
    final cliente = http.Client();
    try {
      final resposta = await cliente.put(
        Uri.parse('$apiUrl/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );

      if (resposta.statusCode == 200) {
        final jsonData = json.decode(resposta.body);
        print(jsonData);
      } else {
        throw Exception('Falha ao executar a operação: ${resposta.statusCode}');
      }
    } catch (e) {
      throw Exception('Falha ao executar a operação: $e');
    } finally {
      cliente.close();
    }
  }
}

void main() {
  var contador = 6000;
  var pular = 0;
  final generic = Generic('https://localhost:7009/api/Gerapp/Cadastro',
      'ListarCidades?contador=$contador&pular=$pular');
  generic.consumirApiGet();

  // Exemplo de uso dos métodos
  // final data = {'name': 'Example'};
  // generic.post(data);
  // generic.delete('id');
  // generic.put('id', data);
}
