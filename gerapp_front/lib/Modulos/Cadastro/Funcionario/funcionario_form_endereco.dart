import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gerapp_front/Helpers/Controles/Campos/text_field.dart';
import 'package:gerapp_front/Helpers/Controles/entrada/novo_combo.dart';
import 'package:gerapp_front/Helpers/Cores/cores.dart';
import 'package:gerapp_front/Helpers/LocalHttp.dart';
import 'package:gerapp_front/Modulos/Cadastro/Bairro/bairro_model.dart';
import 'package:gerapp_front/Modulos/Cadastro/Endereco/endereco_model.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

import 'funcionario_model.dart';

class FuncionarioFormEndereco extends StatefulWidget {
  final FuncionarioModel? bairro;
  final TextEditingController logradouroFuncionario;
  final TextEditingController cepFuncionario;
  final TextEditingController numeroFuncionario;
  final TextEditingController complemento;
  final TextEditingController bairroController;
  final TextEditingController bairroId;
  final int? FuncionarioId;
  final List<EnderecoModel>? enderecoAdicionado;

  const FuncionarioFormEndereco(
      {Key? key,
      this.bairro,
      required this.logradouroFuncionario,
      required this.cepFuncionario,
      required this.complemento,
      required this.numeroFuncionario,
      this.enderecoAdicionado,
      this.FuncionarioId,
      required this.bairroController,
      required this.bairroId})
      : super(key: key);

  @override
  State<FuncionarioFormEndereco> createState() =>
      _FuncionarioFormEnderecoState();
}

class _FuncionarioFormEnderecoState extends State<FuncionarioFormEndereco> {
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
              controller: widget.cepFuncionario!,
              label: 'CEP',
              validate: true,
              sufix: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Caiu aqui'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  icon: Icon(Icons.search),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            CampoTexto(
                controller: widget.logradouroFuncionario!,
                label: 'Logradouro',
                validate: true),
            SizedBox(height: 20.0),
            CampoTexto(controller: widget.numeroFuncionario!, label: 'Número'),
            SizedBox(height: 20.0),
            CampoTexto(
                controller: widget.complemento!,
                label: 'Complemento',
                validate: true),
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
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (widget.logradouroFuncionario!.text != '' &&
                      widget.numeroFuncionario!.text != '' &&
                      widget.complemento!.text != '' &&
                      widget.cepFuncionario!.text != '') {
                    widget.enderecoAdicionado!.add(
                      EnderecoModel(
                        id: 0,
                        logradouro: widget.logradouroFuncionario!.text,
                        numero: widget.numeroFuncionario!.text,
                        complemento: widget.complemento!.text,
                        cep: widget.cepFuncionario!.text,
                        bairroId: int.parse(widget.bairroId.text),
                        funcionarioId: widget.FuncionarioId,
                      ),
                    );
                    widget.logradouroFuncionario!.text = '';
                    widget.numeroFuncionario!.text = '';
                    widget.complemento!.text = '';
                    widget.cepFuncionario!.text = '';
                    widget.bairroController.text = '';
                  }
                  ;
                });
              },
              child: Text('Adicionar endereço na lista'),
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: ListView.builder(
                itemCount: widget.enderecoAdicionado != null
                    ? widget.enderecoAdicionado!.length
                    : 0,
                itemBuilder: (context, index) {
                  var item = widget.enderecoAdicionado![index];
                  return Card(
                    child: ListTile(
                      title: Text(item.logradouro + item.numero ?? ''),
                      subtitle: Text(item.complemento),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Card(
                            child: IconButton(
                              color: Cores.AZUL_FUNDO,
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                setState(() {
                                  var selecionado = widget.enderecoAdicionado!
                                      .elementAt(index);
                                  widget.cepFuncionario!.text = selecionado.cep;
                                  widget.logradouroFuncionario!.text =
                                      selecionado.logradouro;
                                  widget.numeroFuncionario!.text =
                                      selecionado.numero;
                                  widget.complemento!.text =
                                      selecionado.complemento;
                                  widget.enderecoAdicionado!.removeAt(index);
                                });
                              },
                            ),
                          ),
                          SizedBox(width: 20),
                          Card(
                            child: IconButton(
                              color: Cores.VERMELHO,
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                setState(() {
                                  widget.enderecoAdicionado!.removeAt(index);
                                });
                              },
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
        ),
      ),
    ));
  }
}
