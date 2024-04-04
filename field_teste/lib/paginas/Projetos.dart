import 'package:flutter/material.dart';
import 'package:field_teste/api/api.dart';
import 'package:field_teste/paginas/Coletando.dart';

class Projetos extends StatefulWidget {
  const Projetos({Key? key}) : super(key: key);

  @override
  State<Projetos> createState() => _ProjetosState();
}

class _ProjetosState extends State<Projetos> {
  Color base = Color(0xFF038C4C);
  late Future<Map<String, dynamic>?> _dadosFuture;

  @override
  void initState() {
    super.initState();
    _dadosFuture = API.fetch("projeto"); // Alteração aqui para "projeto"
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
              SizedBox(width: 75),
              Text("Projetos", style: TextStyle(color: Colors.white, fontSize: 30)),
              SizedBox(width: 75),
              IconButton(
                onPressed: () {
                  // Adicione aqui a ação do botão de upload de arquivo
                },
                icon: Icon(Icons.upload_file, size: 35, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: _dadosFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar dados da API: ${snapshot.error}'));
          } else {
            final dados = snapshot.data!;
            final projetosAPI = ProjetosAPI.fromJson(dados); // Correção aqui
            return ListView(
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
                              Center(
                                child: Text(
                                  projetosAPI.tituloProj ?? "",
                                  style: TextStyle(color: Colors.black, fontSize: 30),
                                ),
                              ),
                              Center(
                                child: Text(
                                  projetosAPI.tituloAtiv ?? "",
                                  style: TextStyle(color: Colors.black, fontSize: 20),
                                ),
                              ),
                              SizedBox(height: 8),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Pesq. Responsável: ${projetosAPI.pesqResp ?? ""}",
                                  style: TextStyle(color: Colors.black, fontSize: 15),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Município: ${projetosAPI.municipio ?? ""}",
                                  style: TextStyle(color: Colors.black, fontSize: 15),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Local: ${projetosAPI.local ?? ""}",
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
            );
          }
        },
      ),
    );
  }
}
