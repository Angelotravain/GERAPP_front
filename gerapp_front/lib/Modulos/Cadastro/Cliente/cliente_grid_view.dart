import 'dart:async';

import 'package:flutter/material.dart';
import '../../../Helpers/Controles/entrada/appbar_grid.dart';
import '../../../Helpers/Cores/cores.dart';
import '../../../Helpers/conversor.dart';
import 'cliente_form_view.dart';
import 'cliente_model.dart';
import 'cliente_repositorio.dart';

class ClienteGrid extends StatefulWidget {
  const ClienteGrid({super.key});

  @override
  State<ClienteGrid> createState() => _ClienteGridState();
}

class _ClienteGridState extends State<ClienteGrid> {
  TextEditingController _pesquisa = TextEditingController();
  List<ClienteModel> _clientes = [];
  List<ClienteModel> _filtrados = [];
  String? image = '';

  @override
  void initState() {
    _buscarTodosOsClientes();
    _pollingBuscarClientes();
  }

  void _pollingBuscarClientes() {
    const duration = Duration(seconds: 3);
    Timer.periodic(duration, (Timer timer) {
      _filtrarPorPesquisa(_pesquisa.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarGrid(
        controller: _pesquisa,
        funcaoAtualizar: () {
          _filtrarPorPesquisa(_pesquisa.text);
        },
        funcaoRota: () {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ClienteForm(null)))
              .then((value) {
            _buscarTodosOsClientes();
          });
        },
        hintNegativo: 'Sem clientes para exibir!',
        hintPositivo: 'Pesquise seu cliente!',
        validaHint: _filtrados.isNotEmpty,
      ),
      body: ListView.builder(
          itemCount: _filtrados.length,
          itemBuilder: (context, index) {
            ClienteModel cliente = _filtrados[index];
            return Card(
              child: ListTile(
                key: Key(cliente.id.toString()),
                leading: cliente.imagem != ''
                    ? CircleAvatar(
                        backgroundImage:
                            Conversor.convertBase64ToImage(cliente.imagem),
                      )
                    : CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://cdn-icons-png.flaticon.com/512/1503/1503355.png'),
                      ),
                title: Text(
                  cliente.nome,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                  ),
                ),
                subtitle: Text(
                  cliente.email,
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
                      color: Cores.AZUL_FUNDO,
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ClienteForm(cliente))).then((value) {
                            setState(() {
                              _buscarTodosOsClientes();
                            });
                          });
                        },
                        icon: Icon(Icons.edit),
                        color: Cores.BRANCO,
                        tooltip: 'Editar',
                      ),
                    ),
                    Card(
                      color: Cores.VERMELHO,
                      child: IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Confirmação'),
                                content: Text(
                                    'Tem certeza que deseja excluir este cargo?'),
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
                                      Future<String> deleteFuture =
                                          ClienteRepositorio()
                                              .deleteCliente(cliente.id!);
                                      showDialog(
                                        barrierColor: Cores.PRETO,
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Exclusão de Cargo'),
                                            content: FutureBuilder<String>(
                                              future: deleteFuture,
                                              builder: (BuildContext context,
                                                  AsyncSnapshot<String>
                                                      snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return CircularProgressIndicator();
                                                } else if (snapshot.hasError) {
                                                  return Text(
                                                      'Erro: ${snapshot.error}');
                                                } else {
                                                  _buscarTodosOsClientes();
                                                  return Text(
                                                      snapshot.data ?? '');
                                                }
                                              },
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Text('Confirmar'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: Icon(Icons.delete),
                        color: Cores.BRANCO,
                        tooltip: 'Excluir',
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  void _filtrarPorPesquisa(String filtro) {
    if (filtro != null && filtro != '') {
      setState(() {
        List<ClienteModel> bairroFiltrado = _clientes
            .where((x) => x.nome.toLowerCase().contains(filtro.toLowerCase()))
            .toList();

        _filtrados = bairroFiltrado;
      });
    } else {
      setState(() {
        _filtrados = _clientes;
      });
    }
  }

  void _buscarTodosOsClientes() async {
    List<ClienteModel> clientes = await ClienteRepositorio().GetAllClientes();
    setState(() {
      _clientes = clientes;
      if (_filtrados.isEmpty && _pesquisa.text == '') {
        _filtrados = clientes;
      }
    });
  }
}
