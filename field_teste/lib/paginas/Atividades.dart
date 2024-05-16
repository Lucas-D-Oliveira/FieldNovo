// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:field_teste/api/Teste.dart';
// import 'package:field_teste/paginas/Coletando.dart';
// import 'package:field_teste/paginas/Upload.dart';
//
// class Atividades extends StatefulWidget {
//   const Atividades({Key? key}) : super(key: key);
//
//   @override
//   State<Atividades> createState() => _AtividadesState();
// }
//
// class _AtividadesState extends State<Atividades> {
//   Color base = Color(0xFF038C4C);
//   late List<AtividadesEColeta> _dadosAtividades = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _carregarAtividades();
//   }
//
//   Future<void> _carregarAtividades() async {
//     CollectionReference atividadesRef =
//     FirebaseFirestore.instance.collection('atividades');
//
//     try {
//       QuerySnapshot querySnapshot = await atividadesRef.get();
//
//       List<AtividadesEColeta> atividades = [];
//       querySnapshot.docs.forEach((doc) {
//         // Aqui você precisa criar um objeto AtividadesEColeta com os dados de cada documento
//         // Por exemplo:
//         // AtividadesEColeta atividade = AtividadesEColeta.fromFirestore(doc);
//         // atividades.add(atividade);
//       });
//
//       setState(() {
//         _dadosAtividades = atividades;
//       });
//     } catch (error) {
//       print('Erro ao carregar atividades: $error');
//       // Trate o erro conforme necessário
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: base,
//         flexibleSpace: Container(
//           padding: EdgeInsets.only(bottom: 0, top: 30, right: 13, left: 13),
//           child: Row(
//             children: [
//               IconButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 icon: Icon(Icons.arrow_back, size: 35, color: Colors.white),
//               ),
//               SizedBox(width: 60),
//               Text("Atividades",
//                   style: TextStyle(color: Colors.white, fontSize: 30)),
//               SizedBox(width: 60),
//               IconButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => Upload()),
//                   );
//                 },
//                 icon: Icon(Icons.upload_file,
//                     size: 35, color: Colors.white),
//               ),
//             ],
//           ),
//         ),
//       ),
//       body: _dadosAtividades.isEmpty
//           ? Center(child: CircularProgressIndicator())
//           : SingleChildScrollView(
//         child: Column(
//           children: _dadosAtividades.map((atividadeEColeta) {
//             return GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => Coletando(
//                       atividadesEColeta: atividadeEColeta,
//                     ),
//                   ),
//                 );
//               },
//               child: Container(
//                 margin: EdgeInsets.only(
//                     top: 20, bottom: 10, right: 10, left: 10),
//                 width: double.infinity,
//                 padding: EdgeInsets.all(8.0),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(16),
//                   border: Border.all(
//                     color: Colors.black,
//                     width: 3,
//                   ),
//                 ),
//                 child: Column(
//                   children: [
//                     Center(
//                       child: Text(
//                         atividadeEColeta.atividade.tituloProj,
//                         style:
//                         TextStyle(color: Colors.black, fontSize: 30),
//                       ),
//                     ),
//                     Center(
//                       child: Text(
//                         atividadeEColeta.atividade.tituloAtiv,
//                         style:
//                         TextStyle(color: Colors.black, fontSize: 20),
//                       ),
//                     ),
//                     SizedBox(height: 8),
//                     Align(
//                       alignment: Alignment.centerLeft,
//                       child: Text(
//                         "Pesq. Responsável: ${atividadeEColeta.atividade.pesqResp}",
//                         style:
//                         TextStyle(color: Colors.black, fontSize: 15),
//                       ),
//                     ),
//                     Align(
//                       alignment: Alignment.centerLeft,
//                       child: Text(
//                         "Município: ${atividadeEColeta.atividade.municipio}",
//                         style:
//                         TextStyle(color: Colors.black, fontSize: 15),
//                       ),
//                     ),
//                     Align(
//                       alignment: Alignment.centerLeft,
//                       child: Text(
//                         "Local: ${atividadeEColeta.atividade.local}",
//                         style:
//                         TextStyle(color: Colors.black, fontSize: 15),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }).toList(),
//         ),
//       ),
//     );
//   }
// }
