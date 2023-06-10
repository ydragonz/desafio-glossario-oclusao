import 'package:flutter/material.dart';
import 'package:glossario_oclusao/view/exercicio_add_view.dart';
import 'package:glossario_oclusao/view/exercicio_detalhes_view.dart';
import 'package:glossario_oclusao/view/exercicio_respond_view.dart';
import 'package:glossario_oclusao/view/exercicios_view.dart';
import 'package:glossario_oclusao/view/relatorios_view.dart';
import 'package:glossario_oclusao/view/sobre_view.dart';
import 'view/principal_view.dart';
import 'view/login_view.dart';
import 'view/cadastro_view.dart';
import 'view/esqueceu_senha_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
      '/exercicios': (context) => const ExerciciosView(),
      '/exercicio_detalhes': (context) => const ExercicioDetalhesView(),
      '/exercicio_respond': (context) => const ExercicioRespondView(),
      '/exercicio_add': (context) => const ExercicioAddView(),
      '/relatorios': (context) => const RelatoriosView(),
    },
    home: const LoginView(),
  ));
}
