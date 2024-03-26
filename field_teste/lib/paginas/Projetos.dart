import 'package:field_teste/paginas/Coletando.dart';
import 'package:flutter/material.dart';
import 'Recados.dart';


class Projetos extends StatefulWidget {
  const Projetos({super.key});

  @override
  State<Projetos> createState() => _ProjetosState();
}

class _ProjetosState extends State<Projetos> {
  Color base = Color(0xFF038C4C);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: base,
        flexibleSpace: Container(
          padding: EdgeInsets.only(bottom: 0, top: 30, right: 13, left: 13),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back, size: 35, color: Colors.white),
              ),

              SizedBox(width: 75),

              Text("Projetos", style: TextStyle(color: Colors.white, fontSize: 30)),

              SizedBox(width: 75),

              IconButton(
                onPressed: () {
                  DialogUtils.mostrarTextFieldDialog(context);
                },
                icon: Icon(Icons.upload_file, size: 35, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Coletando()),
                    );
                  },
                  child: Container(
                  margin: EdgeInsets.only(top: 20, bottom: 10, right: 10, left: 10),
                  width: double.infinity,
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.black,
                      width: 3,
                    ),
                  ),
                  child: Column(
                    children: [
                      Center( //////////////PROJETO
                        child: Text(
                          "Plantação 2024 / A20",
                          style: TextStyle(color: Colors.black, fontSize: 30),
                        ),
                      ),

                      Center( //////////////ATIVIDADE
                        child: Text(
                          "Coleta de solo / A20-E21",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ),

                      SizedBox(height: 8),

                      Align(/////////////PESQUISADOR
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Pesq. Responsável: XXXXXXX",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ),

                      Align(////////////CIDADE
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Município: cidade1",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ),

                      Align(/////////////////LOCAL
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Local: fazenda1",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
