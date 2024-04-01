import 'package:field_teste/paginas/HomeP.dart';
import 'package:field_teste/paginas/Principal.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:field_teste/api/api.dart';

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
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final senhaController = TextEditingController();

  Future<void> realizarLogin(BuildContext context) async {
    var dadosAPI = await fetch();
    var emailAPI = dadosAPI['usuario'];
    var senhaAPI = dadosAPI['senha'];

    var emailUsuario = emailController.text;
    var senhaUsuario = senhaController.text;

    if (emailAPI == emailUsuario && senhaAPI == senhaUsuario) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Principal()),
      );
    } else {
      // Exibir mensagem de erro de login inválido
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erro de Login'),
            content: Text('E-mail ou senha incorretos.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: 350,
              decoration: BoxDecoration(
                color: Colors.green[300],
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
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color:  Colors.black))
                            ),
                            child: TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Email",
                                  hintStyle: TextStyle(color: Colors.grey[700])
                              ),
                              validator: (email) {
                                if (email == null || email.isEmpty) {
                                  return 'Digite seu email';
                                }
                                return null;
                              },
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: senhaController,
                              obscureText: true,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Senha",
                                  hintStyle: TextStyle(color: Colors.grey[700])
                              ),
                              validator: (senha) {
                                if (senha == null || senha.isEmpty) {
                                  return 'Digite sua senha';
                                } else if (senha.length < 6) {
                                  return 'Digite uma senha com no min. 6 caracteres';
                                }
                                return null;
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  )),

                  SizedBox(height: 20,),
                  FadeInUp(duration: Duration(milliseconds: 1900), child: GestureDetector(
                    onTap: () {
                      if(formKey.currentState!.validate()) {
                        realizarLogin(context);
                      }
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
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final senhaController = TextEditingController();
  final confirmarSenhaController = TextEditingController();

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
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: <Widget>[
                          Container(////////////////////////EMAIL
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color:  Colors.black))
                            ),
                            child: TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Email",
                                  hintStyle: TextStyle(color: Colors.grey[700])
                              ),
                              validator: (email) {
                                if (email == null || email.isEmpty) {
                                  return 'Digite seu email';
                                }
                                return null;
                              },
                            ),
                          ),

                          Container(////////////SENHA
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color:  Colors.black))
                            ),
                            child: TextFormField(
                              controller: senhaController,
                              obscureText: true,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Senha",
                                  hintStyle: TextStyle(color: Colors.grey[700])
                              ),
                              validator: (senha) {
                                if (senha == null || senha.isEmpty) {
                                  return 'Digite sua senha';
                                } else if (senha.length <= 6) {
                                  return 'Digite uma senha com no min. 6 caracteres';
                                }
                                return null;
                              },
                            ),
                          ),

                          Container( ////////////CONFIRMAR SENHA
                            padding: EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: confirmarSenhaController,
                              obscureText: true,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Confirmar senha",
                                  hintStyle: TextStyle(color: Colors.grey[700])
                              ),
                              validator: (confirmarSenha) {
                                if (confirmarSenha == null || confirmarSenha.isEmpty) {
                                  return 'Confirme sua senha';
                                } else if (confirmarSenha != senhaController.text) {
                                  return 'As senhas não coincidem';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
                  SizedBox(height: 20,),
                  FadeInUp(duration: Duration(milliseconds: 1900), child: GestureDetector(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        // Realize ações de cadastro aqui
                      }
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
                        child: Text("Cadastrar", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
                      ),
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
