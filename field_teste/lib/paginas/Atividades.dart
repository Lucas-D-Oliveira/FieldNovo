import 'package:field_teste/api/Teste.dart';
import 'package:field_teste/paginas/Coletando.dart';
import 'package:flutter/material.dart';
import 'package:field_teste/api/api.dart';
import 'package:field_teste/paginas/Perfil.dart';
import 'package:field_teste/paginas/Upload.dart';

class Atividades extends StatefulWidget {
  const Atividades({Key? key}) : super(key: key);

  @override
  State<Atividades> createState() => _AtividadesState();
}

class _AtividadesState extends State<Atividades> {
  Color base = Color(0xFF038C4C);
  late Future<List<AtividadesEColeta>> _dadosFuture;

  @override
  void initState() {
    super.initState();
    _dadosFuture = API.fetchAtividades();
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
              Text("Atividades", style: TextStyle(color: Colors.white, fontSize: 30)),
              SizedBox(width: 60),
              IconButton(
                onPressed: () {
                  // Adicione aqui a ação do botão de upload de arquivo
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
      body: FutureBuilder<List<AtividadesEColeta>>(
        future: _dadosFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar dados da API: ${snapshot.error}'));
          } else {
            final List<AtividadesEColeta> atividadesAPI = snapshot.data!;
            print('Dados recebidos da API: $atividadesAPI');
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        for (final atividadeEColeta in atividadesAPI)
                          GestureDetector(
                            onTap: () {
                              // Navegue para a página de perfil passando os dados necessários
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Coletando(
                                    atividadesEColeta: atividadeEColeta,
                                  ),
                                ),
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
                                      atividadeEColeta.atividade.tituloProj,
                                      style: TextStyle(color: Colors.black, fontSize: 30),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      atividadeEColeta.atividade.tituloAtiv,
                                      style: TextStyle(color: Colors.black, fontSize: 20),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Pesq. Responsável: ${atividadeEColeta.atividade.pesqResp}",
                                      style: TextStyle(color: Colors.black, fontSize: 15),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Município: ${atividadeEColeta.atividade.municipio}",
                                      style: TextStyle(color: Colors.black, fontSize: 15),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Local: ${atividadeEColeta.atividade.local}",
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
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 16, top: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(base)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Upload()),
                          );
                        },
                        child: Text('Enviar Arquivos', style: TextStyle(color: Colors.white)),
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
