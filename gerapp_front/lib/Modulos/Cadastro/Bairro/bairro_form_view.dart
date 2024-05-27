import 'package:flutter/material.dart';
import 'package:gerapp_front/Helpers/Controles/Campos/text_field.dart';
import 'package:gerapp_front/Helpers/Controles/entrada/appbar_cadastros.dart';
import 'package:gerapp_front/Helpers/Controles/entrada/campo_toogle.dart';
import 'package:gerapp_front/Helpers/Controles/entrada/novo_combo.dart';
import 'package:gerapp_front/Helpers/Controles/entrada/show_message.dart';
import 'package:gerapp_front/Helpers/Cores/cores.dart';
import 'package:gerapp_front/Helpers/LocalHttp.dart';
import 'package:gerapp_front/Modulos/Cadastro/Bairro/bairro_model.dart';
import 'package:gerapp_front/Modulos/Cadastro/Bairro/bairro_repositorio.dart';
import 'package:intl/intl.dart';

class BairroForm extends StatefulWidget {
  final BairroModel? bairro;
  final bool? validarFrete;

  const BairroForm({this.validarFrete, this.bairro});

  @override
  State<BairroForm> createState() => _BairroFormState();
}

class _BairroFormState extends State<BairroForm> {
  TextEditingController _nomeController = TextEditingController();
  TextEditingController _cidadeController = TextEditingController();
  TextEditingController _cidadeIdController = TextEditingController();
  TextEditingController _valorFreteController = TextEditingController();
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
      _cidadeIdController.text = bairro.cidadeId.toString();
      valorFrete = bairro.isentaFrete;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCadastros(
        titulo: widget.bairro != null
            ? 'Edite seu bairro!'
            : 'Cadastre seu bairro!',
        funcaoSalvar: () {
          if (_nomeController.text.isEmpty ||
              _valorFreteController.text.isEmpty ||
              _cidadeIdController.text.isEmpty) {
            ShowMessage.show(context, 'Preencha todos os campos para seguir!');
          } else {
            BairroRepositorio().salvarEditar(
                widget.bairro != null ? 'PUT' : 'POST',
                _nomeController.text,
                _valorFreteController.text.toString(),
                valorFrete != true ? false : true,
                int.parse(_cidadeIdController.text),
                widget.bairro);
            Navigator.pop(context);
          }
        },
        tipoApp: widget.bairro != null ? 'E' : 'I',
        icone: widget.bairro != null
            ? Icon(Icons.save_as, color: Cores.BRANCO)
            : Icon(Icons.save, color: Cores.BRANCO),
        toolTipEntrada: widget.bairro != null ? 'Editar' : 'Salvar',
      ),
      body: Container(
        child: ListView(
          children: [
            const Padding(padding: EdgeInsets.all(10)),
            CampoTexto(
              controller: _nomeController,
              label: 'Nome',
            ),
            const SizedBox(
              height: 10.0,
            ),
            CampoTexto(
              controller: _valorFreteController,
              label: 'R\$ Valor do Frete',
              maxLenght: 10,
            ),
            const SizedBox(
              height: 10.0,
            ),
            SingleChildScrollView(
              child: ComboPesquisavel(
                apiUrl: Local.URL_CIDADE_LISTA,
                controller: _cidadeController,
                id: _cidadeIdController,
                name: 'nome',
                identify: 'id',
                label: 'Pesquise sua cidade',
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            ToogleSelecao(
                label: 'Isentar frete para esse bairro?',
                value: valorFrete ?? false,
                onChanged: (value) {
                  setState(() {
                    valorFrete = value;
                  });
                }),
          ],
        ),
      ),
    );
  }
}
