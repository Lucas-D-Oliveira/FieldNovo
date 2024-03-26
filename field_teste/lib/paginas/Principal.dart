import 'package:field_teste/paginas/HomeP.dart';
import 'package:field_teste/paginas/Perfil.dart';
import 'package:field_teste/paginas/Recados.dart';
import 'package:flutter/material.dart';

class Principal extends StatefulWidget {
  const Principal({super.key});

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  int indice = 0;
  Color iconeCor = Color(0xFF57636C);
  Color base = Color(0xFF038C4C);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: base,
        title: Text(
          "Bem Vindo Lucas",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: IndexedStack(
        index: indice,
        children: <Widget>[
          HomeP(),
          Perfil(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: base,
        currentIndex: indice,
        fixedColor: Colors.white,
        unselectedItemColor: iconeCor,
        type: BottomNavigationBarType.fixed,
        onTap: (indiceB) {
          setState(() {
            indice = indiceB;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: ("Inicio"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded),
            label: ("Perfil"),
          ),
        ],
      ),
    );
  }
}
