import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gerapp_front/Helpers/Controles/entrada/appbar_grid.dart';
import 'package:gerapp_front/Helpers/Cores/cores.dart';
import 'package:gerapp_front/Helpers/conversor.dart';
import 'package:gerapp_front/Modulos/Repositorio/Cadastro/funcionario_repositorio.dart';
import 'package:gerapp_front/Modulos/Visoes/Cadastro/Form/Funcionario/funcionario_form_view.dart';
import 'package:gerapp_front/Modulos/modelos/Cadastro/funcionario_model.dart';

class FuncionarioGrid extends StatefulWidget {
  const FuncionarioGrid({super.key});

  @override
  State<FuncionarioGrid> createState() => _funcionarioGridState();
}

class _funcionarioGridState extends State<FuncionarioGrid> {
  TextEditingController _pesquisa = TextEditingController();
  List<FuncionarioModel> _funcionarios = [];
  List<FuncionarioModel> _filtrados = [];
  String? image = '';

  @override
  void initState() {
    _buscarTodosOsFuncionarios();
  }

  // void _pollingBuscarfuncionarios() {
  //   const duration = Duration(seconds: 0);
  //   Timer.periodic(duration, (Timer timer) {
  //     if (_pesquisa.text != '') _filtrarPorPesquisa(_pesquisa.text);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarGrid(
        controller: _pesquisa,
        funcaoAtualizar: () {
          _filtrarPorPesquisa(_pesquisa.text);
        },
        funcaoRota: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FuncionarioForm(null))).then((value) {
            _buscarTodosOsFuncionarios();
          });
        },
        hintNegativo: 'Sem funcionarios para exibir!',
        hintPositivo: 'Pesquise seu funcionario!',
        validaHint: _filtrados.isNotEmpty,
      ),
      body: ListView.builder(
          itemCount: _filtrados.length,
          itemBuilder: (context, index) {
            FuncionarioModel funcionario = _filtrados[index];
            return Card(
              child: ListTile(
                key: Key(funcionario.id.toString()),
                leading: funcionario.imagem != ''
                    ? CircleAvatar(
                        backgroundImage:
                            Conversor.convertBase64ToImage(funcionario.imagem),
                      )
                    : CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://cdn-icons-png.flaticon.com/512/1503/1503355.png'),
                      ),
                title: Text(
                  funcionario.nome,
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
                                  builder: (context) => FuncionarioForm(
                                      FuncionarioModel(
                                          id: funcionario.id ?? 0,
                                          nome: funcionario.nome ?? '',
                                          salario: funcionario.salario ?? 0,
                                          cargoId: funcionario.cargoId ?? 0,
                                          empresaId: funcionario.empresaId ?? 0,
                                          imagem: funcionario.imagem ?? '',
                                          usuarioFuncionario:
                                              funcionario.usuarioFuncionario,
                                          enderecoFuncionario:
                                              funcionario.enderecoFuncionario ??
                                                  [])))).then((value) {
                            _buscarTodosOsFuncionarios();
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
                                          FuncionarioRepositorio()
                                              .deleteFuncionario(
                                                  funcionario.id!);
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
                                                  _buscarTodosOsFuncionarios();
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
        List<FuncionarioModel> funcionarioFiltrado = _funcionarios
            .where((x) => x.nome.toLowerCase().contains(filtro.toLowerCase()))
            .toList();

        _filtrados = funcionarioFiltrado;
      });
    } else {
      setState(() {
        _filtrados = _funcionarios;
      });
    }
  }

  void _buscarTodosOsFuncionarios() async {
    List<FuncionarioModel> funcionarios =
        await FuncionarioRepositorio().GetAllFuncionarios();
    setState(() {
      _funcionarios = funcionarios;
      if (_filtrados.isEmpty && _pesquisa.text == '') {
        _filtrados = funcionarios;
      }
    });
  }
}
