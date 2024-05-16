
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:field_teste/api/FirebaseCode.dart';
import 'package:field_teste/api/Teste2.dart';
import 'package:field_teste/paginas/Perfil.dart';
import 'package:field_teste/paginas/Coletando.dart';
import 'package:field_teste/paginas/Coletas.dart';
import 'package:field_teste/paginas/HomeP.dart';
import 'package:field_teste/paginas/LoginCad.dart';
import 'package:field_teste/paginas/Principal.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'api/Teste.dart';
import 'firebase_options.dart';




void main() async {
  iniciarFirebase();
  runApp(MyApp());
}

void iniciarFirebase() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);


}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Teste2(),
    );
  }
}
