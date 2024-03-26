import 'package:field_teste/paginas/HomeP.dart';
import 'package:field_teste/paginas/Principal.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class LoginCad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2, // Número de tabs
        child: Scaffold(
          body: TabBarView(
            children: [
              // Conteúdo da primeira tab (Login)
              LoginTab(),
              // Conteúdo da segunda tab (Registrar)
              RegisterTab(),
            ],
          ),
          bottomNavigationBar: Container(
            color: Colors.white, // Cor de fundo da TabBar quando selecionado
            child: TabBar(
              labelColor: Colors.green, // Cor do texto da tab selecionada
              unselectedLabelColor: Colors.black, // Cor do texto das tabs não selecionadas
              labelStyle: TextStyle(fontSize: 18), // Tamanho do texto da tab selecionada
              unselectedLabelStyle: TextStyle(fontSize: 16),
              indicatorColor: Color(0xFF038C4C),
              indicatorWeight: 3,// Tamanho do texto das tabs não selecionadas
              tabs: [
                Tab(text: 'Login'),
                Tab(text: 'Registrar'),
              ],
            ),
          ),



        ),
      ),
    );
  }
}

class LoginTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: 350,
              decoration: BoxDecoration(
                  color: Colors.green[300]
              ),
              child: Column(
                children: <Widget>[
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 60, left: 10, right: 25),
                      width: 350,
                      height: 100,
                      child: FadeInUp(duration: Duration(seconds: 1), child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('imagens/logo_idr_h.png'),
                                fit: BoxFit.cover
                            )
                        ),
                      )),
                    ),
                  ),

                  Positioned(
                    child: FadeInUp(duration: Duration(milliseconds: 1600), child: Container(
                      margin: EdgeInsets.only(top: 50),
                      child: Center(
                        child: Text("Diário de campo", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),),
                      ),
                    )),
                  )
                ],
              ),
            ),

            Padding( /////////////////// EMAIL SENHA
              padding: EdgeInsets.all(30.0),
              child: Column(
                children: <Widget>[
                  FadeInUp(duration: Duration(milliseconds: 1800), child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black),
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(143, 148, 251, .2),
                              blurRadius: 20.0,
                              offset: Offset(0, 10)
                          )
                        ]
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(color:  Colors.black))
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Email",
                                hintStyle: TextStyle(color: Colors.grey[700])
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8.0),
                          child: TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Senha",
                                hintStyle: TextStyle(color: Colors.grey[700])
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
                  SizedBox(height: 20,),
                  FadeInUp(duration: Duration(milliseconds: 1900), child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Principal()),
                        );
                      },
                      child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                            colors: [
                              Colors.greenAccent,
                              Colors.green,
                            ]
                        )
                    ),
                    child: Center(
                      child: Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
                    ),
                  ),
                  ),
                  ),

                  SizedBox(height: 40,),
                  FadeInUp(duration: Duration(milliseconds: 2000), child: Text("Esqueceu a senha??", style: TextStyle(color: Colors.black),)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RegisterTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: 350,
              decoration: BoxDecoration(
                  color: Colors.green[300]
              ),
              child: Column(
                children: <Widget>[
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 60, left: 10, right: 25),
                      width: 350,
                      height: 100,
                      child: FadeInUp(duration: Duration(seconds: 1), child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('imagens/logo_idr_h.png'),
                                fit: BoxFit.cover
                            )
                        ),
                      )),
                    ),
                  ),

                  Positioned(
                    child: FadeInUp(duration: Duration(milliseconds: 1600), child: Container(
                      margin: EdgeInsets.only(top: 50),
                      child: Center(
                        child: Text("Diário de campo", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),),
                      ),
                    )),
                  )
                ],
              ),
            ),

            Padding( /////////////////// EMAIL SENHA
              padding: EdgeInsets.all(30.0),
              child: Column(
                children: <Widget>[
                  FadeInUp(duration: Duration(milliseconds: 1800), child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black),
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(143, 148, 251, .2),
                              blurRadius: 20.0,
                              offset: Offset(0, 10)
                          )
                        ]
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(////////////////////////EMAIL
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(color:  Colors.black))
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Email",
                                hintStyle: TextStyle(color: Colors.grey[700])
                            ),
                          ),
                        ),

                        Container(////////////SENHA
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(color:  Colors.black))
                          ),
                          child: TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Senha",
                                hintStyle: TextStyle(color: Colors.grey[700])
                            ),
                          ),
                        ),

                        Container( ////////////CONFIRMAR SENHA
                          padding: EdgeInsets.all(8.0),
                          child: TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Confirmar senha",
                                hintStyle: TextStyle(color: Colors.grey[700])
                            ),
                          ),
                        ),


                      ],
                    ),
                  )),
                  SizedBox(height: 20,),
                  FadeInUp(duration: Duration(milliseconds: 1900), child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                            colors: [
                              Colors.greenAccent,
                              Colors.green,
                            ]
                        )
                    ),
                    child: Center(
                      child: Text("Cadastrar", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
                    ),
                  )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}