import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gerapp_front/Helpers/LocalHttp.dart';
import 'package:http/http.dart' as http;

class CepService {
  static Future<Map<String, dynamic>> getDadosCep(String cep) async {
    final response = await http.get(Uri.parse(Local.BUSCA_CEP + '$cep'));

    print('response cep: ${response.body}');
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
          'Falha ao obter os dados do CEP. Código de status: ${response.statusCode}');
    }
  }

  void preencherDadosCep(
      TextEditingController cep,
      TextEditingController logradouro,
      TextEditingController complemento) async {
    try {
      final dadosCep = await CepService.getDadosCep(cep.text);
      cep.text = dadosCep['cep'];
      logradouro.text = dadosCep['logradouro'] ?? '';
      complemento.text = dadosCep['complemento'] ?? '';
    } catch (e) {
      print('Erro ao buscar dados do CEP: $e');
    }
  }
}
