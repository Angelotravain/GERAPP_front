import 'package:flutter/material.dart';
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
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Equipamentos'),
            leading: Icon(Icons.table_restaurant),
            onTap: () {
              Navigator.pop(context);
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
