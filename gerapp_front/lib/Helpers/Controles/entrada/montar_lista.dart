import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MontaLista extends StatefulWidget {
  final String apiUrl;
  final String title;
  final String subtitle;
  final TextEditingController controller;
  final Function(dynamic) editFunction;
  final Function(dynamic) deleteFunction;

  MontaLista({
    required this.apiUrl,
    required this.title,
    required this.subtitle,
    required this.controller,
    required this.editFunction,
    required this.deleteFunction,
  });

  @override
  _MontaListaState createState() => _MontaListaState();
}

class _MontaListaState extends State<MontaLista> {
  late List<dynamic> _dataList;
  late TextEditingController _filterController;

  @override
  void initState() {
    super.initState();
    _dataList = [];
    _filterController = widget.controller;
    _filterController.addListener(() {
      _filterData(_filterController.text);
    });
    _fetchData();
    _polling();
  }

  void _polling() {
    const duration = Duration(seconds: 0);
    Timer.periodic(duration, (Timer timer) {
      _fetchData();
    });
  }

  Future<void> _fetchData() async {
    if (widget.controller.text == '') {
      final response = await http.get(Uri.parse(widget.apiUrl));
      if (response.statusCode == 200 || response.statusCode == 201) {
        setState(() {
          _dataList = json.decode(response.body);
        });
      } else {
        throw Exception('Falha ao carregar essa budega');
      }
    }
  }

  void _filterData(String value) {
    setState(() {
      if (value.isNotEmpty) {
        _dataList = _dataList
            .where((item) => item[widget.title]
                .toString()
                .toLowerCase()
                .contains(value.toLowerCase()))
            .toList();
      } else {
        _fetchData();
      }
    });
  }

  Future<void> _showDeleteConfirmationDialog(dynamic item) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmação'),
          content: Text('Tem certeza que deseja excluir este item?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await widget.deleteFunction(item['id']);
                _filterData(_filterController.text);
                _fetchData();
              },
              child: Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: _dataList.length,
            itemBuilder: (context, index) {
              dynamic item = _dataList[index];
              return Card(
                child: ListTile(
                  title: Text(
                    item[widget.title],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  subtitle: Text(
                    item[widget.subtitle] ?? '',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Card(
                        color: Colors.blue,
                        child: IconButton(
                          onPressed: () async {
                            await widget.editFunction(item);
                            _filterData(_filterController.text);
                            _fetchData();
                          },
                          icon: Icon(Icons.edit),
                          color: Colors.white,
                          tooltip: 'Editar',
                        ),
                      ),
                      Card(
                        color: Colors.red,
                        child: IconButton(
                          onPressed: () async {
                            await _showDeleteConfirmationDialog(item);
                          },
                          icon: Icon(Icons.delete),
                          color: Colors.white,
                          tooltip: 'Excluir',
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
