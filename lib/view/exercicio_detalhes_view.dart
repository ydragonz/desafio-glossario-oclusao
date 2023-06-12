import 'package:flutter/material.dart';

class ExercicioDetalhesView extends StatefulWidget {
  const ExercicioDetalhesView({Key? key}) : super(key: key);

  @override
  State<ExercicioDetalhesView> createState() => _ExercicioDetalhesViewState();
}

class _ExercicioDetalhesViewState extends State<ExercicioDetalhesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0E52C7),
        title: const Text('Exercício de Oclusão'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const SizedBox(height: 8),
            Text(
              'MDA, 17 anos, sexo feminino, queixa-se de dor no lado esquerdo da face, “barulho no osso” ao abrir a boca e de “queixo grande”. Ao exame clínico, constata-se protrusão da mandíbula e mordida cruzada anterior. A palpação indica sensibilidade dolorosa no músculo masseter esquerdo. Há crepitação ou estalido na articulação temporomandibular. Esse quadro clínico é compatível com o diagnóstico de',
              style: TextStyle(fontSize: 20),
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
            buildOption('a', 'oclusão normal com disfunção temporomandibular transitóriaoclusão normal com disfunção temporomandibular transitóriaoclusão normal com disfunção temporomandibular transitóriaoclusão normal com disfunção temporomandibular transitória.'),
            const Divider(),
            buildOption('b', 'São Paulo'),
            const Divider(),
            buildOption('c', 'Brasília'),
            const Divider(),
            buildOption('d', 'Belo Horizonte'),
            const SizedBox(height: 35),
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
          groupValue: null, // Não é necessário selecionar uma opção nessa tela de visualização
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
