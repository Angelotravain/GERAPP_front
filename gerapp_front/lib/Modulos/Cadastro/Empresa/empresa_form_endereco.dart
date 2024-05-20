import 'package:flutter/material.dart';
import 'package:gerapp_front/Helpers/Controles/Campos/text_field.dart';
import 'package:gerapp_front/Helpers/bucacep.dart';
import 'package:gerapp_front/Modulos/Cadastro/Empresa/empresa_model.dart';

import '../../../Helpers/Controles/entrada/novo_combo.dart';
import '../../../Helpers/LocalHttp.dart';

class EmpresaFormEndereco extends StatefulWidget {
  final EmpresaModel? bairro;
  final TextEditingController logradouroEmpresa;
  final TextEditingController cepEmpresa;
  final TextEditingController numeroEmpresa;
  final TextEditingController complemento;
  final TextEditingController bairroController;
  final TextEditingController bairroId;
  final int? empresaId;

  const EmpresaFormEndereco(
      {Key? key,
      this.bairro,
      required this.logradouroEmpresa,
      required this.cepEmpresa,
      required this.complemento,
      required this.numeroEmpresa,
      this.empresaId,
      required this.bairroController,
      required this.bairroId})
      : super(key: key);

  @override
  State<EmpresaFormEndereco> createState() => _EmpresaFormEnderecoState();
}

class _EmpresaFormEnderecoState extends State<EmpresaFormEndereco> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CampoTexto(
              controller: widget.cepEmpresa!,
              label: 'CEP',
              sufix: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      CepService().preencherDadosCep(widget.cepEmpresa!,
                          widget.logradouroEmpresa!, widget.complemento!);
                    });
                  },
                  icon: Icon(Icons.search),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            CampoTexto(
                controller: widget.logradouroEmpresa!, label: 'Logradouro'),
            SizedBox(height: 20.0),
            CampoTexto(controller: widget.numeroEmpresa!, label: 'Número'),
            SizedBox(height: 20.0),
            CampoTexto(controller: widget.complemento!, label: 'Complemento'),
            SizedBox(height: 20.0),
            SingleChildScrollView(
              child: ComboPesquisavel(
                apiUrl: '${Local.localName}/api/Gerapp/Cadastro/ListarBairros',
                controller: widget.bairroController!,
                identify: 'id',
                name: 'nome',
                label: 'Pesquise seu bairro',
                id: widget.bairroId,
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
