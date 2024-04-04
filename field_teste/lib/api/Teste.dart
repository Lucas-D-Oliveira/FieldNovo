import 'package:flutter/material.dart';
import 'package:field_teste/api/api.dart';

class Teste extends StatefulWidget {
  const Teste({Key? key});

  @override
  State<Teste> createState() => _TesteState();
}

class _TesteState extends State<Teste> {
  List<String>? parcelas;
  List<String>? tratamentos;
  List<String>? repeticao;

  @override
  void initState() {
    super.initState();
    fetchAPI();
  }

  void fetchAPI() async {
    Map<String, dynamic> data = await API.fetch("coleta");
    setState(() {
      parcelas = (data['parcelas'] as List).cast<String>();
      tratamentos = (data['tratamentos'] as List).cast<String>();
      repeticao = (data['repeticao'] as List).cast<String>();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teste de Chamada de API'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (parcelas != null)
              ListTile(
                title: Text('Parcelas'),
                subtitle: Text(parcelas!.join(', ')),
              ),
            if (tratamentos != null)
              ListTile(
                title: Text('Tratamentos'),
                subtitle: Text(tratamentos!.join(', ')),
              ),
            if (repeticao != null)
              ListTile(
                title: Text('Repetições'),
                subtitle: Text(repeticao!.join(', ')),
              ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Teste(),
  ));
}
