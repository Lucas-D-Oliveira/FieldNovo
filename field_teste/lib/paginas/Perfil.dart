import 'package:flutter/material.dart';

class Perfil extends StatefulWidget {
  const Perfil({super.key});

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  Color base = Color(0xFF038C4C);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Alinhamento vertical central
          children: [

            CircleAvatar(
              radius: 100,
              backgroundImage: AssetImage(''),
            ),

            SizedBox(height: 20),

            Text(
              'Seu zé da padaria da esquina',
              style: TextStyle(
                fontSize: 25,
              ),
            ),

            SizedBox(height: 10),

            Text(
              'xxxxxxxxxx@gmail.com',
              style: TextStyle(
                fontSize: 25,
              ),
            ),

            SizedBox(height: 10),

            Text(
              'Pesquisador',
              style: TextStyle(
                fontSize: 25,
              ),
            ),

            SizedBox(height: 10),

            Text(
              'Agrometeorologia',
              style: TextStyle(
                fontSize: 25,
              ),
            ),

            SizedBox(height: 10),

            Text(
              'Londrina - PR',
              style: TextStyle(
                fontSize: 25,
              ),
            ),

            SizedBox(height: 60),

          ],
        ),
      ),

      floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 47.0,
            child: FloatingActionButton(
              onPressed: () {
                // Ação ao pressionar o botão esquerdo
                Navigator.pop(context);
              },
              backgroundColor: Colors.red, // Cor de fundo do botão esquerdo
              child: Icon(Icons.logout, color: Colors.white,), // Ícone do botão esquerdo
            ),
          ),
          Positioned(
            bottom: 0,
            right: 16.0,
            child: FloatingActionButton(
              onPressed: () {
                // Ação ao pressionar o botão direito
              },
              backgroundColor: base, // Cor de fundo do botão direito
              child: Icon(Icons.edit, color: Colors.white,), // Ícone do botão direito
            ),
          ),
        ],
      ),
    );
  }
}
