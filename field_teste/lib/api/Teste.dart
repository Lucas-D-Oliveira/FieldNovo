import 'package:flutter/material.dart';


class Teste extends StatefulWidget {
  const Teste({super.key});

  @override
  State<Teste> createState() => _TesteState();
}

class _TesteState extends State<Teste> {
  Map<String, List<String>> parcelas = {};
  List<String> tratamentos = [];
  List<String> repeticao = [];
  List<String> variavel = [];


  int indexR = 0;
  int indexT = 0;
  int indexV = 0;
  Color iconeCor = Color(0xFF57636C);
  Color base = Color(0xFF038C4C);
  late TextEditingController textController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    _initializeData();
  }

  Future<void> _initializeData() async {
    await atualizarTextController();
  }


  Future<void> atualizarTextController() async {
    String chaveAtual = '${variavel.elementAt(indexV)}-${repeticao.elementAt(indexR)}-${tratamentos.elementAt(indexT)}';
    setState(() {
      textController.text = parcelas[chaveAtual]?.first ?? '';
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

  void _mostrarDialogo() {
    String textoBusca = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Pesquisar'),
                    const SizedBox(height: 20),
                    DropB(
                      initialValue: 'Tratamento',
                      onValueChanged: (value) {
                        setState(() {
                          // Aqui você pode adicionar lógica para lidar com a mudança de valor do dropdown
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      onChanged: (value) {
                        textoBusca = value;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Digite o termo de busca',
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancelar'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Aqui você pode adicionar lógica para lidar com a busca
                            Navigator.of(context).pop();
                          },
                          child: const Text('Buscar'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String chaveAtual = '${variavel.elementAt(indexV)}-${repeticao.elementAt(indexR)}-${tratamentos.elementAt(indexT)}';
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
                onPressed: () {

                },
                icon: Icon(Icons.photo_camera, size: 35, color: Colors.white),
              ),
            ],
          ),
        ),
      ),

      body: Container( ////////////FUNDO
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
                'Variável 1/5',
                style: TextStyle(fontSize: 20),
              ),
            ),

            LinearProgressIndicator(
              value: 1,
              minHeight: 20.0,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            ),

            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      indexV = indexV == 0 ? 0 : indexV - 1;
                      atualizarTextController();
                    });
                  },
                  icon: Icon(Icons.arrow_back_ios, size: 70, color: iconeCor),
                ),
                Text(
                  "${variavel.elementAt(indexV) ?? ''}",
                  style: TextStyle(fontSize: 30),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      indexV = indexV == (variavel.length - 1) ? (variavel.length - 1) : indexV + 1;
                      atualizarTextController();
                    });
                  },
                  icon: Icon(Icons.arrow_back_ios, size: 70, color: iconeCor, textDirection: TextDirection.rtl,),
                ),
              ],
            ),

            TextFormField(
              controller: textController,
              onChanged: (value) {
                setState(() {
                  parcelas[chaveAtual] = value.split(',');
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide(color: Colors.green)),
                hintText: 'Informe valor',
              ),
            ),

            Row(/////////////CHECK BOX
              children: [
                Container(
                  padding: EdgeInsets.only(left: 16.0), // Adicione o espaçamento desejado à esquerda
                  child: Checkbox(
                    value: false,
                    onChanged: (bool? value) {
                      // Lógica para lidar com a mudança de estado da caixa de seleção
                    },
                  ),
                ),
                Text(
                  'Deixar variável nula',
                  style: TextStyle(fontSize: 16.0), // Ajuste o tamanho do texto conforme necessário
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
                      atualizarTextController();
                    });
                  },
                  icon: Icon(Icons.arrow_back_ios, size: 70, color: iconeCor),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      "${repeticao.elementAt(indexR) ?? ''}",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      indexR = indexR == (repeticao.length - 1) ? (repeticao.length - 1) : indexR + 1;
                      atualizarTextController();
                    });
                  },
                  icon: Icon(Icons.arrow_back_ios, size: 70, color: iconeCor, textDirection: TextDirection.rtl,),
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
                      atualizarTextController();
                    });
                  },
                  icon: Icon(Icons.arrow_back_ios, size: 70, color: iconeCor),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      "${tratamentos.elementAt(indexT) ?? ''}",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      indexT = indexT == (tratamentos.length - 1) ? (tratamentos.length - 1) : indexT + 1;
                      atualizarTextController();
                    });
                  },
                  icon: Icon(Icons.arrow_back_ios, size: 70, color: iconeCor, textDirection: TextDirection.rtl,),
                ),
              ],
            ),

            SizedBox(height: 50),
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
              onPressed: () {
              },
              backgroundColor: base,
              child: Icon(Icons.save, color: Colors.white,),
            ),
          ),
        ],
      ),
    );
  }
}

class DropB extends StatefulWidget {
  final ValueChanged<String>? onValueChanged;
  final String initialValue;

  const DropB({Key? key, required this.initialValue, this.onValueChanged}) : super(key: key);

  @override
  State<DropB> createState() => _DropBState();
}

class _DropBState extends State<DropB> {
  late String dropValue;

  @override
  void initState() {
    super.initState();
    dropValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropValue,
      onChanged: (String? newValue) {
        setState(() {
          dropValue = newValue!;
          widget.onValueChanged?.call(dropValue);
        });
      },
      items: ['Tratamento', 'Repetição', 'Parcela']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      })
          .toList(),
    );
  }
}