import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RelatorioController {

  Future<void> gerarRelatorioAluno(
    BuildContext context,
    String alunoUid,
    bool acertou,
  ) async {

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

  Future<Map<String, int>> getRelatorioExercicio(
    BuildContext context,
    String exercicioUid,
  ) async {
    try {
      final relatorioRef = FirebaseFirestore.instance
          .collection('relatorios_exercicios')
          .doc(exercicioUid);

      final relatorioSnapshot = await relatorioRef.get();

      if (relatorioSnapshot.exists) {
        final numAcertos = relatorioSnapshot.data()!['acertos'] as int;
        final numTotal = relatorioSnapshot.data()!['total'] as int;
        return {
          'acertos': numAcertos,
          'total': numTotal,
        };
      }

      return {
        'acertos': 0,
        'total': 0,
      };
    } catch (e) {
      throw Exception('Ocorreu um erro ao receber dados de exercícios');
    }
  }

Future<Map<String, int>> getRelatorioAluno(
    BuildContext context,
    String alunoUid,
    
  ) async {
    try {
      final relatorioRef = FirebaseFirestore.instance
          .collection('relatorios_alunos')
          .doc(alunoUid);

      final relatorioSnapshot = await relatorioRef.get();

      if (relatorioSnapshot.exists) {
        final numAcertos = relatorioSnapshot.data()!['acertos'] as int;
        final numTotal = relatorioSnapshot.data()!['total'] as int;
        return {
          'acertos': numAcertos,
          'total': numTotal,
        };
      }

      return {
        'acertos': 0,
        'total': 0,
      };
    } catch (e) {
      throw Exception('Ocorreu um erro ao receber dados do aluno');
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