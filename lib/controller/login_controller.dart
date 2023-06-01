
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

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginController {

  login(context, email, senha) async {
    carregando(context);
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: senha).then((res) {
      sucesso(context, 'Usuário autenticado com sucesso.');

      Navigator.pushReplacementNamed(context, '/principal');
    }).catchError((e) {
      /*showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Erro de autenticação'),
          content: Text(e.toString()),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      );*/
      //print(e);
      switch (e.code) {
        case 'invalid-email':
          erro(context, 'O formato do email é inválido.');
          Navigator.of(context).pop();
          break;
        case 'user-not-found':
          erro(context, 'Usuário não encontrado.'); 
          Navigator.of(context).pop();
          break;
        case 'wrong-password':
          erro(context, 'Senha incorreta.');        
          Navigator.of(context).pop();
          break;
        default:
          erro(context, e.code.toString());
          Navigator.of(context).pop();
      }
    });
  }

  logout(context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  esqueceuSenha(context, String email) async {
    try{
      carregando(context);
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: email,
      );
      sucesso(context, 'E-mail enviado com sucesso.');
      Navigator.pop(context);
      Navigator.of(context).pop();
    }on FirebaseAuthException catch(e){
      switch(e.code) {
        case "user-not-found":
          erro(context, "Não existe nenhuma conta com esse e-mail.");
          Navigator.of(context).pop();
          break;
        default:
          erro(context, e.code.toString());
          Navigator.of(context).pop();
      }
    }
  }

  criarConta(context, nome, codigo, email, senha) async {
    carregando(context);
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: senha)
        .then((res) {
      //Armazenar informações adicionais no Firestore
      FirebaseFirestore.instance.collection('alunos').add({
        "uid": res.user!.uid.toString(),
        "nome": nome,
        "codigo": codigo,
      });

      sucesso(context, 'Usuário criado com sucesso.');
      Navigator.pop(context);
      Navigator.of(context).pop();

    }).catchError((e) {
      switch (e.code) {
        case 'email-already-in-use':
          erro(context, 'O email já foi cadastrado.'); 
          Navigator.of(context).pop();
          break;
        case 'invalid-email':
          erro(context, 'O email é inválido.'); 
          Navigator.of(context).pop();
          break;
        default:
          erro(context, e.code.toString());
          Navigator.of(context).pop();
      }
    });
  }

  Future<Map<String, String>> usuarioLogado() async {
  var usuario = {
    'nome': '',
    'email': '',
  };

  try {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final snapshot = await FirebaseFirestore.instance
          .collection('alunos')
          .where('uid', isEqualTo: user.uid)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final aluno = snapshot.docs[0].data();
        usuario['nome'] = aluno['nome'] ?? '';
        print('Nome do usuário: ${usuario['nome']}');
      }

      usuario['email'] = user.email ?? '';
      print('Email do usuário: ${usuario['email']}');
    }
  } catch (e) {
    throw Exception('Erro ao obter dados do usuário: $e');
  }

  return usuario;
}


//.doc(user.uid)

  String idUsuario() {
    final user = FirebaseAuth.instance.currentUser;
    return user!.uid;
  }

  sucesso(context, msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg), backgroundColor: Colors.green,));
  }

  erro(context, msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg), backgroundColor: Colors.red,));
  }

  carregando(context) {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
      }
    );
  }
}
