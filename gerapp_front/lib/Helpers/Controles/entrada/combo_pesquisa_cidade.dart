import 'dart:convert';
import 'package:gerapp_front/Helpers/Cores/cores.dart';
import 'package:gerapp_front/Helpers/LocalHttp.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ComboCidade extends StatefulWidget {
  final TextEditingController controller;
  final TextEditingController id;

  ComboCidade({Key? key, required this.controller, required this.id})
      : super(key: key);

  @override
  _ComboPesquisavelState createState() => _ComboPesquisavelState();
}

class _ComboPesquisavelState extends State<ComboCidade> {
  late Future<List<dynamic>> _future;
  late List<dynamic> _items = [];
  late String _selectedItem;
  late TextEditingController _searchController;
  bool _isSearching = false;
  late TextEditingController _id;

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.controller.text;
    _searchController = widget.controller;
    _id = widget.id;
    _future = _fetchData();
    _validaEntradaId(widget.id.text);
  }

  Future<List<dynamic>> _fetchData() async {
    try {
      final response = await http.get(Uri.parse(
          '${Local.localName}/api/Gerapp/Cadastro/ListarCidades?contador=6000&pular=0'));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        setState(() {
          _items = jsonData;
          if (!_items.any((item) => item['id'] == _selectedItem)) {
            _selectedItem = _items.isNotEmpty ? _items[0]['id'].toString() : '';
          }
        });
        print(jsonData);
        return jsonData;
      } else {
        throw Exception('Falha ao carregar dados da API');
      }
    } catch (e) {
      throw Exception('Erro: $e');
    }
  }

  Future<void> _validaEntradaId(String id) async {
    try {
      if (id != '') {
        print('${Local.localName}/api/Gerapp/Cadastro/ListarCidadesPorId/$id');
        final response = await http.get(Uri.parse(
            '${Local.localName}/api/Gerapp/Cadastro/ListarCidades?contador=6000&pular=0'));
        if (response.statusCode == 200) {
          final jsonData = json.decode(response.body);
          setState(() {
            _searchController.text = _items[0]['nome'].toString();
          });
        } else {
          throw Exception('Falha ao carregar dados da API');
        }
      }
    } catch (e) {
      throw Exception('Erro: $e');
    }
  }

  List<dynamic> _filterItems(String query) {
    return _items.where((item) {
      final nome = item['nome']?.toString() ?? '';
      return nome.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erro: ${snapshot.error}'));
        } else {
          List<dynamic> items = snapshot.data ?? [];
          _items = items;

          return Column(
            children: [
              Column(
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _searchController,
                        onChanged: (value) {
                          setState(() {
                            _isSearching = value.isNotEmpty;
                          });
                        },
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _searchController.text = '';
                              });
                            },
                            icon: Icon(_searchController.text == ''
                                ? Icons.close
                                : Icons.check_circle),
                            color: _searchController.text == ''
                                ? Cores.VERMELHO
                                : Cores.VERDE,
                          ),
                          labelText: 'Pesquise sua cidade',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (_isSearching)
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _filterItems(_searchController.text).length,
                    itemBuilder: (context, index) {
                      final item = _filterItems(_searchController.text)[index];
                      return ListTile(
                        title: Text(item['nome'].toString()),
                        onTap: () {
                          setState(() {
                            _id.text = item['id'].toString();
                            _searchController.text = item['nome'].toString();
                            _isSearching = false;
                          });
                        },
                      );
                    },
                  ),
                ),
            ],
          );
        }
      },
    );
  }
}
