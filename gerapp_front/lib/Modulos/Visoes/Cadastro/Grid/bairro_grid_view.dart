import 'package:flutter/material.dart';
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
    setState(() {
      // Coloque aqui as atualizações de estado necessárias
    });
  }

  @override
  void initState() {
    super.initState();
    _buscarTodosOsBairros();
  }

  TextEditingController _pesquisa = TextEditingController();
  List<BairroModel> _bairros = [];
  List<BairroModel> _filtrados = [];

  void _buscarTodosOsBairros() async {
    List<BairroModel> bairros = await BairroRepositorio().GetAllBairros();
    setState(() {
      _bairros = bairros;
      _filtrados = bairros;
    });
  }

  void _filtrarPorPesquisa(String filtro) {
    // verificar o porque de não filtrar
    if (filtro != null || filtro != '') {
      List<BairroModel> bairroFiltrado = _bairros
          .where((x) => x.nome.toLowerCase().contains(filtro.toLowerCase()))
          .toList();
      setState(() {
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
        appBar: AppBar(
          title: TextFormField(
            controller: _pesquisa,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
            ),
            decoration: InputDecoration(
                hintText: _filtrados.length >= 1
                    ? 'Pesquise seu bairro!'
                    : 'Sem bairros!',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0))),
          ),
          actions: [
            Card(
              color: Colors.blueAccent,
              child: IconButton(
                onPressed: () {
                  _filtrarPorPesquisa(_pesquisa.text.toString());
                },
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                tooltip: 'Pesquisar',
              ),
            ),
            Card(
              color: Colors.blueAccent,
              child: IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BairroForm()));
                },
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                tooltip: 'Adicionar',
              ),
            ),
          ],
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
                        color: Colors.blueAccent,
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BairroForm(
                                          bairro: bairro,
                                        )));
                          },
                          icon: Icon(Icons.edit),
                          color: Colors.white,
                          tooltip: 'Editar',
                        ),
                      ),
                      Card(
                        color: Colors.redAccent,
                        child: IconButton(
                          onPressed: () {
                            // Chamar a função para deletar o bairro e obter o resultado como um futuro
                            Future<String> deleteFuture =
                                BairroRepositorio().deleteBairro(bairro.id!);
                            showDialog(
                              barrierColor: Colors.black38,
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Exclusão de Bairro'),
                                  content: FutureBuilder<String>(
                                    future: deleteFuture,
                                    builder: (BuildContext context,
                                        AsyncSnapshot<String> snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return CircularProgressIndicator();
                                      } else if (snapshot.hasError) {
                                        return Text('Erro: ${snapshot.error}');
                                      } else {
                                        _buscarTodosOsBairros();
                                        return Text(snapshot.data ?? '');
                                      }
                                    },
                                  ),
                                );
                              },
                            );
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
            }));
  }
}
