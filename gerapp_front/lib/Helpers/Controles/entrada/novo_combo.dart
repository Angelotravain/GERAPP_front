import 'dart:convert';
import 'package:gerapp_front/Helpers/Cores/cores.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ComboPesquisavel extends StatefulWidget {
  final String apiUrl;
  final TextEditingController controller;
  final String label;
  final String name;
  final String identify;
  final TextEditingController id;

  ComboPesquisavel(
      {Key? key,
      required this.apiUrl,
      required this.controller,
      required this.name,
      required this.identify,
      required this.label,
      required this.id})
      : super(key: key);

  @override
  _ComboPesquisavelState createState() => _ComboPesquisavelState();
}

class _ComboPesquisavelState extends State<ComboPesquisavel> {
  late Future<List<dynamic>> _future;
  late List<dynamic> _items = [];
  late String _selectedItem;
  late String _label;
  late TextEditingController _searchController;
  bool _isSearching = false;
  late String _identificacao;
  late String _nome;
  late TextEditingController _id;

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.controller.text;
    _searchController = widget.controller;
    _id = widget.id;
    _label = widget.label;
    _nome = widget.name;
    _identificacao = widget.identify;
    _future = _fetchData();
    _validaEntradaId(widget.id.text);
  }

  Future<List<dynamic>> _fetchData() async {
    try {
      final response = await http.get(Uri.parse(widget.apiUrl));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        setState(() {
          _items = jsonData;
          if (!_items.any((item) => item[_identificacao] == _selectedItem)) {
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
        print(widget.apiUrl + 'PorId/$id');
        final response = await http.get(Uri.parse(widget.apiUrl + 'PorId/$id'));
        if (response.statusCode == 200) {
          final jsonData = json.decode(response.body);
          setState(() {
            _searchController.text = jsonData[_nome].toString();
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
      final nome = item[_nome]?.toString() ?? '';
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
                          labelText: _label,
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
                        title: Text(item[_nome].toString()),
                        onTap: () {
                          setState(() {
                            _id.text = item[_identificacao].toString();
                            _searchController.text = item[_nome].toString();
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
