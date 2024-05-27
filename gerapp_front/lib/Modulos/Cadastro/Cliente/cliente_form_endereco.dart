import 'package:flutter/material.dart';
import 'package:gerapp_front/Helpers/Controles/entrada/novo_combo.dart';
import 'package:gerapp_front/Helpers/Cores/cores.dart';
import 'package:gerapp_front/Helpers/LocalHttp.dart';
import 'package:gerapp_front/Helpers/bucacep.dart';
import 'package:gerapp_front/Modulos/Cadastro/Endereco/endereco_model.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

import '../../../Helpers/Controles/Campos/text_field.dart';
import 'cliente_model.dart';

class ClienteFormEndereco extends StatefulWidget {
  final ClienteModel? bairro;
  final String? tipoCombo;
  final TextEditingController? logradouroCliente;
  final TextEditingController? cepCliente;
  final TextEditingController? numeroCliente;
  final TextEditingController? complemento;
  final int? clienteId;
  final List<EnderecoModel>? enderecoAdicionado;

  const ClienteFormEndereco({
    Key? key,
    this.bairro,
    this.tipoCombo,
    this.logradouroCliente,
    this.cepCliente,
    this.complemento,
    this.numeroCliente,
    this.enderecoAdicionado,
    this.clienteId,
  }) : super(key: key);

  @override
  State<ClienteFormEndereco> createState() => _ClienteFormEnderecoState();
}

class _ClienteFormEnderecoState extends State<ClienteFormEndereco> {
  final TextEditingController _bairroController = TextEditingController();
  final TextEditingController _bairroIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CampoTexto(
              controller: widget.cepCliente!,
              label: 'CEP',
              sufix: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      CepService().preencherDadosCep(widget.cepCliente!,
                          widget.logradouroCliente!, widget.complemento!);
                    });
                  },
                  icon: Icon(Icons.search),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            CampoTexto(
              controller: widget.logradouroCliente!,
              label: 'Logradouro',
            ),
            SizedBox(height: 20.0),
            CampoTexto(controller: widget.numeroCliente!, label: 'Número'),
            SizedBox(height: 20.0),
            CampoTexto(
              controller: widget.complemento!,
              label: 'Complemento',
            ),
            SizedBox(height: 20.0),
            ComboPesquisavel(
              apiUrl: Local.URL_BAIRRO,
              controller: _bairroController,
              name: 'nome',
              identify: 'id',
              label: 'Pesquise seu bairro',
              id: _bairroIdController,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (widget.logradouroCliente!.text.isNotEmpty &&
                      widget.numeroCliente!.text.isNotEmpty &&
                      widget.complemento!.text.isNotEmpty &&
                      widget.cepCliente!.text.isNotEmpty) {
                    widget.enderecoAdicionado!.add(
                      EnderecoModel(
                        id: 0,
                        logradouro: widget.logradouroCliente!.text,
                        numero: widget.numeroCliente!.text,
                        complemento: widget.complemento!.text,
                        cep: widget.cepCliente!.text,
                        bairroId: int.parse(_bairroIdController.text),
                        clienteId: widget.clienteId,
                      ),
                    );
                    widget.logradouroCliente!.clear();
                    widget.numeroCliente!.clear();
                    widget.complemento!.clear();
                    widget.cepCliente!.clear();
                    _bairroController.clear();
                    _bairroIdController.clear();
                  }
                });
              },
              child: Text('Adicionar endereço na lista'),
            ),
            SizedBox(height: 20.0),
            ListView.builder(
              shrinkWrap: true,
              itemCount: widget.enderecoAdicionado!.length,
              itemBuilder: (context, index) {
                var item = widget.enderecoAdicionado![index];
                return Card(
                  child: ListTile(
                    title: Text(item.logradouro + item.numero),
                    subtitle: Text(item.complemento!),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Card(
                          child: IconButton(
                            color: Cores.AZUL_FUNDO,
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              setState(() {
                                var selecionado =
                                    widget.enderecoAdicionado!.elementAt(index);
                                widget.cepCliente!.text = selecionado.cep!;
                                widget.logradouroCliente!.text =
                                    selecionado.logradouro;
                                widget.numeroCliente!.text = selecionado.numero;
                                widget.complemento!.text =
                                    selecionado.complemento!;
                                _bairroIdController.text =
                                    selecionado.bairroId.toString();
                                _bairroController.text =
                                    selecionado.bairroId.toString();
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
          ],
        ),
      ),
    );
  }
}
