import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
        //color: Color.fromARGB(255, 41, 109, 228),
        color: Colors.white10,
        child: ListView(
          children: <Widget>[

            SizedBox (
            width: 128,
            height: 128,
            child: Image.asset("../assets/logo_unaerp_rounded.png",),
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
                  "Recuperar senha",
                  style: TextStyle(color: Colors.black),
                ),
                
                onPressed: () {
                  Navigator.pushReplacementNamed(context, 'esqueceu_senha');
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
                    Navigator.pushReplacementNamed(context, 'principal');
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

            const SizedBox (
              height: 10,
            ),

            Container(
              height: 40,
              child: TextButton(
                child: const Text(
                  "Cadastre-se",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, 'cadastro');
                },
              ),
            )
          ],
        ),
      ));
  }
}
