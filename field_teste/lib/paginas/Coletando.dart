// import 'dart:convert';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
//
// class Coletando extends StatefulWidget {
//   final DocumentSnapshot documentSnapshot; // DocumentSnapshot utilizado no card
//   const Coletando({super.key, required this.documentSnapshot});
//
//   @override
//   State<Coletando> createState() => _ColetandoState();
// }
//
// class _ColetandoState extends State<Coletando> {
//   Map<String, List<dynamic>> parcelas = {};
//   List<String> tratamentos = [];
//   List<String> repeticao = [];
//   List<String> variavel = [];
//
//   bool variavelNula = false;
//   late Map<String, List<dynamic>> celulas = {};
//   int indexR = 0;
//   int indexT = 0;
//   int indexV = 0;
//   Color iconeCor = const Color(0xFF57636C);
//   Color base = const Color(0xFF038C4C);
//   late TextEditingController textController;
//
//   @override
//   void initState() {
//     super.initState();
//     textController = TextEditingController();
//     _carregarColeta();
//   }
//
//   Future<void> _carregarColeta() async {
//     try {
//       if (widget.documentSnapshot.exists) {
//         Map<String, dynamic>? coleta = widget.documentSnapshot.data() as Map<String, dynamic>?;
//
//         if (coleta != null && coleta.containsKey('coleta')) { // Verificar se 'coleta' está presente no documento
//           Map<String, dynamic> dadosColeta = coleta['coleta'] as Map<String, dynamic>;
//           setState(() {
//             parcelas = Map<String, List<dynamic>>.from(
//                 dadosColeta['parcelas']
//             );
//             tratamentos = List<String>.from(dadosColeta['tratamentos'] ?? []);
//             repeticao = List<String>.from(dadosColeta['repeticao'] ?? []);
//             variavel = List<String>.from(dadosColeta['variavel'] ?? []);
//           });
//
//           criarMapa();
//           // Atualizando o controlador de texto com os dados da parcela atual
//           atualizarTextController();
//         } else {
//           print('Documento não contém dados de coleta');
//         }
//       } else {
//         print('Documento não encontrado');
//       }
//     } catch (e) {
//       print('Erro ao carregar dados de coleta: $e');
//     }
//   }
//
//   Map<String, List<dynamic>> criarMapa() {
//     if (variavel != null && repeticao != null && tratamentos != null) {
//       for (String varItem in variavel!) {
//         for (String repItem in repeticao!) {
//           for (String tratItem in tratamentos!) {
//             String chave = '$varItem-$repItem-$tratItem';
//             celulas[chave] = [];
//           }
//         }
//       }
//     }
//
//     return celulas;
//   }
//
//   Future<void> atualizarTextController() async {
//     if (variavel.isNotEmpty && repeticao.isNotEmpty && tratamentos.isNotEmpty) {
//       String chaveAtual = '${variavel[indexV]}-${repeticao[indexR]}-${tratamentos[indexT]}';
//       setState(() {
//         // Atualiza o valor no mapa celulas
//         celulas[chaveAtual] = [textController.text];
//         print(chaveAtual);
//         print(celulas['Temperatura-1-A']);
//         print(celulas['Temperatura-2-A']);
//       });
//     }
//   }
//
//   Future<void> _mudarIndicesENotificar() async {
//     String chaveAtual = '${variavel[indexV]}-${repeticao[indexR]}-${tratamentos[indexT]}';
//     if (celulas.containsKey(chaveAtual)) {
//       setState(() {
//         // Atualiza o valor do TextFormField com o valor salvo no mapa celulas
//         textController.text = celulas[chaveAtual]?.first ?? '';
//       });
//     } else {
//       // Se não houver valor salvo, limpa o TextFormField
//       textController.clear();
//     }
//
//     setState(() {
//       });
//
//     // Atualiza o valor no mapa celulas com base nos novos índices
//     atualizarTextController();
//   }
//
//   void _mostrarDialogo() {
//     String textoBusca = '';
//
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return StatefulBuilder(
//           builder: (context, setState) {
//             return Dialog(
//               child: Container(
//                 padding: const EdgeInsets.all(20),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     const Text('Pesquisar'),
//                     const SizedBox(height: 20),
//                     DropB(
//                       initialValue: 'Tratamento',
//                       onValueChanged: (value) {
//                         setState(() {
//                           // Lógica para lidar com a mudança de valor do dropdown
//                         });
//                       },
//                     ),
//                     const SizedBox(height: 20),
//                     TextField(
//                       onChanged: (value) {
//                         textoBusca = value;
//                       },
//                       decoration: const InputDecoration(
//                         labelText: 'Digite o termo de busca',
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         ElevatedButton(
//                           onPressed: () {
//                             Navigator.of(context).pop();
//                           },
//                           child: const Text('Cancelar'),
//                         ),
//                         ElevatedButton(
//                           onPressed: () {
//                             // Lógica para lidar com a busca
//                             Navigator.of(context).pop();
//                           },
//                           child: const Text('Buscar'),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
//
//   String? encontrarParcela() {
//     if (tratamentos != null && repeticao != null && parcelas != null) {
//       for (final entry in parcelas.entries) {
//         if ((entry.value[0] == tratamentos![indexT]) && (entry.value[1] == repeticao![indexR])) {
//           return entry.key;
//         }
//       }
//     }
//     return null;
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     String? parcelaEncontrada = encontrarParcela();
//
//
//     return Scaffold(
//         appBar: AppBar(
//           automaticallyImplyLeading: false,
//           backgroundColor: base,
//           flexibleSpace: Container(
//             padding: const EdgeInsets.only(bottom: 0, top: 30, right: 13, left: 13),
//             child: Row(
//               children: [
//                 IconButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   icon: const Icon(Icons.arrow_back, size: 35, color: Colors.white),
//                 ),
//                 const SizedBox(width: 30),
//                 const Text("Coleta de solo", style: TextStyle(color: Colors.white, fontSize: 30)),
//                 const SizedBox(width: 40),
//                 IconButton(
//                   onPressed: () {},
//                   icon: const Icon(Icons.photo_camera, size: 35, color: Colors.white),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         body: Container(
//           width: double.infinity,
//           height: double.infinity,
//           padding: const EdgeInsets.only(bottom: 20, top: 20, right: 10, left: 10),
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//             Center(
//             child: Text(
//               'Parcela ${parcelaEncontrada ?? ""}',
//               style: const TextStyle(fontSize: 25),
//             ),
//           ),
//           const SizedBox(height: 10),
//           Center(
//             child: Text(
//               'Variável ${indexV + 1}/${variavel.length}',
//               style: const TextStyle(fontSize: 20),
//             ),
//           ),
//           LinearProgressIndicator(
//             value: variavel.isNotEmpty ? (indexV + 1) / variavel.length : 0,
//             minHeight: 20.0,
//             backgroundColor: Colors.grey[300],
//             valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
//           ),
//           const SizedBox(height: 20),
//
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               IconButton(
//                 onPressed: () {
//                   setState(() {
//                     indexV = indexV == 0 ? 0 : indexV - 1;
//                     atualizarTextController();
//                     _mudarIndicesENotificar();
//                   });
//                 },
//                 icon: Icon(Icons.arrow_back_ios, size: 70, color: iconeCor),
//               ),
//               Text(
//                 variavel.isNotEmpty ? "${variavel[indexV]}" : '',
//                 style: const TextStyle(fontSize: 30),
//               ),
//               IconButton(
//                 onPressed: () {
//                   setState(() {
//                     indexV = indexV == (variavel.length - 1) ? (variavel.length - 1) : indexV + 1;
//                     atualizarTextController();
//                     _mudarIndicesENotificar();
//                   });
//                 },
//                 icon: Icon(Icons.arrow_back_ios, size: 70, color: iconeCor, textDirection: TextDirection.rtl,),
//               ),
//             ],
//           ),
//
//                 TextFormField(
//                   controller: textController,
//                   onChanged: (value) {
//                     // Chama o método para atualizar o valor no mapa celulas sempre que o texto for alterado
//                     atualizarTextController();
//                   },
//                   decoration: const InputDecoration(
//                     border: OutlineInputBorder(borderSide: BorderSide(color: Colors.green)),
//                     hintText: 'Informe valor',
//                   ),
//                 ),
//
//                 Row(
//                   children: [
//                     Container(
//                       padding: EdgeInsets.only(left: 16.0),
//                       child: Checkbox(
//                         value: variavelNula,
//                         onChanged: (bool? value) {
//                           setState(() {
//                             variavelNula = value ?? false;
//                           });
//                         },
//                       ),
//                     ),
//                     Text(
//                       'Deixar variável nula',
//                       style: TextStyle(fontSize: 16.0),
//                     ),
//                   ],
//                 ),
//
//           const SizedBox(height: 30),
//           Row(
//               children: [
//               IconButton(
//               onPressed: () {
//         setState(() {
//         indexR = indexR == 0 ? 0 : indexR - 1;
//         atualizarTextController();
//         _mudarIndicesENotificar();
//         });
//         },
//           icon: Icon(Icons.arrow_back_ios, size: 70, color: iconeCor),
//         ),
//         Expanded(
//           child: Center(
//             child: Text(
//               repeticao.isNotEmpty ? "${repeticao[indexR]}" : '',
//               style: const TextStyle(fontSize: 30),
//             ),
//           ),
//         ),
//         IconButton(
//         onPressed: () {
//       setState(() {
//         indexR = indexR == (repeticao.length - 1) ? (repeticao.length - 1)
//             : indexR + 1;
//         atualizarTextController();
//         _mudarIndicesENotificar();
//       });
//         },
//           icon: Icon(Icons.arrow_back_ios, size: 70, color: iconeCor, textDirection: TextDirection.rtl),
//         ),
//               ],
//           ),
//                 const SizedBox(height: 30),
//                 Row(
//                   children: [
//                     IconButton(
//                       onPressed: () {
//                         setState(() {
//                           indexT = indexT == 0 ? 0 : indexT - 1;
//                           atualizarTextController();
//                           _mudarIndicesENotificar();
//                         });
//                       },
//                       icon: Icon(Icons.arrow_back_ios, size: 70, color: iconeCor),
//                     ),
//                     Expanded(
//                       child: Center(
//                         child: Text(
//                           tratamentos.isNotEmpty ? "${tratamentos[indexT]}" : '',
//                           style: const TextStyle(fontSize: 30),
//                         ),
//                       ),
//                     ),
//                     IconButton(
//                       onPressed: () {
//                         setState(() {
//                           indexT = indexT == (tratamentos.length - 1) ? (tratamentos.length - 1) : indexT + 1;
//                           atualizarTextController();
//                           _mudarIndicesENotificar();
//                         });
//                       },
//                       icon: Icon(Icons.arrow_back_ios, size: 70, color: iconeCor, textDirection: TextDirection.rtl),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       floatingActionButton: Stack(
//         children: [
//           Positioned(
//             bottom: 0,
//             left: 47.0,
//             child: FloatingActionButton(
//               onPressed: () {
//                 _mostrarDialogo();
//               },
//               backgroundColor: base,
//               child: const Icon(Icons.search, color: Colors.white),
//             ),
//           ),
//           Positioned(
//             bottom: 0,
//             right: 16.0,
//             child: FloatingActionButton(
//               onPressed: () {
//                // Chamar _salvarDados quando o botão de salvar for pressionado
//               },
//               backgroundColor: base,
//               child: const Icon(Icons.save, color: Colors.white),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class DropB extends StatefulWidget {
//   final String initialValue;
//   final Function(String) onValueChanged;
//
//   DropB({required this.initialValue, required this.onValueChanged});
//
//   @override
//   _DropBState createState() => _DropBState();
// }
//
// class _DropBState extends State<DropB> {
//   late String dropdownValue;
//
//   @override
//   void initState() {
//     super.initState();
//     dropdownValue = widget.initialValue;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return DropdownButton<String>(
//       value: dropdownValue,
//       onChanged: (String? newValue) {
//         setState(() {
//           dropdownValue = newValue!;
//           widget.onValueChanged(dropdownValue);
//         });
//       },
//       items: <String>['Tratamento', 'Repetição', 'Variável']
//           .map<DropdownMenuItem<String>>((String value) {
//         return DropdownMenuItem<String>(
//           value: value,
//           child: Text(value),
//         );
//       }).toList(),
//     );
//   }
// }
