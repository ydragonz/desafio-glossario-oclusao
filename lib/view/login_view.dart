import 'package:flutter/material.dart';
import 'package:glossario_oclusao/model/cadastro.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 60, left: 40, right: 40,),
        color: Colors.white10,
        child: ListView(
          children: <Widget>[

            Container (
              width: 128,
              height: 128,
              
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),

              child: Image.asset("assets/logo_unaerp_rounded.png",),
            ),

            const SizedBox (
              height: 50,
            ),

            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: "E-mail",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight:FontWeight.w400,
                  fontSize: 20,
                )
              ),
              validator: (value) {
                if(value?.isEmpty ?? true) {
                  return 'Por favor, insira seu e-mail';
                }
                if(value != null && !value.endsWith('@sou.unaerp.edu.br') && !value.endsWith('@unaerp.com')) {
                  WidgetsBinding.instance!.addPostFrameCallback((_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Por favor, insira um e-mail institucional válido'),
                      ),
                    );
                  });
                  return 'Por favor, insira seu e-mail institucional válido';
                }
                return null;
              },
              onSaved: (value) {
                
              },
            ),

            const SizedBox (
              height: 20,
            ),

            TextFormField(
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Senha",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: const TextStyle(fontSize: 20),
            ),

            const SizedBox (
              height: 5,
            ),

            Container(
              height: 40,
              alignment: Alignment.centerRight,
              child: TextButton(
                child: const Text(
                  "Esqueceu a senha?",
                  //style: TextStyle(color: Colors.black),
                ),
                
                onPressed: () {
                  Navigator.pushNamed(context, '/esqueceu_senha');
                },
              ),
            ),

            const SizedBox (
              height: 50,
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
                    Navigator.pushNamed(context, '/principal');
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  )
                  
                ),
              ),
            ),
            
            Expanded(
              child: SizedBox(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('Ainda não tem conta?', textAlign: TextAlign.center,),
                    TextButton(
                      child: const Text(
                        "Cadastre-se",
                        textAlign: TextAlign.center,
                      ),
                      onPressed: () => Navigator.pushNamed(context, '/cadastro'),
                    ),
                  ],
                ),
              ),
            ),
            /*
            const SizedBox (
              height: 10,
            ),

            SizedBox(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [
                  const Text('Ainda não tem conta?', textAlign: TextAlign.center,),
                  TextButton(
                    child: const Text(
                      "Cadastre-se",
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, 'cadastro');
                    },
                  ),
                ]
              ),
                
            ),*/
            
          ],
        ),
      ));
  }
}
