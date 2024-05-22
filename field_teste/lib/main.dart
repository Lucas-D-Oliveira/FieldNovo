
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:projeto_idr/api/FirebaseCode.dart';
// import 'package:projeto_idr/api/Teste2.dart';
// import 'package:projeto_idr/paginas/Perfil.dart';
// import 'package:projeto_idr/paginas/Coletando.dart';
// import 'package:projeto_idr/paginas/Coletas.dart';
// import 'package:projeto_idr/paginas/HomeP.dart';
// import 'package:projeto_idr/paginas/LoginCad.dart';
// import 'package:projeto_idr/paginas/Principal.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:projeto_idr/paginas/Atividades.dart';
import 'package:projeto_idr/paginas/Coletando.dart';
import 'package:projeto_idr/paginas/Teste2.dart';
import 'package:projeto_idr/paginas/Upload.dart';
import 'firebase_options.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Atividades()
    );
  }
}
