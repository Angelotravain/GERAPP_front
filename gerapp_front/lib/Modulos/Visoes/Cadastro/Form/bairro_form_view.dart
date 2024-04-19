import 'package:flutter/material.dart';
import 'package:gerapp_front/Modulos/Repositorio/Cadastro/cidade_repositorio.dart';
import 'package:gerapp_front/Modulos/modelos/Cadastro/bairro_model.dart';
import 'package:gerapp_front/Modulos/modelos/Cadastro/cidade_model.dart';

class BairroForm extends StatefulWidget {
  final BairroModel? bairro;

  const BairroForm({this.bairro});

  @override
  State<BairroForm> createState() => _BairroFormState();
}

class _BairroFormState extends State<BairroForm> {
  TextEditingController _nomeController = TextEditingController();
  TextEditingController _valorFreteController = TextEditingController();
  TextEditingController _IsentaFreteController = TextEditingController();
  TextEditingController _cidadeIdController = TextEditingController();
  final _selectedCityController = TextEditingController();
  late List<CidadeModel> _cidades = [];

  @override
  void initState() {
    super.initState();
    _carregarCidades();
  }

  Future<void> _carregarCidades() async {
    final cidade = await CidadeRepositorio().GetAllCidades();
    setState(() {
      _cidades = cidade;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.bairro != null
            ? 'Edite seu bairro!'
            : 'Cadastre seu bairro!'),
        backgroundColor: Colors.blueGrey,
        actions: [
          Card(
            color: Colors.blueAccent,
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                widget.bairro != null ? Icons.save_as : Icons.save,
                color: Colors.white,
              ),
              tooltip: widget.bairro != null ? 'Editar' : 'Salvar',
            ),
          ),
        ],
      ),
      body: Container(
        child: ListView(
          children: [
            Padding(padding: EdgeInsets.all(10)),
            TextFormField(
              controller: _nomeController,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
              ),
              decoration: InputDecoration(
                  hintText: 'Nome',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0))),
            ),
            TextFormField(
              controller: _valorFreteController,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
              ),
              decoration: InputDecoration(
                  hintText: 'R\$ Valor do Frete',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0))),
            ),
            Autocomplete<CidadeModel>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text.isEmpty) {
                  return const Iterable<CidadeModel>.empty();
                }
                return _cidades.where((cidade) {
                  return cidade.nome
                      .toLowerCase()
                      .contains(textEditingValue.text.toLowerCase());
                });
              },
              onSelected: (CidadeModel selection) {
                setState(() {
                  _selectedCityController.text = selection.nome;
                  _cidadeIdController.text = selection.id.toString();
                });
              },
              fieldViewBuilder: (BuildContext context,
                  TextEditingController fieldTextEditingController,
                  FocusNode fieldFocusNode,
                  VoidCallback onFieldSubmitted) {
                return TextFormField(
                  controller: fieldTextEditingController,
                  focusNode: fieldFocusNode,
                  onFieldSubmitted: (String value) {
                    onFieldSubmitted();
                  },
                  decoration: InputDecoration(
                    labelText: 'Cidade',
                    hintText: 'Faça a pesquisa da sua cidade',
                  ),
                );
              },
              optionsViewBuilder: (BuildContext context,
                  AutocompleteOnSelected<CidadeModel> onSelected,
                  Iterable<CidadeModel> options) {
                return Align(
                  alignment: Alignment.topLeft,
                  child: Material(
                    elevation: 4.0,
                    child: SizedBox(
                      height: 200.0,
                      child: ListView.builder(
                        padding: EdgeInsets.all(8.0),
                        itemCount: options.length,
                        itemBuilder: (BuildContext context, int index) {
                          final CidadeModel cidade = options.elementAt(index);
                          return GestureDetector(
                            onTap: () {
                              onSelected(
                                cidade,
                              );
                              setState(() {
                                _selectedCityController.text = cidade.nome;
                                _cidadeIdController.text = cidade.id.toString();
                              });
                            },
                            child: ListTile(
                              title: Text(cidade.nome),
                            ),
                          );
                        },
                      ),
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
