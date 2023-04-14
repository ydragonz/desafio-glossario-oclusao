

import 'package:flutter/material.dart';

import 'view/principal_view.dart';
import 'view/login_view.dart';
import 'view/cadastro_view.dart';
import 'view/esqueceu_senha_view.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Glossario de Oclusao',
    /*theme: ThemeData(
      appBarTheme: const AppBarTheme(
        color: Color.fromARGB(255, 41, 109, 228),
      )
    ),*/
    initialRoute: 'login',
    routes: {
      'principal': (context) => const PrincipalView(),
      'login': (context) => const LoginView(),
      'cadastro': (context) => const CadastroView(),
      'esqueceu_senha': (context) => const EsqueceuSenhaView(),
    },
    home: const LoginView(),
  ));
}
