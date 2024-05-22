import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Upload extends StatefulWidget {
  const Upload({super.key});

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  final CollectionReference activitiesCollection =
  FirebaseFirestore.instance.collection('atividades');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Atividades'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: activitiesCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<DocumentSnapshot> documents = snapshot.data!.docs;
            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) {
                final cardData = documents[index]['card'] as Map<String, dynamic>;
                final tituloAtiv = cardData['titulo_Ativ'] ?? 'Título não disponível';

                return ListTile(
                  title: Text(tituloAtiv),
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar atividades.'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
