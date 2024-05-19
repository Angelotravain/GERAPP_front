import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gerapp_front/Componentes_gerais/campo_valor_formatado.dart';
import 'package:gerapp_front/Helpers/Controles/Campos/text_field.dart';
import 'package:gerapp_front/Helpers/Controles/entrada/appbar_cadastros.dart';
import 'package:gerapp_front/Helpers/Controles/entrada/campo_toogle.dart';
import 'package:gerapp_front/Helpers/Controles/entrada/novo_combo.dart';
import 'package:gerapp_front/Helpers/Cores/cores.dart';
import 'package:gerapp_front/Helpers/LocalHttp.dart';
import 'package:gerapp_front/Helpers/conversor.dart';
import 'package:gerapp_front/Modulos/Cadastro/Cargo/cargo_model.dart';
import 'package:gerapp_front/Modulos/Cadastro/Empresa/empresa_model.dart';
import 'package:gerapp_front/Modulos/Cadastro/Veiculo/veiculo_model.dart';
import 'package:gerapp_front/Modulos/Cadastro/veiculo/veiculo_repositorio.dart';
import 'package:image_picker/image_picker.dart';

class VeiculoForm extends StatefulWidget {
  final VeiculoModel? veiculo;

  VeiculoForm({this.veiculo});

  @override
  State<VeiculoForm> createState() => _veiculoFormState();
}

class _veiculoFormState extends State<VeiculoForm> {
  TextEditingController _id = TextEditingController();
  TextEditingController _marca = TextEditingController();
  TextEditingController _modelo = TextEditingController();
  TextEditingController _ano = TextEditingController();
  TextEditingController _cor = TextEditingController();
  TextEditingController _placa = TextEditingController();
  TextEditingController _tipoCombustivel = TextEditingController();
  TextEditingController _kmPorLitro = TextEditingController();
  bool _manutencaoEmDia = false;
  TextEditingController _imagem = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    PreencherCampos(widget.veiculo ?? null);
  }

  void PreencherCampos(VeiculoModel? veiculo) {
    if (veiculo != null) {
      _id.text = veiculo.id.toString() ?? '';
      _ano.text = veiculo.ano.toString() ?? '';
      _cor.text = veiculo.cor ?? '';
      _imagem.text = veiculo.imagem ?? '';
      _kmPorLitro.text = veiculo.kmPorLitro.toString() ?? '';
      _manutencaoEmDia = veiculo.manutencaoEmDia ?? false;
      _placa.text = veiculo.placa ?? '';
      _modelo.text = veiculo.modelo ?? '';
      _marca.text = veiculo.marca ?? '';
      _tipoCombustivel.text = veiculo.tipoCombustivel ?? '';
      _kmPorLitro.text = veiculo.kmPorLitro.toString() ?? '';
    }
  }

  Future<void> getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    final bytes = await pickedFile?.readAsBytes();
    final base64Image = base64Encode(bytes!);
    setState(() {
      _imagem.text = base64Image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarCadastros(
          titulo: widget.veiculo != null
              ? 'Edite seu veículo!'
              : 'Cadastre seu veículo!',
          funcaoSalvar: () {
            VeiculoRepositorio().salvarEditar(
                widget.veiculo != null ? 'PUT' : 'POST',
                0,
                _marca.text,
                _modelo.text,
                2024,
                _cor.text,
                _placa.text,
                _tipoCombustivel.text,
                0,
                _manutencaoEmDia,
                _imagem.text ?? '',
                widget.veiculo != null ? widget.veiculo : null);
          },
          icone: widget.veiculo != null
              ? Icon(Icons.save_as, color: Cores.BRANCO)
              : Icon(Icons.save, color: Cores.BRANCO),
          toolTipEntrada: widget.veiculo != null ? 'Editar' : 'Salvar',
          tipoApp: widget.veiculo != null ? 'E' : 'I',
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  SizedBox(height: 10),
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      CircleAvatar(
                        radius: 100,
                        backgroundImage:
                            Conversor.convertBase64ToImage(_imagem.text),
                      ),
                      IconButton(
                          icon: Icon(Icons.add_a_photo), onPressed: getImage),
                    ],
                  ),
                ],
              ),
              CampoTexto(controller: _marca, label: 'Marca'),
              CampoTexto(controller: _modelo, label: 'Modelo'),
              CampoTexto(controller: _ano, label: 'Ano'),
              CampoTexto(controller: _cor, label: 'Cor'),
              CampoTexto(controller: _kmPorLitro, label: 'Km por litro'),
              CampoTexto(controller: _placa, label: 'Placa'),
              CampoTexto(
                  controller: _tipoCombustivel, label: 'tipo de combustível'),
              ToogleSelecao(
                  label: 'Manutenção está em dia?',
                  value: _manutencaoEmDia,
                  onChanged: (value) {
                    setState(() {
                      _manutencaoEmDia = value;
                    });
                  }),
            ],
          ),
        ));
  }
}
