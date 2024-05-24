import 'package:flutter/material.dart';
import 'package:gerapp_front/Helpers/Controles/entrada/appbar_grid.dart';
import 'package:gerapp_front/Helpers/Controles/entrada/montar_lista.dart';
import 'package:gerapp_front/Helpers/LocalHttp.dart';
import 'package:gerapp_front/Modulos/Cadastro/Veiculo/veiculo_form_view.dart';
import 'package:gerapp_front/Modulos/Cadastro/Veiculo/veiculo_model.dart';
import 'package:gerapp_front/Modulos/Cadastro/veiculo/veiculo_repositorio.dart';

class veiculoGrid extends StatefulWidget {
  const veiculoGrid({super.key});

  @override
  State<veiculoGrid> createState() => _veiculoGridState();
}

class _veiculoGridState extends State<veiculoGrid> {
  TextEditingController _pesquisa = TextEditingController();

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarGrid(
        controller: _pesquisa,
        funcaoAtualizar: () {
          _pesquisa.text = '';
        },
        funcaoRota: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => VeiculoForm(
                        veiculo: null,
                      ))).then((value) {
            _pesquisa.text = '';
          });
        },
        hintNegativo: 'Sem veiculos para exibir!',
        hintPositivo: 'Pesquise seu veiculo!',
        validaHint: true,
      ),
      body: MontaLista(
        apiUrl: Local.URL_VEICULO,
        controller: _pesquisa,
        deleteFunction: (p0) {
          VeiculoRepositorio().deleteVeiculo(p0);
        },
        editFunction: (p0) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => VeiculoForm(
                        veiculo: VeiculoModel.fromJson(p0),
                      ))).then((value) {
            setState(() {
              _pesquisa.text = '';
            });
          });
        },
        title: 'modelo',
        subtitle: 'marca',
      ),
    );
  }
}
