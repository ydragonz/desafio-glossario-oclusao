import 'package:flutter/material.dart';

class EsqueceuSenhaView extends StatefulWidget {
  
  const EsqueceuSenhaView({super.key});

  @override
  State<EsqueceuSenhaView> createState() => _EsqueceuSenhaViewState();
}

class _EsqueceuSenhaViewState extends State<EsqueceuSenhaView> {
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 14, 82, 199),
      ),

      body: Container(
        padding: const EdgeInsets.only(
          top: 60,
          left: 40,
          right: 40,
        ),

        child: ListView(
          children: <Widget>[
            SizedBox(
              width: 200,
              height: 200,
              child: Image.asset("assets/password_reset_icon.png"),
            ),

            const SizedBox(
              height: 20,
            ),

            const Text(
              "Esqueceu sua senha?",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            const Text(
              "Por favor, digite o seu e-mail institucional, ele deve terminar em @sou.unaerp.edu.br ou @unaerp.br e então enviaremos um link para redefinição da senha.",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(
              height: 20,
            ),

            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: "E-mail",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: const TextStyle(
                fontSize: 20,
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            Container(
              height: 60,
              alignment: Alignment.centerLeft,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 41, 109, 228),
                borderRadius: BorderRadius.all(Radius.circular(10),),
              ),
              child: SizedBox.expand(
                child: TextButton(
                  onPressed: () {
                    var snackBar = const SnackBar(content: Text('E-mail enviado!'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Enviar",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  )
                  
                ),
              ),
            ),

            
          ],
        )
      )
    );
  }
}