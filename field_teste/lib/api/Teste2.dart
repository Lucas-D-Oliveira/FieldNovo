import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:field_teste/api/Teste.dart';
import 'package:field_teste/paginas/Coletando.dart';
import 'package:field_teste/paginas/Upload.dart';

class Teste2 extends StatefulWidget {
  const Teste2({Key? key}) : super(key: key);

  @override
  State<Teste2> createState() => _Teste2State();
}

class _Teste2State extends State<Teste2> {
  Color base = Color(0xFF038C4C);
  List<Map<String, dynamic>> dadosAtividades = [];

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
        List<DocumentSnapshot> documentos = querySnapshot.docs;
        dadosAtividades = documentos.map((doc) => doc.data() as Map<String, dynamic>).toList();
        setState(() {});
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
                icon: Icon(Icons.upload_file,
                    size: 35, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
      body: dadosAtividades.isEmpty
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Column(
          children: dadosAtividades.map((cardAtiv) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Coletando(
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
                        cardAtiv['tituloProj'], // Acessando as chaves do mapa
                        style:
                        TextStyle(color: Colors.black, fontSize: 30),
                      ),
                    ),
                    Center(
                      child: Text(
                        cardAtiv['tituloAtiv'], // Acessando as chaves do mapa
                        style:
                        TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                    SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Pesq. Responsável: ${cardAtiv['pesqResp']}", // Acessando as chaves do mapa
                        style:
                        TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Município: ${cardAtiv['municipio']}", // Acessando as chaves do mapa
                        style:
                        TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Local: ${cardAtiv['local']}", // Acessando as chaves do mapa
                        style:
                        TextStyle(color: Colors.black, fontSize: 15),
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
