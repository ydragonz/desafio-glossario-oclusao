import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import 'login_controller.dart';

class RelatorioController {

  Future<void> gerarRelatorioAluno(
    BuildContext context,
    String alunoUid,
    bool acertou,
  ) async {
    carregando(context);

    try {
      final relatorioRef = FirebaseFirestore.instance
          .collection('relatorios_alunos')
          .doc(alunoUid);

      final relatorioSnapshot = await relatorioRef.get();

      if (relatorioSnapshot.exists) {
        // Se o documento já existe, atualizar os campos "acertos" e "total"
        final numAcertos = relatorioSnapshot.data()!['acertos'] as int;
        final numTotal = relatorioSnapshot.data()!['total'] as int;

        final int novoNumAcertos = acertou ? numAcertos + 1 : numAcertos;
        final int novoNumTotal = numTotal + 1;

        await relatorioRef.update({
          'acertos': novoNumAcertos,
          'total': novoNumTotal,
        });
      } else {
        // Se o documento não existe, criar o documento com os campos iniciais
        await relatorioRef.set({
          'uid': alunoUid,
          'acertos': acertou ? 1 : 0,
          'total': 1,
        });
      }

    } catch (e) {
      erro(context, 'Ocorreu um erro ao criar/atualizar o relatório de aluno.');
    }
  }

  gerarRelatorioExercicio(
    BuildContext context,
    String exercicioUid,
    bool acertou,
  ) async {
    carregando(context);

    try {
      final relatorioRef = FirebaseFirestore.instance
          .collection('relatorios_exercicios')
          .doc(exercicioUid);

      final relatorioSnapshot = await relatorioRef.get();

      if (relatorioSnapshot.exists) {
        // Se o documento já existe, atualizar os campos "acertos" e "total"
        final numAcertos = relatorioSnapshot.data()!['acertos'] as int;
        final numTotal = relatorioSnapshot.data()!['total'] as int;

        final int novoNumAcertos = acertou ? numAcertos + 1 : numAcertos;
        final int novoNumTotal = numTotal + 1;

        await relatorioRef.update({
          'acertos': novoNumAcertos,
          'total': novoNumTotal,
        });
      } else {
        // Se o documento não existe, criar o documento com os campos iniciais
        await relatorioRef.set({
          'uid': exercicioUid,
          'acertos': acertou ? 1 : 0,
          'total': 1,
        });
      }

    } catch (e) {
      erro(context, 'Ocorreu um erro ao criar/atualizar o relatório de exercicio.');
    }
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