import 'package:flutter/material.dart';
import 'package:gerapp_front/Modulos/Repositorio/Cadastro/cidade_repositorio.dart';
import 'package:gerapp_front/Modulos/modelos/Cadastro/bairro_model.dart';
import 'package:gerapp_front/Modulos/modelos/Cadastro/cidade_model.dart';
import 'package:intl/intl.dart';
import 'package:multi_dropdown/models/value_item.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class BairroForm extends StatefulWidget {
  final BairroModel? bairro;
  final bool? validarFrete;

  const BairroForm({this.validarFrete, this.bairro});

  @override
  State<BairroForm> createState() => _BairroFormState();
}

class _BairroFormState extends State<BairroForm> {
  TextEditingController _nomeController = TextEditingController();
  TextEditingController _valorFreteController = TextEditingController();
  final MultiSelectController _selecionarCidade = MultiSelectController();
  late List<CidadeModel> _cidades = [];
  late ValueItem _cidadeSelecionada = ValueItem(label: '', value: null);
  late bool? valorFrete = null;

  @override
  void initState() {
    super.initState();
    VerificaBairroEdicao(widget.bairro);
  }

  void VerificaBairroEdicao(BairroModel? bairro) {
    if (bairro != null) {
      _nomeController.text = bairro.nome;
      _valorFreteController.text =
          NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$')
              .format(bairro.valorFrete);
      valorFrete = bairro.isentaFrete;
    }
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
            SizedBox(
              height: 10.0,
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
            SizedBox(
              height: 10.0,
            ),
            widget.bairro != null
                ? FutureBuilder<CidadeModel>(
                    future: CidadeRepositorio()
                        .GetCidadePorId(widget.bairro!.cidadeId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        print(snapshot.error);
                        return Text(
                            'Erro ao carregar cidades: ${snapshot.error}');
                      } else {
                        CidadeModel cidade = snapshot.data!;
                        return _buildMultiSelectDropDown(
                            ValueItem(label: cidade.nome, value: cidade.id));
                      }
                    },
                  )
                : _buildMultiSelectDropDown(null),
            SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                Checkbox(
                    value: valorFrete == null ? false : true,
                    onChanged: (valor) {
                      setState(() {
                        valorFrete = VerificaValor(valor);
                      });
                    }),
                Text('Isentar frete para esse bairro?'),
              ],
            )
          ],
        ),
      ),
    );
  }

  bool? VerificaValor(bool? entrada) {
    if (entrada == valorFrete) return null;
    return entrada;
  }

  Widget _buildMultiSelectDropDown(ValueItem? valor) {
    return MultiSelectDropDown.network(
      onOptionSelected: (options) {},
      searchEnabled: true,
      optionTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily: 'Roboto',
      ),
      controller: _selecionarCidade,
      borderRadius: 30.0,
      hint: 'Pesquise aqui sua cidade!',
      selectionType: SelectionType.single,
      searchLabel: 'Pesquise aqui sua cidade!',
      networkConfig: NetworkConfig(
        url:
            'https://localhost:7009/api/Gerapp/Cadastro/ListarCidades?contador=6000&pular=0',
        method: RequestMethod.get,
        headers: {'Content-Type': 'application/json'},
      ),
      chipConfig: const ChipConfig(wrapType: WrapType.wrap),
      selectedOptionIcon: const Icon(Icons.check_circle),
      selectedOptions: valor == null ? [] : [valor],
      responseParser: (response) {
        final list = (response as List<dynamic>).map((e) {
          final item = e as Map<String, dynamic>;
          return ValueItem(
            label: item['nome'],
            value: item['id'].toString(),
          );
        }).toList();
        return Future.value(list);
      },
      responseErrorBuilder: ((context, body) {
        return const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('Erro ao buscar dados'),
        );
      }),
    );
  }
}
