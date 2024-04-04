import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:field_teste/api/api.dart';

class Coletando extends StatefulWidget {
  const Coletando({Key? key});

  @override
  State<Coletando> createState() => _ColetandoState();
}

class _ColetandoState extends State<Coletando> {
  int indexR = 0;
  int indexT = 0;
  int indexV = 0;
  Map<String, List<String>>? parcelas;
  List<String>? tratamentos;
  List<String>? repeticao;
  List<String>? variavel;
  Color iconeCor = Color(0xFF57636C);
  Color base = Color(0xFF038C4C);
  String dropdownValue = 'Tratamento';
  String? mensagemErro;
  bool variavelNula = false;

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  void carregarDados() async {
    Map<String, dynamic> data = await API.fetch("coleta");
    setState(() {
      parcelas = (data['parcelas'] as Map<String, dynamic>).map((key, value) => MapEntry(key, List<String>.from(value)));
      tratamentos = (data['tratamentos'] as List).cast<String>();
      repeticao = (data['repeticao'] as List).cast<String>();
      variavel = (data['variavel'] as List).cast<String>();
    });
  }

  String? encontrarParcela() {
    if (tratamentos != null && repeticao != null && parcelas != null) {
      for (final entry in parcelas!.entries) {
        if (entry.value[0] == tratamentos![indexT] && entry.value[1] == repeticao![indexR]) {
          return entry.key;
        }
      }
    }
    return null;
  }

  void buscar(String termo, String tipo) {
    int novoIndice = 0;
    bool encontrado = false;

    if (tipo == 'Tratamento') {
      novoIndice = tratamentos!.indexOf(termo);
      if (novoIndice != -1) {
        setState(() {
          indexT = novoIndice;
          mensagemErro = null;
        });
        encontrado = true;
      }
    } else if (tipo == 'Repetição') {
      novoIndice = repeticao!.indexOf(termo);
      if (novoIndice != -1) {
        setState(() {
          indexR = novoIndice;
          mensagemErro = null;
        });
        encontrado = true;
      }
    } else if (tipo == 'Parcela') {
      for (final entry in parcelas!.entries) {
        if (entry.key == termo) {
          setState(() {
            indexT = tratamentos!.indexOf(entry.value[0]);
            indexR = repeticao!.indexOf(entry.value[1]);
            mensagemErro = null;
          });
          encontrado = true;
          break;
        }
      }
    }

    if (!encontrado) {
      setState(() {
        mensagemErro = 'Item não encontrado';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String? parcelaEncontrada = encontrarParcela();
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
              SizedBox(width: 30),
              Text("Coleta de solo", style: TextStyle(color: Colors.white, fontSize: 30)),
              SizedBox(width: 40),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.photo_camera, size: 35, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.only(bottom: 20, top: 20, right: 10, left: 10),
        child: Column(
          children: [
            Center(
              child: Text(
                'Parcela ${parcelaEncontrada ?? ""}',
                style: TextStyle(fontSize: 25),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                'Variável ${indexV + 1}/${variavel?.length}',
                style: TextStyle(fontSize: 20),
              ),
            ),
            LinearProgressIndicator(
              value: (indexV + 1) / variavel!.length,
              minHeight: 20.0,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      indexV = indexV == 0 ? 0 : indexV - 1;
                    });
                  },
                  icon: Icon(Icons.arrow_back_ios, size: 70, color: iconeCor),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      "${variavel?[indexV] ?? ''}",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      indexV = indexV == (variavel!.length - 1) ? (variavel!.length - 1) : indexV + 1;
                    });
                  },
                  icon: Icon(Icons.arrow_forward_ios, size: 70, color: iconeCor),
                ),
              ],
            ),
            TextFormField(
              enabled: !variavelNula,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide(color: Colors.green)),
                hintText: 'Informe valor',
              ),
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Checkbox(
                    value: variavelNula,
                    onChanged: (bool? value) {
                      setState(() {
                        variavelNula = value ?? false;
                      });
                    },
                  ),
                ),
                Text(
                  'Deixar variável nula',
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
            SizedBox(height: 30),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      indexR = indexR == 0 ? 0 : indexR - 1;
                    });
                  },
                  icon: Icon(Icons.arrow_back_ios, size: 70, color: iconeCor),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      "${repeticao?[indexR] ?? ''}",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      indexR = indexR == (repeticao!.length - 1) ? (repeticao!.length - 1) : indexR + 1;
                    });
                  },
                  icon: Icon(Icons.arrow_forward_ios, size: 70, color: iconeCor),
                ),
              ],
            ),
            SizedBox(height: 30),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      indexT = indexT == 0 ? 0 : indexT - 1;
                    });
                  },
                  icon: Icon(Icons.arrow_back_ios, size: 70, color: iconeCor),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      "${tratamentos?[indexT] ?? ''}",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      indexT = indexT == (tratamentos!.length - 1) ? (tratamentos!.length - 1) : indexT + 1;
                    });
                  },
                  icon: Icon(Icons.arrow_forward_ios, size: 70, color: iconeCor),
                ),
              ],
            ),
            SizedBox(height: 10),
            if (mensagemErro != null)
              Text(
                mensagemErro!,
                style: TextStyle(color: Colors.red),
              ),
            SizedBox(height: 40),
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
                _mostrarDialogo();
              },
              backgroundColor: base,
              child: Icon(Icons.search, color: Colors.white,),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 16.0,
            child: FloatingActionButton(
              onPressed: () {},
              backgroundColor: base,
              child: Icon(Icons.save, color: Colors.white,),
            ),
          ),
        ],
      ),
    );
  }

  void _mostrarDialogo() {
    String textoBusca = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Pesquisar'),
                SizedBox(height: 20),
                DropdownButton<String>(
                  value: dropdownValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                  hint: Text(dropdownValue), // Atualiza o hint para refletir o valor selecionado
                  items: <String>['Tratamento', 'Repetição', 'Parcela']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),

                SizedBox(height: 20),
                TextField(
                  onChanged: (value) {
                    textoBusca = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'Digite o termo de busca',
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Cancelar'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        buscar(textoBusca, dropdownValue);
                        Navigator.of(context).pop();
                      },
                      child: Text('Buscar'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
