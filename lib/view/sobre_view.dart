
import 'package:flutter/material.dart';

class SobreView extends StatefulWidget {
  const SobreView({super.key});

  @override
  State<SobreView> createState() => _SobreViewState();
}

class _SobreViewState extends State<SobreView> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0E52C7),
        title: const Text("Informações"),
      ),

      body: Container(
        padding: const EdgeInsets.only(
          top: 40,
          left: 15,
          right: 15,
        ),

        child: ListView(
          children: const <Widget>[

            Icon(Icons.info, size: 40,),

            SizedBox(
              height: 10,
            ),

            Text(
              "Esse projeto foi desenvolvido pela sexta etapa de Engenharia de Software de 2023/1 para auxiliar alunos da Odontologia, possuindo um glossário com campo de busca para encontrar termos técnicos e exercícios que podem ser disponibilizados pelos professores.", 
              style: TextStyle(
                fontSize: 16,
              ),
            ),

            SizedBox(
              height: 40,
            ),

            Text(
              "Alunos", 
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),

            Divider(),

            SizedBox(
              height: 5,
            ),

            Text(
              "Leonardo Bernardes de Oliveira \n(leonardo.boliveira@sou.unaerp.edu.br)", 
              style: TextStyle(
                fontSize: 20,
              ),
            ),

            SizedBox(
              height: 10,
            ),

            Text(
              "Ana Laura Alves \n(ana.lalves@sou.unaerp.edu.br)", 
              style: TextStyle(
                fontSize: 20,
              ),
            ), 

            SizedBox(
              height: 40,
            ),

            Text(
              "Professores", 
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),

            Divider(),

            SizedBox(
              height: 5,
            ),

            Text(
              "Edilson Carlos Carita", 
              style: TextStyle(
                fontSize: 20,
              ),
            ), 

            SizedBox(
              height: 10,
            ),

            Text(
              "Carlos Alves da Silva", 
              style: TextStyle(
                fontSize: 20,
              ),
            ), 

            SizedBox(
              height: 10,
            ),

            Text(
              "Rodrigo de Oliveira Plotze", 
              style: TextStyle(
                fontSize: 20,
              ),
            ), 

            SizedBox(
              height: 10,
            ),

            Text(
              "Fabiano Goncalves dos Santos", 
              style: TextStyle(
                fontSize: 20,
              ),
            ), 
            
          ],
        )
      )
    );
  }
}
