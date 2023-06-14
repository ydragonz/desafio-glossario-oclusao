import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../controller/exercicio_controller.dart';
import '../controller/login_controller.dart';
//import 'exercicio_detalhes_view.dart';

class ExerciciosView extends StatefulWidget {
  const ExerciciosView({Key? key}) : super(key: key);

  @override
  State<ExerciciosView> createState() => _ExerciciosViewState();
}
class _ExerciciosViewState extends State<ExerciciosView> {
  late ExercicioController _exercicioController;
  late LoginController _loginController;
  Future<List<DocumentSnapshot>>? _exerciciosFuture;
  late bool isProf = false;
  late String? alunoUid;

  @override
  void initState() {
    super.initState();
    _exercicioController = ExercicioController();
    _loginController = LoginController();
    _loadExercicios();
    _loadAlunoUid();
    _loadIsProf();
  }

  Future<void> _loadExercicios() async {
    final exercicios = await _exercicioController.getExercicios();
    setState(() {
      _exerciciosFuture = Future.value(exercicios);
    });
  }

  Future<void> _loadAlunoUid() async {
    final String? uid = await _loginController.getUidUsuarioLogado();
    setState(() {
      alunoUid = uid;
    });
  }

  Future<void> _loadIsProf() async {
    final isProfessor = await _loginController.isProf();
    setState(() {
      isProf = isProfessor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0E52C7),
        title: const Text("Exercícios"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/exercicios');
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(
          top: 20,
          left: 10,
          right: 10,
        ),
        child: FutureBuilder<List<DocumentSnapshot>>(
          future: _exerciciosFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Erro ao carregar exercícios'));
            } else if (snapshot.hasData) {
              final exercicios = snapshot.data!;
              return ListView.builder(
                itemCount: exercicios.length,
                itemBuilder: (context, index) {
                  final exercicio = exercicios[index].data() as Map<String, dynamic>;
                  final criadoEm = (exercicio['criado_em'] as Timestamp).toDate() as DateTime;
                  final atualizadoEm = (exercicio['atualizado_em'] as Timestamp).toDate() as DateTime;

                  final criadoEmFormatted = _exercicioController.formatDateTime(criadoEm);
                  final atualizadoEmFormatted = _exercicioController.formatDateTime(atualizadoEm);


                  //final bool ativo = _exercicioController.isAtivo(exercicio['ativo']);
                  
                  if(exercicio['ativo']) { // Implementar verificação se o exercício está ativo
                    return Card(
                    child: ListTile(
                      leading: const Icon(Icons.assignment_outlined),
                      title: const Text("Exercício de Oclusão"),
                      subtitle: Text(
                        'Criado em: $criadoEmFormatted\nAtualizado em: $atualizadoEmFormatted',
                      ),
                      onTap: () {
                        if (!isProf) {
                          Navigator.pushNamed(
                            context, '/exercicio_respond',
                            arguments: {
                              'aluno_uid': alunoUid,
                              'exercicio_uid': exercicios[index].id,
                              'enunciado': exercicio['enunciado'],
                              'alternativa_a': exercicio['alternativa_a'],
                              'alternativa_b': exercicio['alternativa_b'],
                              'alternativa_c': exercicio['alternativa_c'],
                              'alternativa_d': exercicio['alternativa_d'],
                              'criado_em': criadoEmFormatted,
                              'atualizado_em': atualizadoEmFormatted,
                            },
                          );
                        } else {
                          Navigator.pushNamed(
                            context,
                            '/exercicio_detalhes',
                            arguments: {
                              'uid': exercicios[index].id,
                              'enunciado': exercicio['enunciado'],
                              'alternativa_a': exercicio['alternativa_a'],
                              'alternativa_b': exercicio['alternativa_b'],
                              'alternativa_c': exercicio['alternativa_c'],
                              'alternativa_d': exercicio['alternativa_d'],
                              'alternativa_correta': exercicio['alternativa_correta'],
                              'criado_em': criadoEmFormatted,
                              'atualizado_em': atualizadoEmFormatted,
                              'ativo': exercicio['ativo'],
                            },
                          );
                        }
                      },
                    ),
                  );
                  } else {
                    return Container();
                  }
                  
                },
              );
            } else {
              return const Center(child: Text('Sem exercícios disponíveis'));
            }
          },
        ),
      ),
      floatingActionButton: isProf
          ? FloatingActionButton(
              onPressed: () => Navigator.pushNamed(context, '/exercicio_add'),
              backgroundColor: const Color.fromARGB(255, 14, 82, 199),
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
