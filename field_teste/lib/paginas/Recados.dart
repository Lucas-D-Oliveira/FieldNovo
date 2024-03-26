import 'package:flutter/material.dart';

class DialogUtils {
  static void mostrarTextFieldDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Pesquisar'),
          content: TextField(
            decoration: InputDecoration(
              hintText: 'Digite aqui...',
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Fechar'),
            ),
          ],
        );
      },
    );
  }
}

class Recados extends StatefulWidget {
  const Recados({Key? key}) : super(key: key);

  @override
  State<Recados> createState() => _RecadosState();
}

class _RecadosState extends State<Recados> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    );
  }
}
