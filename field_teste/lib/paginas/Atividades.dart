import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_idr/paginas/Coletando.dart';
import 'package:projeto_idr/paginas/Upload.dart';

import 'Teste2.dart';

class Atividades extends StatefulWidget {
  const Atividades({Key? key}) : super(key: key);

  @override
  State<Atividades> createState() => _AtividadesState();
}

class _AtividadesState extends State<Atividades> {
  Color base = Color(0xFF038C4C);
  List<DocumentSnapshot> atividadesDocs = []; // Lista para armazenar os DocumentSnapshots

  @override
  void initState() {
    super.initState();
    _carregarAtividades();
  }

  Future<void> _carregarAtividades() async {
    try {
      CollectionReference atividadesRef = FirebaseFirestore.instance.collection('atividades');
      QuerySnapshot querySnapshot = await atividadesRef.get();

      if (querySnapshot.docs.isNotEmpty) {
        setState(() {
          atividadesDocs = querySnapshot.docs; // Armazenando os DocumentSnapshots
        });
      }
    } catch (e) {
      print('Erro ao carregar atividades: $e');
    }
  }

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
              SizedBox(width: 60),
              Text("Atividades",
                  style: TextStyle(color: Colors.white, fontSize: 30)),
              SizedBox(width: 60),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Upload()),
                  );
                },
                icon: Icon(Icons.upload_file, size: 35, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
      body: atividadesDocs.isEmpty
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Column(
          children: atividadesDocs.map((doc) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            Map<String, dynamic>? cardAtiv = data['card'] as Map<String, dynamic>?;

            if (cardAtiv == null) {
              return Container(); // Se o cardAtiv for null, retornar um Container vazio
            }

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Coletando(
                      documentSnapshot: doc, // Passando o DocumentSnapshot como parâmetro
                    ),
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.only(
                    top: 20, bottom: 10, right: 10, left: 10),
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
                    Center(
                      child: Text(
                        cardAtiv['titulo_Ativ'] ?? 'Título não disponível',
                        style: TextStyle(color: Colors.black, fontSize: 30),
                      ),
                    ),
                    Center(
                      child: Text(
                        cardAtiv['titulo_Proj'] ?? 'Projeto não disponível',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                    SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Pesq. Responsável: ${cardAtiv['pesqResp'] ?? 'Não disponível'}",
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Município: ${cardAtiv['municipio'] ?? 'Não disponível'}",
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Local: ${cardAtiv['local'] ?? 'Não disponível'}",
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
