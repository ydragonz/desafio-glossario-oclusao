import 'package:flutter/material.dart';

class ExercicioDetalhesView extends StatelessWidget {
  const ExercicioDetalhesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //final Map<String, dynamic>? exercicio = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    final Map<String, dynamic> exercicio = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    /*if (exercicio != null) {
      final String? criadoEm = exercicio['criado_em'] as String?;
      final String? atualizadoEm = exercicio['atualizado_em'] as String?;
      // Resto do código...
    }*/

    
    /*final criadoEm = (exercicio['criado_em'] as Timestamp).toDate() as DateTime;
    final atualizadoEm = (exercicio['atualizado_em'] as Timestamp).toDate() as DateTime;*/

    /*final String enunciado = exercicio['enunciado'];
    final String alternativaA = exercicio['alternativa_a'];
    final String alternativaB = exercicio['alternativa_b'];
    final String alternativaC = exercicio['alternativa_c'];
    final String alternativaD = exercicio['alternativa_d'];
    final String alternativaCorreta = exercicio['alternativa_correta'];*/
    //final DateTime criadoEm = exercicio['criado_em'];
    //final DateTime atualizadoEm = exercicio['atualizado_em'];
    final String criadoEm = exercicio['criado_em'];
    final String atualizadoEm = exercicio['atualizado_em'];
    //final criadoEmFormatted = _formatDateTime(criadoEm);
    //final atualizadoEmFormatted = _formatDateTime(atualizadoEm);

    return Scaffold(

      
      appBar: AppBar(
        backgroundColor: const Color(0xFF0E52C7),
        title: const Text('Exercício de Oclusão'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'Criado em: $criadoEm \tAtualizado em: $atualizadoEm',
              style: const TextStyle(fontSize: 15, color: Color.fromARGB(137, 0, 0, 0)),
            ),
            const SizedBox(height: 10),
            Text(
              exercicio['enunciado'], // Utiliza o enunciado do exercício
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 35),
            const Text(
              'Alternativas:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            buildOption('a', exercicio['alternativa_a']), 
            const Divider(),
            buildOption('b', exercicio['alternativa_b']), 
            const Divider(),
            buildOption('c', exercicio['alternativa_c']), 
            const Divider(),
            buildOption('d', exercicio['alternativa_d']), 
            const Divider(),
            const SizedBox(height: 35),

            Container(
              height: 60,
              alignment: Alignment.centerLeft,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 41, 109, 228),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: SizedBox.expand(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/exercicio_edit',
                      arguments: {
                        'uid': exercicio['uid'],
                        'enunciado': exercicio['enunciado'],
                        'alternativa_a': exercicio['alternativa_a'],
                        'alternativa_b': exercicio['alternativa_b'],
                        'alternativa_c': exercicio['alternativa_c'],
                        'alternativa_d': exercicio['alternativa_d'],
                        'alternativa_correta': exercicio['alternativa_correta'],
                        'ativo': exercicio['ativo'],
                      },
                    );
                  },
                  child: const Text(
                    "Editar",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Container(
              height: 60,
              alignment: Alignment.centerLeft,
              decoration: const BoxDecoration(
                color: Color.fromARGB(182, 116, 116, 116),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: SizedBox.expand(
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Voltar",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOption(String alternativa, String text) {
    return Row(
      children: [
        Radio<String>(
          value: alternativa,
          groupValue: null,
          onChanged: null,
        ),
        Flexible(
          child: Text(
            text,
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ],
    );
  }
}
