import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:glossario_oclusao/controller/relatorio_controller.dart';
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
      Navigator.pushReplacementNamed(context, '/exercicios');
      
    } catch (e) {
      erro(context, 'Ocorreu um erro ao criar o exercício.');
      Navigator.of(context).pop();
    }
  }

  Future<void> exercicioEdit(
    BuildContext context,
    String? uid,
    String enunciado,
    String alternativaA,
    String alternativaB,
    String alternativaC,
    String alternativaD,
    String? alternativaCorreta,
    bool? ativo,
  ) async {
    carregando(context);

    try {

      DateTime now = DateTime.now();


      DocumentReference exercicioRef = FirebaseFirestore.instance.collection('exercicios').doc(uid);

      await exercicioRef.update({
        "enunciado": enunciado,
        "alternativa_a": alternativaA,
        "alternativa_b": alternativaB,
        "alternativa_c": alternativaC,
        "alternativa_d": alternativaD,
        "alternativa_correta": alternativaCorreta,
        "atualizado_em": now,
        "ativo": ativo,
      });

      sucesso(context, 'Exercício atualizado com sucesso.');
      Navigator.pop(context);
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      Navigator.pushReplacementNamed(context, '/exercicios');

    } catch (e) {
      erro(context, 'Ocorreu um erro ao atualizar o exercício.');
      Navigator.of(context).pop();
    }
  }


  Future<void> respostaAdd(
    BuildContext context,
    String exercicioUid,
    String alunoUid,
    String? alternativaSelecionada,
  ) async {
    carregando(context);

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (await isAtivo(exercicioUid)) {
        DateTime now = DateTime.now();
        bool? acertou;

        if (isValido(now)) {
          if (await isCorreto(exercicioUid, alternativaSelecionada)) {
            acertou = true;
          } else {
            acertou = false;
          }
          await FirebaseFirestore.instance.collection('respostas').add({
            "exercicio_uid": exercicioUid,
            "aluno_uid": user!.uid,
            "alternativa_selecionada": alternativaSelecionada,
            "respondido_em": now,
            "acertou": acertou,
          });

          RelatorioController relatorioController = RelatorioController();
          await relatorioController.gerarRelatorioAluno(
            context,
            user!.uid,
            acertou,
          );

          await relatorioController.gerarRelatorioExercicio(
            context,
            exercicioUid,
            acertou,
          );

          sucesso(context, 'Resposta enviada com sucesso');
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, '/exercicios');
        } else {
          erro(context, "Você não pode responder a este exercício");
        }
      } else {
        erro(context, "O exercício não está ativo");
      }
      
    } catch (e) {
      erro(context, 'Ocorreu um erro ao enviar resposta');
      Navigator.of(context).pop();
    }
  }

  Future<bool> isAtivo(String uid) async {
    final docSnapshot = await FirebaseFirestore.instance.collection('exercicios').doc(uid).get();
    final exercicioData = docSnapshot.data();
    if (exercicioData != null) {
      final bool? ativo = exercicioData['ativo'];
      return ativo ?? false;
    }
    return false;
  }

  Future<bool> isCorreto(String uid, String? alternativa) async {
    final docSnapshot = await FirebaseFirestore.instance.collection('exercicios').doc(uid).get();
    final exercicioData = docSnapshot.data();
    if (exercicioData != null) {
      final String? alternativaCorreta = exercicioData['alternativa_correta'];
      return alternativa == alternativaCorreta;
    }
    return false;
  }






  bool isValido(DateTime date) {
    String formattedDate = formatDateTime(date);  // Implementar verificação de validade
    return true;///////////////////////////////////////////////
  }






  Future<List<DocumentSnapshot>> getExercicios() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('exercicios').get();
    return snapshot.docs;
  }

  String formatDateTime(DateTime dateTime) {
    final format = DateFormat('dd/MM');
    return format.format(dateTime);
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
