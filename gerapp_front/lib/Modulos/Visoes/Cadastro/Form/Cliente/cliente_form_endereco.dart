import 'package:flutter/material.dart';
import 'package:gerapp_front/Helpers/Controles/Campos/text_field.dart';
import 'package:gerapp_front/Helpers/Controles/entrada/combo_pesquisavel_cidade.dart';
import 'package:gerapp_front/Helpers/Cores/cores.dart';
import 'package:gerapp_front/Modulos/modelos/Cadastro/bairro_model.dart';
import 'package:gerapp_front/Modulos/modelos/Cadastro/cliente_model.dart';
import 'package:gerapp_front/Modulos/modelos/Cadastro/endereco_model.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class ClienteFormEndereco extends StatefulWidget {
  final ClienteModel? bairro;
  final String? tipoCombo;
  final TextEditingController? logradouroCliente;
  final TextEditingController? cepCliente;
  final TextEditingController? numeroCliente;
  final TextEditingController? complemento;
  final int? clienteId;
  final List<EnderecoModel>? enderecoAdicionado;

  const ClienteFormEndereco(
      {Key? key,
      this.bairro,
      this.tipoCombo,
      this.logradouroCliente,
      this.cepCliente,
      this.complemento,
      this.numeroCliente,
      this.enderecoAdicionado,
      this.clienteId})
      : super(key: key);

  @override
  State<ClienteFormEndereco> createState() => _ClienteFormEnderecoState();
}

class _ClienteFormEnderecoState extends State<ClienteFormEndereco> {
  Future<BairroModel>? _bairroFuturo;
  final MultiSelectController _selecionarBairro = MultiSelectController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CampoTexto(
            controller: widget.cepCliente!,
            label: 'CEP',
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
          widget.bairro != null
              ? FutureBuilder<BairroModel>(
                  future: _bairroFuturo,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      print(snapshot.error);
                      return Text(
                          'Erro ao carregar bairros: ${snapshot.error}');
                    } else {
                      BairroModel bairro = snapshot.data!;
                      return CustomMultiSelectDropDown(
                        controller: _selecionarBairro,
                        localBuscaDados: widget.tipoCombo,
                        valorEntrada: ValueItem(
                          label: bairro.nome,
                          value: bairro.id,
                        ),
                      );
                    }
                  },
                )
              : CustomMultiSelectDropDown(
                  controller: _selecionarBairro,
                  valorEntrada: null,
                  localBuscaDados: widget.tipoCombo,
                ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              setState(() {
                if (widget.logradouroCliente!.text != '' &&
                    widget.numeroCliente!.text != '' &&
                    widget.complemento!.text != '' &&
                    widget.cepCliente!.text != '') {
                  widget.enderecoAdicionado!.add(
                    EnderecoModel(
                      id: 0,
                      logradouro: widget.logradouroCliente!.text,
                      numero: widget.numeroCliente!.text,
                      complemento: widget.complemento!.text,
                      cep: widget.cepCliente!.text,
                      bairroId:
                          int.parse(_selecionarBairro.options.first.value),
                      clienteId: widget.clienteId,
                    ),
                  );
                  widget.logradouroCliente!.text = '';
                  widget.numeroCliente!.text = '';
                  widget.complemento!.text = '';
                  widget.cepCliente!.text = '';
                }
              });
            },
            child: Text('Adicionar endereço na lista'),
          ),
          SizedBox(height: 20.0),
          Expanded(
            child: ListView.builder(
              itemCount: widget.enderecoAdicionado!.length,
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
                                var selecionado =
                                    widget.enderecoAdicionado!.elementAt(index);
                                widget.cepCliente!.text = selecionado.cep;
                                widget.logradouroCliente!.text =
                                    selecionado.logradouro;
                                widget.numeroCliente!.text = selecionado.numero;
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
    );
  }
}
