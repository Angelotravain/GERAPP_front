import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gerapp_front/Helpers/Controles/entrada/montar_lista.dart';
import 'package:gerapp_front/Helpers/LocalHttp.dart';
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
      body: MontaLista(
          apiUrl: '${Local.localName}/api/Gerapp/Cadastro/ListarClientes',
          controller: _pesquisa,
          deleteFunction: (p0) {
            ClienteRepositorio().deleteCliente(p0);
          },
          editFunction: (p0) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ClienteForm(ClienteModel.fromMap(p0)))).then((value) {
              setState(() {
                _buscarTodosOsClientes();
              });
            });
          },
          subtitle: 'email',
          title: 'nome'),
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
