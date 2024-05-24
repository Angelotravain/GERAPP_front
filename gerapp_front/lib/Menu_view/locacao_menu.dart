import 'package:flutter/material.dart';
import 'package:gerapp_front/Modulos/Cadastro/Equipamento/equipamento_grid_view.dart';
import 'package:gerapp_front/Modulos/Cadastro/TipoEquipamento/tipo_equipamento_grid_view.dart';
import 'package:gerapp_front/Modulos/Cadastro/Veiculo/veiculo_grid_view.dart';

class LocacaoMenu extends StatelessWidget {
  const LocacaoMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ExpansionTile(
        title: Text('Locação'),
        children: [
          ListTile(
            title: Text('Locações'),
            leading: Icon(Icons.auto_graph_outlined),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Tipos de equipamentos'),
            leading: Icon(Icons.chair),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TipoEquipamentoGrid()));
            },
          ),
          ListTile(
            title: Text('Equipamentos'),
            leading: Icon(Icons.table_restaurant),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EquipamentoGrid()));
            },
          ),
          ListTile(
            title: Text('Veículos'),
            leading: Icon(Icons.car_rental),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => veiculoGrid()));
            },
          ),
        ],
      ),
    );
  }
}
