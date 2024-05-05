import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gerapp_front/Helpers/Controles/entrada/appbar_grid.dart';
import 'package:gerapp_front/Helpers/Cores/cores.dart';
import 'package:gerapp_front/Helpers/fontes_cabecalho.dart';
import 'package:gerapp_front/Modulos/Repositorio/Cadastro/bairro_repositorio.dart';
import 'package:gerapp_front/Modulos/Visoes/Cadastro/Form/bairro_form_view.dart';
import 'package:gerapp_front/Modulos/modelos/Cadastro/bairro_model.dart';
import 'package:intl/intl.dart';

class BairroGrid extends StatefulWidget {
  BairroGrid({super.key});
  @override
  State<BairroGrid> createState() => _BairroGridState();
}

class _BairroGridState extends State<BairroGrid> {
  void atualizarEstado() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _buscarTodosOsBairros();
    _pollingBuscarBairros();
  }

  TextEditingController _pesquisa = TextEditingController();
  List<BairroModel> _bairros = [];
  List<BairroModel> _filtrados = [];

  void _buscarTodosOsBairros() async {
    List<BairroModel> bairros = await BairroRepositorio().GetAllBairros();
    setState(() {
      _bairros = bairros;
      if (_filtrados.isEmpty && _pesquisa.text == '') {
        _filtrados = bairros;
      }
    });
  }

  void _pollingBuscarBairros() {
    const duration = Duration(seconds: 0);
    Timer.periodic(duration, (Timer timer) {
      _buscarTodosOsBairros();
      _filtrarPorPesquisa(_pesquisa.text);
    });
  }

  void _filtrarPorPesquisa(String filtro) {
    if (filtro != null || filtro != '') {
      setState(() {
        List<BairroModel> bairroFiltrado = _bairros
            .where((x) => x.nome.toLowerCase().contains(filtro.toLowerCase()))
            .toList();

        _filtrados = bairroFiltrado;
      });
    } else {
      setState(() {
        _filtrados = _bairros;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarGrid(
          funcaoRota: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BairroForm(
                          validarFrete: false,
                        ))).then((value) {
              _buscarTodosOsBairros();
            });
          },
          funcaoAtualizar: () {
            _filtrarPorPesquisa(_pesquisa.text);
          },
          validaHint: _filtrados.isNotEmpty,
          hintPositivo: 'Pesquise seu bairro!',
          hintNegativo: 'Sem bairros!',
          controller: _pesquisa,
        ),
        body: ListView.builder(
            itemCount: _filtrados.length,
            itemBuilder: (context, index) {
              BairroModel bairro = _filtrados[index];
              return Card(
                child: ListTile(
                  title: Text(
                    bairro.nome,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  subtitle: Text(
                    'Taxa de entrega: ${NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(bairro.valorFrete)}',
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
                                    builder: (context) => BairroForm(
                                          bairro: bairro,
                                          validarFrete: bairro.isentaFrete,
                                        ))).then((value) {
                              _buscarTodosOsBairros();
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
                                      'Tem certeza que deseja excluir este bairro?'),
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
                                            BairroRepositorio()
                                                .deleteBairro(bairro.id!);
                                        showDialog(
                                          barrierColor: Cores.PRETO,
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('Exclusão de Bairro'),
                                              content: FutureBuilder<String>(
                                                future: deleteFuture,
                                                builder: (BuildContext context,
                                                    AsyncSnapshot<String>
                                                        snapshot) {
                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
                                                    return CircularProgressIndicator();
                                                  } else if (snapshot
                                                      .hasError) {
                                                    return Text(
                                                        'Erro: ${snapshot.error}');
                                                  } else {
                                                    _buscarTodosOsBairros();
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
            }));
  }
}
