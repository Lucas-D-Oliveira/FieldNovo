import 'package:flutter/material.dart';


class Coletando extends StatefulWidget {
  const Coletando({super.key});

  @override
  State<Coletando> createState() => _ColetandoState();
}

class _ColetandoState extends State<Coletando> {
  Color iconeCor = Color(0xFF57636C);
  Color base = Color(0xFF038C4C);

  @override
  Widget build(BuildContext context) {
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
                'Parcela 101',
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
              children: [
                // Botão esquerdo
                IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.arrow_back_ios, size: 70, color: iconeCor),
                ),

                // Texto centralizado
                Expanded(
                  child: Center(
                    child: Text(
                      "Variável",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),

                // Botão direito
                IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.arrow_forward_ios, size: 70, color: iconeCor),
                ),
              ],
            ),

            TextField(
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
                // Botão esquerdo
                IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.arrow_back_ios, size: 70, color: iconeCor),
                ),

                // Texto centralizado
                Expanded(
                  child: Center(
                    child: Text(
                      "Repetição 1",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),

                // Botão direito
                IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.arrow_forward_ios, size: 70, color: iconeCor),
                ),
              ],
            ),

            SizedBox(height: 30),

            Row(
              children: [
                // Botão esquerdo
                IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.arrow_back_ios, size: 70, color: iconeCor),
                ),

                // Texto centralizado
                Expanded(
                  child: Center(
                    child: Text(
                      "Tratamento A",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),

                // Botão direito
                IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.arrow_forward_ios, size: 70, color: iconeCor),
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
                // Ação ao pressionar o botão esquerdo
              },
              backgroundColor: base, // Cor de fundo do botão esquerdo
              child: Icon(Icons.search, color: Colors.white,), // Ícone do botão esquerdo
            ),
          ),
          Positioned(
            bottom: 0,
            right: 16.0,
            child: FloatingActionButton(
              onPressed: () {
                // Ação ao pressionar o botão direito
              },
              backgroundColor: base, // Cor de fundo do botão direito
              child: Icon(Icons.save, color: Colors.white,), // Ícone do botão direito
            ),
          ),
        ],
      ),
    );
  }
}


