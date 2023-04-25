

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'view/principal_view.dart';
import 'view/login_view.dart';
import 'view/cadastro_view.dart';
import 'view/esqueceu_senha_view.dart';

void main() {


  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Glossario de Oclusao',
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
