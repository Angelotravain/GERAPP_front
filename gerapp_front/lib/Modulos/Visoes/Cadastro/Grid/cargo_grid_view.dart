import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gerapp_front/Helpers/Controles/entrada/appbar_cadastros.dart';
import 'package:gerapp_front/Helpers/Controles/entrada/appbar_grid.dart';
import 'package:gerapp_front/Helpers/Cores/cores.dart';
import 'package:gerapp_front/Modulos/Repositorio/Cadastro/cargo_repositorio.dart';
import 'package:gerapp_front/Modulos/Visoes/Cadastro/Form/cargo_form_view.dart';
import 'package:gerapp_front/Modulos/modelos/Cadastro/cargo_model.dart';

class CargoGrid extends StatefulWidget {
  const CargoGrid({super.key});

  @override
  State<CargoGrid> createState() => _CargoGridState();
}

TextEditingController _pesquisa = TextEditingController();
List<CargoModel> _cargos = [];
List<CargoModel> _filtrados = [];

class _CargoGridState extends State<CargoGrid> {
  @override
  void initState() {
    super.initState();
    _buscarTodosOsCargos();
    _pollingBuscarCargos();
  }

  void _buscarTodosOsCargos() async {
    List<CargoModel> cargos = await CargoRepositorio().GetAllCargos();
    setState(() {
      _cargos = cargos;
      if (_filtrados.isEmpty && _pesquisa.text == '') {
        _filtrados = cargos;
      }
    });
  }

  void _pollingBuscarCargos() {
    const duration = Duration(seconds: 0);
    Timer.periodic(duration, (Timer timer) {
      _buscarTodosOsCargos();
      _filtrarPorPesquisa(_pesquisa.text);
    });
  }

  void _filtrarPorPesquisa(String filtro) {
    if (filtro != null || filtro != '') {
      setState(() {
        List<CargoModel> bairroFiltrado = _cargos
            .where(
                (x) => x.descricao.toLowerCase().contains(filtro.toLowerCase()))
            .toList();

        _filtrados = bairroFiltrado;
      });
    } else {
      setState(() {
        _filtrados = _cargos;
      });
    }
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
                  MaterialPageRoute(builder: (context) => CargoForm(null)))
              .then((value) {
            _buscarTodosOsCargos();
          });
        },
        hintNegativo: 'Sem cargos para exibir!',
        hintPositivo: 'Pesquise seu cargo!',
        validaHint: _filtrados.isNotEmpty,
      ),
      body: ListView.builder(
          itemCount: _filtrados.length,
          itemBuilder: (context, index) {
            CargoModel cargo = _filtrados[index];
            return Card(
              child: ListTile(
                title: Text(
                  cargo.descricao,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                  ),
                ),
                subtitle: Text(
                  'Visualiza Auditoria?: ${cargo.acessaAuditoria ? 'Sim' : 'Não'} |' +
                      'Visualiza cadastro?: ${cargo.acessaCadastro ? 'Sim' : 'Não'} |' +
                      'Visualiza Configuração?: ${cargo.acessaConfiguracao ? 'Sim' : 'Não'} |' +
                      'Visualiza Financeiro?: ${cargo.acessaFinanceiro ? 'Sim' : 'Não'} |' +
                      'Visualiza Locação?: ${cargo.acessaLocacao ? 'Sim' : 'Não'} |' +
                      'Gera cadastros?: ${cargo.gerarCadastro ? 'Sim' : 'Não'} ',
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
                                  builder: (context) => CargoForm(CargoModel(
                                      id: cargo.id,
                                      acessaAuditoria: cargo.acessaAuditoria,
                                      acessaCadastro: cargo.acessaCadastro,
                                      acessaConfiguracao:
                                          cargo.acessaConfiguracao,
                                      acessaFinanceiro: cargo.acessaFinanceiro,
                                      acessaLocacao: cargo.acessaLocacao,
                                      descricao: cargo.descricao,
                                      gerarCadastro:
                                          cargo.gerarCadastro)))).then((value) {
                            _buscarTodosOsCargos();
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
                                          CargoRepositorio()
                                              .deleteCargo(cargo.id!);
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
                                                  _buscarTodosOsCargos();
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
}
