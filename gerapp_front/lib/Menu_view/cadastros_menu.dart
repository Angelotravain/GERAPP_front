import 'package:flutter/material.dart';
import 'package:gerapp_front/Modulos/Cadastro/Bairro/bairro_grid_view.dart';
import 'package:gerapp_front/Modulos/Cadastro/Cargo/cargo_grid_view.dart';
import 'package:gerapp_front/Modulos/Cadastro/Cliente/cliente_grid_view.dart';
import 'package:gerapp_front/Modulos/Cadastro/Empresa/empresa_grid_view.dart';
import 'package:gerapp_front/Modulos/Cadastro/Funcionario/funcionario_grid_view.dart';

class CadastrosMenu extends StatefulWidget {
  const CadastrosMenu({super.key});

  @override
  State<CadastrosMenu> createState() => _CadastrosMenuState();
}

class _CadastrosMenuState extends State<CadastrosMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ExpansionTile(
        title: Text('Cadastros'),
        children: [
          ListTile(
            leading: Icon(Icons.streetview),
            title: Text('Bairros'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BairroGrid()));
            },
          ),
          ListTile(
            leading: Icon(Icons.person_outlined),
            title: Text('Cargos'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CargoGrid()));
            },
          ),
          ListTile(
            leading: Icon(Icons.people_rounded),
            title: Text('Clientes'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ClienteGrid()));
            },
          ),
          ListTile(
            leading: Icon(Icons.chalet_sharp),
            title: Text('Empresa'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EmpresaGrid()));
            },
          ),
          ListTile(
            leading: Icon(Icons.emoji_people_outlined),
            title: Text('Funcionários'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FuncionarioGrid()));
            },
          ),
        ],
      ),
    );
  }
}
