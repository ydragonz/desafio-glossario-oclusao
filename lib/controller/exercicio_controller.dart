import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ExercicioController {
  Future<void> exercicioAdd(
    BuildContext context,
    String enunciado,
    String alternativaA,
    String alternativaB,
    String alternativaC,
    String alternativaD,
    String? alternativaCorreta,
  ) async {
    carregando(context);

    try {
      // Obter a data e hora atuais
      DateTime now = DateTime.now();

      // Criar um novo documento na coleção "exercicios"
      await FirebaseFirestore.instance.collection('exercicios').add({
        "enunciado": enunciado,
        "alternativa_a": alternativaA,
        "alternativa_b": alternativaB,
        "alternativa_c": alternativaC,
        "alternativa_d": alternativaD,
        "alternativa_correta": alternativaCorreta,
        "criado_em": now,
        "atualizado_em": now,
        "ativo": true,
      });

      sucesso(context, 'Exercício criado com sucesso.');
      Navigator.pop(context);
      Navigator.of(context).pop();
    } catch (e) {
      erro(context, 'Ocorreu um erro ao criar o exercício.');
      Navigator.of(context).pop();
    }
  }

  Future<List<DocumentSnapshot>> getExercicios() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('exercicios').get();
    return snapshot.docs;
  }

  String formatDateTime(DateTime dateTime) {
    return DateFormat.yMMMMd().format(dateTime);
  }

  sucesso(context, msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: Colors.green,
    ));
  }

  erro(context, msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Colors.red,
      ),
    );
  }

  carregando(context) {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
