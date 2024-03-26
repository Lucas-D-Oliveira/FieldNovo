import 'package:flutter/material.dart';

class Banco extends StatefulWidget {
  const Banco({super.key});

  @override
  State<Banco> createState() => _BancoState();
}

class _BancoState extends State<Banco> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popup Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Confirmação'),
                  content: SizedBox(
                width: 500, // Definindo a largura do conteúdo
                height: 250, // Definindo a altura do conteúdo
                child: Text('Deseja continuar?'),
                      ),
                  actions: [
                    Container(
                      margin: EdgeInsets.only(right: 120), // Adicionando margem apenas ao botão "Sim"
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop('Sim'); // Fechar o popup e retornar 'Sim'
                        },
                        child: Text('Sim'),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 8.0), // Adicionando margem apenas ao botão "Não"
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop('Não'); // Fechar o popup e retornar 'Não'
                        },
                        child: Text('Não'),
                      ),
                    ),
                  ],
                );
              },
            );
          },
          child: Text('Mostrar Popup'),
        ),
      ),
    );
  }
}
