import 'package:flutter/material.dart';

class Coletas extends StatefulWidget {
  const Coletas({super.key});

  @override
  State<Coletas> createState() => _ColetasState();
}

class _ColetasState extends State<Coletas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
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

              SizedBox(width: 75),

              Text("Coletas", style: TextStyle(color: Colors.white, fontSize: 30)),
            ],
          ),
        ),
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        padding: EdgeInsets.only(top: 20, bottom: 20,),
        child: SingleChildScrollView(
          child: Wrap(
            runSpacing: 15,
            spacing: 15,
            alignment: WrapAlignment.center,
            children: [
              Container(
                width: 180,
                height: 150,
                padding: EdgeInsets.only(top: 35),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.black,
                    width: 3,
                  ),
                ),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                          "Grupo 1",
                          style: TextStyle(color: Colors.black, fontSize: 15)
                      ),
                    ),

                    SizedBox(height: 15),

                    Text(
                        "Repetição 1",
                        style: TextStyle(color: Colors.black, fontSize: 24)
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 15, right: 10, left: 10),
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          child: Text("Salvar", style: TextStyle(color: Colors.white, fontSize: 20),),
          onPressed: () {

          },
        ),
      ),
    );
  }
}
