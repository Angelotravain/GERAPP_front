import 'package:flutter/material.dart';
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
  final List<EnderecoModel>? enderecoAdicionado;

  const ClienteFormEndereco(
      {Key? key,
      this.bairro,
      this.tipoCombo,
      this.logradouroCliente,
      this.cepCliente,
      this.complemento,
      this.numeroCliente,
      this.enderecoAdicionado})
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
          TextFormField(
            controller: widget.cepCliente,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
            ),
            decoration: InputDecoration(
              hintText: 'CEP',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              suffixIcon: Padding(
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
          ),
          SizedBox(height: 20.0),
          TextFormField(
            controller: widget.logradouroCliente,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
            ),
            decoration: InputDecoration(
              hintText: 'Logradouro',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
          SizedBox(height: 20.0),
          TextFormField(
            controller: widget.numeroCliente,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
            ),
            decoration: InputDecoration(
              hintText: 'Número',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
          SizedBox(height: 20.0),
          TextFormField(
            controller: widget.complemento,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
            ),
            decoration: InputDecoration(
              hintText: 'Complemento',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
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
                    logradouro: widget.logradouroCliente!.text,
                    numero: widget.numeroCliente!.text,
                    complemento: widget.complemento!.text,
                    cep: widget.cepCliente!.text,
                    bairroId: 0,
                  ),
                );
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
                    trailing: Card(
                      child: IconButton(
                        color: Cores.VERMELHO,
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            widget.enderecoAdicionado!.remove(index);
                          });
                        },
                      ),
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
