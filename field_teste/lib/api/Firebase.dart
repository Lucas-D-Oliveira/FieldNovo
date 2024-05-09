import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Firebase extends StatefulWidget {
  const Firebase({Key? key}) : super(key: key);

  @override
  State<Firebase> createState() => _FirebaseState();
}

class _FirebaseState extends State<Firebase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Atividades'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('atividades').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Mostra um indicador de carregamento enquanto os dados estão sendo carregados.
          }
          if (snapshot.hasError) {
            return Text('Erro ao carregar dados: ${snapshot.error}');
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data() as Map<String, dynamic>;
              return ListTile(
                title: Text(data['titulo']),
                subtitle: Text(data['descricao']),
                // Você pode adicionar mais campos conforme necessário
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
