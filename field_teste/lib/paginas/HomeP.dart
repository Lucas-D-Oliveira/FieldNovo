import 'package:field_teste/paginas/Projetos.dart';
import 'package:flutter/material.dart';

class HomeP extends StatefulWidget {
  const HomeP({super.key});

  @override
  State<HomeP> createState() => _HomePState();
}

class _HomePState extends State<HomeP> {
  Color iconeCor = Color(0xFF57636C);
  Color varVerde =  Color(0xFF05D601);

  @override
  Widget build(BuildContext context) {
    return Container( ////////FUNDO DA TELA
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.only(top: 20, bottom: 20,),
      child: Column(
        children: [

          Container( //////// AVISO DE COLETAS ATIVAS
            padding: EdgeInsets.only(top: 8, bottom: 8),
            decoration: BoxDecoration(
              color: varVerde,
              border: Border(
                top: BorderSide(color: Colors.black, width: 3),
                bottom: BorderSide(color: Colors.black, width: 3),
              ),
            ),
            child: Center(
              child: Column(
                children: [
                  Text(
                    "Coletas Ativas",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),

                  Text(
                    "15",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 50),

          GestureDetector(
          onTap: () {
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Projetos()),
          );
          },
          child: Container( ///////////////COLETA DE DADOS
              padding: EdgeInsets.only(top: 10, bottom: 10),
              margin: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 3),
              borderRadius: BorderRadius.circular(16),
            ),
              child: Center(
                child: Column(
                children: [
                  Text(
                      'Coleta de dados',
                      style: TextStyle(
                        fontSize: 25
                      ),
                  ),
                  Icon(Icons.paste, size: 70,color: iconeCor,),
                ],
              ),
    ),
          ),
              ),

          SizedBox(height: 10),

              Container( ///////////////SOBRE
                padding: EdgeInsets.only(top: 10, bottom: 10),
                margin: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 3),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        'Sobre',
                        style: TextStyle(
                            fontSize: 25
                        ),
                      ),
                      Icon(Icons.feedback_rounded, size: 70,color: iconeCor,),
                    ],
                  ),
                ),
              ),


          SizedBox(height: 10),

          Container( ///////////////SCANEAR
            padding: EdgeInsets.only(top: 10, bottom: 10),
            margin: EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 3),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Column(
                children: [
                  Text(
                    'Escanear',
                    style: TextStyle(
                        fontSize: 25
                    ),
                  ),
                  Icon(Icons.photo_camera, size: 70,color: iconeCor,),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
