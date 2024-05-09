import 'package:flutter/material.dart';
import 'package:gerapp_front/Helpers/Cores/cores.dart';

class AppBarCadastros extends StatelessWidget implements PreferredSizeWidget {
  final String? titulo;
  final String? toolTipEntrada;
  final VoidCallback? funcaoSalvar;
  final Icon? icone;
  final String? tipoApp;

  AppBarCadastros(
      {this.titulo,
      this.funcaoSalvar,
      this.icone,
      this.toolTipEntrada,
      this.tipoApp});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(titulo!),
      backgroundColor: Cores.AZUL_FUNDO,
      actions: [
        Card(
          color: Cores.CINZA_CLARO,
          child: IconButton(
            onPressed: tipoApp == 'E'
                ? () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Confirmação'),
                          content: Text('Realmente deseja editar esse item?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Cancelar'),
                            ),
                            TextButton(
                              onPressed: () async {
                                Navigator.of(context).pop();
                                try {
                                  funcaoSalvar!();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Editado com sucesso!'),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                } catch (error) {}
                              },
                              child: Text('Confirmar'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                : funcaoSalvar!,
            icon: icone!,
            tooltip: toolTipEntrada,
          ),
        ),
      ],
    );
  }
}
