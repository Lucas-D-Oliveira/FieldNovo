import 'dart:convert';
import 'package:field_teste/paginas/Atividades.dart';
import 'package:flutter/material.dart';
import '../api/api.dart';

class Teste extends StatefulWidget {
  final atividade;

  const Teste({Key? key, required this.atividade}) : super(key: key);

  @override
  State<Teste> createState() => _TesteState();
}

class _TesteState extends State<Teste> {
  late Map<String, String?> celulas;
  int indexR = 0;
  int indexT = 0;
  int indexV = 0;
  Color iconeCor = Color(0xFF57636C);
  Color base = Color(0xFF038C4C);
  String dropdownValue = 'Tratamento';
  String? mensagemErro;
  bool variavelNula = false;
  late TextEditingController textController;

  @override
  void initState() {
    super.initState();
    celulas = criarMapa();
    textController = TextEditingController();
  }

  void atualizarTextController() {
    String chaveAtual = '${widget.atividade.variavel[indexV]}-${widget.atividade.repeticao[indexR]}-${widget.atividade.tratamentos[indexT]}';
    textController.text = celulas[chaveAtual] ?? '';
  }

  Map<String, String?> criarMapa() {
    Map<String, String?> celulas = {};

    for (String varItem in widget.atividade.variavel) {
      for (String repItem in widget.atividade.repeticao) {
        for (String tratItem in widget.atividade.tratamentos) {
          String chave = '$varItem-$repItem-$tratItem';
          celulas[chave] = '';
        }
      }
    }

    return celulas;
  }

  String? encontrarParcela() {
    for (final entry in celulas.entries) {
      if (entry.value == '${widget.atividade.tratamentos[indexT]}-${widget.atividade.repeticao[indexR]}') {
        return entry.key;
      }
    }
    return null;
  }

  void buscar(String termo, String tipo) {
    int novoIndice = 0;
    bool encontrado = false;

    if (tipo == 'Tratamento') {
      novoIndice = widget.atividade.tratamentos.indexOf(termo);
      if (novoIndice != -1) {
        setState(() {
          indexT = novoIndice;
          mensagemErro = null;
          atualizarTextController();
        });
        encontrado = true;
      }
    } else if (tipo == 'Repetição') {
      novoIndice = widget.atividade.repeticao.indexOf(termo);
      if (novoIndice != -1) {
        setState(() {
          indexR = novoIndice;
          mensagemErro = null;
          atualizarTextController();
        });
        encontrado = true;
      }
    } else if (tipo == 'Parcela') {
      for (final entry in widget.atividade.parcelas.asMap().entries) {
        List<String> parts = entry.value.split('-');
        if (parts.length == 3) {
          if (parts[0] == termo) {
            setState(() {
              indexT = widget.atividade.tratamentos.indexOf(parts[0]);
              indexR = widget.atividade.repeticao.indexOf(parts[1]);
              mensagemErro = null;
              atualizarTextController();
            });
            encontrado = true;
            break;
          }
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
    String chaveAtual = '${widget.atividade.variavel[indexV]}-${widget.atividade.repeticao[indexR]}-${widget.atividade.tratamentos[indexT]}';
    String? valorAtual = celulas[chaveAtual];

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
        child: SingleChildScrollView(
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
                  'Variável ${indexV + 1}/${widget.atividade.variavel.length}',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              LinearProgressIndicator(
                value: (indexV + 1) / widget.atividade.variavel.length,
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
                    "${widget.atividade.variavel[indexV]}",
                    style: TextStyle(fontSize: 30),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        indexV = indexV == (widget.atividade.variavel.length - 1) ? (widget.atividade.variavel.length - 1) : indexV + 1;
                        atualizarTextController();
                      });
                    },
                    icon: Icon(Icons.arrow_back_ios, size: 70, color: iconeCor, textDirection: TextDirection.rtl,),
                  ),
                ],
              ),
              TextFormField(
                enabled: !variavelNula,
                controller: textController,
                onChanged: (value) {
                  setState(() {
                    celulas[chaveAtual] = value;
                  });
                },
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
                        atualizarTextController();
                      });
                    },
                    icon: Icon(Icons.arrow_back_ios, size: 70, color: iconeCor),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        "${widget.atividade.repeticao[indexR]}",
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        indexR = indexR == (widget.atividade.repeticao.length - 1) ? (widget.atividade.repeticao.length - 1) : indexR + 1;
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
                        "${widget.atividade.tratamentos[indexT]}",
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        indexT = indexT == (widget.atividade.tratamentos.length - 1) ? (widget.atividade.tratamentos.length - 1) : indexT + 1;
                        atualizarTextController();
                      });
                    },
                    icon: Icon(Icons.arrow_back_ios, size: 70, color: iconeCor, textDirection: TextDirection.rtl,),
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
                salvarMapaComoJSON();
              },
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
                      initialValue: dropdownValue,
                      onValueChanged: (value) {
                        setState(() {
                          dropdownValue = value;
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
                            buscar(textoBusca, dropdownValue);
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

  void salvarMapaComoJSON() {
    Map<String, dynamic> jsonMap = {};

    celulas.forEach((chave, valor) {
      if (valor != null && valor.isNotEmpty) {
        jsonMap[chave] = valor;
      } else if (!variavelNula) {
        jsonMap[chave] = null;
      }
    });

    String jsonString = json.encode(jsonMap);
    print(jsonString);
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
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

