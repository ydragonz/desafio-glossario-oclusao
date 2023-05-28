

import 'package:flutter/material.dart';
import 'package:glossario_oclusao/view/sobre_view.dart';

import 'view/principal_view.dart';
import 'view/login_view.dart';
import 'view/cadastro_view.dart';
import 'view/esqueceu_senha_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Glossario de Oclusao',
    initialRoute: '/login',
    routes: {
      '/principal': (context) => const PrincipalView(),
      '/login': (context) => const LoginView(),
      '/cadastro': (context) => const CadastroView(),
      '/esqueceu_senha': (context) => const EsqueceuSenhaView(),
      '/sobre': (context) => const SobreView(),
    },
    home: const LoginView(),
  ));
}
