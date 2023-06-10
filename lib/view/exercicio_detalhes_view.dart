import 'package:flutter/material.dart';

class ExercicioDetalhesView extends StatefulWidget {
  
  const ExercicioDetalhesView({super.key});

  @override
  State<ExercicioDetalhesView> createState() => _ExercicioDetalhesViewState();
}

class _ExercicioDetalhesViewState extends State<ExercicioDetalhesView> {
  final bool isProf =true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //ExercicioItemView({required this.isProf});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercício de Oclusão'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Título do Exercício',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Pergunta do Exercício:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Qual é a capital do Brasil?',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                'Alternativas:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              buildOption('a', 'Rio de Janeiro'),
              buildOption('b', 'São Paulo'),
              buildOption('c', 'Brasília'),
              buildOption('d', 'Belo Horizonte'),
              SizedBox(height: 16),
              if (!isProf)
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // Lógica para enviar a resposta
                    }
                  },
                  child: Text('Enviar Resposta'),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildOption(String option, String text) {
    return Row(
      children: [
        Radio<String>(
          value: option,
          groupValue: null, // Aqui você pode definir o grupo de seleção dos rádios
          onChanged: (String? value) {
            // Lógica para selecionar a alternativa
          },
        ),
        Text(text),
      ],
    );
  }
}