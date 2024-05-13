import 'package:flutter/material.dart';
import 'package:gerapp_front/Helpers/Controles/Campos/text_field.dart';
import 'package:gerapp_front/Helpers/Controles/entrada/combo_pesquisavel_cidade.dart';
import 'package:gerapp_front/Helpers/Cores/cores.dart';
import 'package:gerapp_front/Modulos/modelos/Cadastro/bairro_model.dart';
import 'package:gerapp_front/Modulos/modelos/Cadastro/funcionario_model.dart';
import 'package:gerapp_front/Modulos/modelos/Cadastro/endereco_model.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class FuncionarioFormEndereco extends StatefulWidget {
  final FuncionarioModel? bairro;
  final String? tipoCombo;
  final TextEditingController? logradourofuncionario;
  final TextEditingController? cepfuncionario;
  final TextEditingController? numerofuncionario;
  final TextEditingController? complemento;
  final int? funcionarioId;
  final List<EnderecoModel>? enderecoAdicionado;

  const FuncionarioFormEndereco(
      {Key? key,
      this.bairro,
      this.tipoCombo,
      this.logradourofuncionario,
      this.cepfuncionario,
      this.complemento,
      this.numerofuncionario,
      this.enderecoAdicionado,
      this.funcionarioId})
      : super(key: key);

  @override
  State<FuncionarioFormEndereco> createState() =>
      _funcionarioFormEnderecoState();
}

class _funcionarioFormEnderecoState extends State<FuncionarioFormEndereco> {
  Future<BairroModel>? _bairroFuturo;
  final MultiSelectController _selecionarBairro = MultiSelectController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CampoTexto(
            controller: widget.cepfuncionario!,
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
            controller: widget.logradourofuncionario!,
            label: 'Logradouro',
          ),
          SizedBox(height: 20.0),
          CampoTexto(controller: widget.numerofuncionario!, label: 'Número'),
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
                widget.enderecoAdicionado!.add(
                  EnderecoModel(
                    id: 0,
                    logradouro: widget.logradourofuncionario!.text,
                    numero: widget.numerofuncionario!.text,
                    complemento: widget.complemento!.text,
                    cep: widget.cepfuncionario!.text,
                    bairroId: int.parse(_selecionarBairro.options.first.value),
                    funcionarioId: widget.funcionarioId,
                  ),
                );
                widget.logradourofuncionario!.text = '';
                widget.numerofuncionario!.text = '';
                widget.complemento!.text = '';
                widget.cepfuncionario!.text = '';
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
                                widget.cepfuncionario!.text = selecionado.cep;
                                widget.logradourofuncionario!.text =
                                    selecionado.logradouro;
                                widget.numerofuncionario!.text =
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
    );
  }
}
