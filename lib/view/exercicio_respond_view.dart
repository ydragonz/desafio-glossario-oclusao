import 'package:flutter/material.dart';
import 'package:glossario_oclusao/controller/login_controller.dart';

class ExercicioRespondView extends StatefulWidget {
  const ExercicioRespondView({Key? key}) : super(key: key);

  @override
  _ExercicioRespondViewState createState() => _ExercicioRespondViewState();
}

class _ExercicioRespondViewState extends State<ExercicioRespondView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late LoginController _loginController;
  bool isProf = false;
  String? opcaoSelecionada; // Variável para armazenar a alternativa selecionada

  @override
  void initState() {
    super.initState();
    _loginController = LoginController();
    _loadIsProf();
  }

  Future<void> _loadIsProf() async {
    final prof = await _loginController.isProf();
    setState(() {
      isProf = prof;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0E52C7),
        title: const Text('Exercício de Oclusão'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
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
              if (!isProf)
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
                        if (_formKey.currentState!.validate()) {
                          // Ação a ser realizada quando o botão "Enviar" for pressionado
                          // Aqui você pode acessar a alternativa selecionada através da variável opcaoSelecionada
                          print('Alternativa selecionada: $opcaoSelecionada');
                        }
                      },
                      child: const Text(
                        "Enviar",
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
                    color: Color.fromARGB(255, 116, 116, 116),
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
      ),
    );
  }

  Widget buildOption(String alternativa, String text) {
    return InkWell(
      onTap: () {
        setState(() {
          opcaoSelecionada = alternativa;
        });
      },
      child: Row(
        children: [
          Radio<String>(
            value: alternativa,
            groupValue: opcaoSelecionada,
            onChanged: (String? value) {
              setState(() {
                opcaoSelecionada = value;
              });
            },
          ),
          Flexible(
            child: Text(
              text,
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
