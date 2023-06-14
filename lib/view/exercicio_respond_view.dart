import 'package:flutter/material.dart';
//import 'package:glossario_oclusao/controller/login_controller.dart';
import '../controller/exercicio_controller.dart';

class ExercicioRespondView extends StatefulWidget {
  const ExercicioRespondView({super.key});

  @override
  State<ExercicioRespondView> createState() => _ExercicioRespondViewState();
}

class _ExercicioRespondViewState extends State<ExercicioRespondView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late Map<String, dynamic> exercicio; // Irá receber informações do exercício.
  late ExercicioController _exercicioController;
  //late LoginController _loginController;

  String? opcaoSelecionada; // Variável para armazenar a alternativa selecionada.

  @override
  void initState() {
    super.initState();
    
    _exercicioController = ExercicioController();
    //_loginController = LoginController();
  }

  @override
  Widget build(BuildContext context) {
    exercicio = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final String alunoUid = exercicio['aluno_uid'];
    final String exercicioUid = exercicio['exercicio_uid'];
    final String enunciado = exercicio['enunciado'];
    final String alternativaA = exercicio['alternativa_a'];
    final String alternativaB = exercicio['alternativa_b'];
    final String alternativaC = exercicio['alternativa_c'];
    final String alternativaD = exercicio['alternativa_d'];

    final String criadoEm = exercicio['criado_em'];
    final String atualizadoEm = exercicio['atualizado_em'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0E52C7),
        title: const Text('Exercício de Oclusão'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                'Criado em: $criadoEm \tAtualizado em: $atualizadoEm',
                style: const TextStyle(fontSize: 15, color: Color.fromARGB(137, 0, 0, 0)),
              ),
              const SizedBox(height: 10),
              Text(
                enunciado,
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
              buildOption('a', alternativaA),
              const Divider(),
              buildOption('b', alternativaB),
              const Divider(),
              buildOption('c', alternativaC),
              const Divider(),
              buildOption('d', alternativaD),
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
                      if (_formKey.currentState!.validate()) {
                        if (opcaoSelecionada == null) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Erro'),
                              content: const Text('Por favor, selecione uma alternativa.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        } else {
                          _exercicioController.respostaAdd(context, exercicioUid, alunoUid, opcaoSelecionada);
                        }
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
              "$alternativa) $text",
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
