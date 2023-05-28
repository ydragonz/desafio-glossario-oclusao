/* Na primeira etapa a parte de validação de login não é necessária
   então não há como implementar o login_contoller no momento, será
   implementado para as avaliações finais e por enquanto utilizaremos
   variaveis predefinidas para simular credenciais autorizadas */

/*  Método antigo utilizado no projeto, substituir pela versão com firbease
class LoginController {
  static final LoginController _singleton = LoginController._internal();

  factory LoginController() {
    return _singleton;
  }

  LoginController._internal();

  final String _emailValido = 'teste@sou.unaerp.edu.br';
  final String _senhaValida = 'senha123';

  bool _logado = false;

  bool get logado => _logado;

  Future<void> login(String username, String password) async {
    if (username == _emailValido && password == _senhaValida) {
      _logado = true;
    } else {
      _logado = false;
      throw Exception('Credenciais inválidas');
    }
  }

  Future<void> logout() async {
    _logado = false;
  }
}
*/

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginController {
  
  //FirebaseAuth 

  login(context, email, senha) {
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: senha).then((res) {
      //sucesso(context, 'Usuário autenticado com sucesso.');
      Navigator.pushReplacementNamed(context, '/principal');
    }).catchError((e) {
      print(e);
      /*switch (e.code) {
        case 'invalid-email':
          erro(context, 'O formato do email é inválido.');  break;
        case 'user-not-found':
          erro(context, 'Usuário não encontrado.'); break;
        case 'wrong-password':
          erro(context, 'Senha incorreta.');        break;
        default:
          erro(context, e.code.toString());
      }*/
    });
  }

  void logout() {
    FirebaseAuth.instance.signOut();
  }

  void esqueceuSenha(context, String email) {
    if (email.isNotEmpty) {
      FirebaseAuth.instance.sendPasswordResetEmail(
        email: email,
      );
      //sucesso(context, 'E-mail enviado com sucesso.');
    } else {
      //erro(context, 'Informe o e-mail para recuperar a senha.');
    }

    Navigator.pop(context);
  }

  void criarConta(context, nome, email, senha) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: senha)
        .then((res) {
      //Armazenar informações adicionais no Firestore
      FirebaseFirestore.instance.collection('usuarios').add({
        "uid": res.user!.uid.toString(),
        "nome": nome,
      });
      //sucesso(context, 'Usuário criado com sucesso.');
      Navigator.pop(context);
    }).catchError((e) {
      /*switch (e.code) {
        case 'email-already-in-use':
          erro(context, 'O email já foi cadastrado.'); break;
        case 'invalid-email':
          erro(context, 'O email é inválido.'); break;
        default:
          erro(context, e.code.toString());
      }*/
    });
  }


}
