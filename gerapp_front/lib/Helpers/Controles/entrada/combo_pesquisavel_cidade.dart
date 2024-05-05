import 'package:flutter/material.dart';
import 'package:gerapp_front/Modulos/Repositorio/Cadastro/bairro_repositorio.dart';
import 'package:gerapp_front/Modulos/Repositorio/Cadastro/cidade_repositorio.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class CustomMultiSelectDropDown extends StatelessWidget {
  final MultiSelectController controller;
  final ValueItem? valorEntrada;

  const CustomMultiSelectDropDown(
      {Key? key, required this.controller, required this.valorEntrada})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (valorEntrada != null) {
      controller.options.add(valorEntrada!);
    }
    return MultiSelectDropDown.network(
      searchEnabled: true,
      optionTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily: 'Roboto',
      ),
      controller: controller,
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
      selectedOptions:
          controller.options.isNotEmpty ? [controller.options.first] : [],
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
      onOptionSelected: (options) {
        controller.options.add(options.first);
        if (options.isNotEmpty) {}
        BairroRepositorio().atualizaCidadeParaEnviar(options.first);
      },
    );
  }
}
