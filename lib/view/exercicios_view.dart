import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../controller/exercicio_controller.dart';
import '../controller/login_controller.dart';

class ExerciciosView extends StatefulWidget {
  const ExerciciosView({Key? key}) : super(key: key);

  @override
  State<ExerciciosView> createState() => _ExerciciosViewState();
}

class _ExerciciosViewState extends State<ExerciciosView> {
  late ExercicioController _exercicioController;
  late LoginController _loginController;
  bool isProf = false;
  late Future<List<DocumentSnapshot>> _exerciciosFuture;

  @override
  void initState() {
    super.initState();
    _exercicioController = ExercicioController();
    _loadIsProf();
    _exerciciosFuture = _loadExercicios();
  }

  Future<void> _loadIsProf() async {
    final isProfessor = await _loginController.isProf();
    setState(() {
      isProf = isProfessor;
    });
  }

  Future<List<DocumentSnapshot>> _loadExercicios() async {
    return _exercicioController.getExercicios();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0E52C7),
        title: const Text("Exercícios"),
      ),
      body: Container(
        padding: const EdgeInsets.only(
          top: 20,
          left: 12,
          right: 12,
        ),
        child: FutureBuilder<List<DocumentSnapshot>>(
          future: _exerciciosFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final exercicios = snapshot.data!;
              return ListView.builder(
                itemCount: exercicios.length,
                itemBuilder: (context, index) {
                  final exercicio = exercicios[index].data() as Map<String, dynamic>;
                  final enunciado = exercicio['enunciado'] as String;
                  final criadoEm = (exercicio['criado_em'] as Timestamp).toDate() as DateTime;
                  final atualizadoEm = (exercicio['atualizado_em'] as Timestamp).toDate() as DateTime;


                  final criadoEmFormatted = _exercicioController.formatDateTime(criadoEm);
                  final atualizadoEmFormatted = _exercicioController.formatDateTime(atualizadoEm);


                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.assignment_outlined),
                      title: const Text("Exercício de Oclusão"),
                      subtitle: Text(
                        'Criado em: $criadoEmFormatted\nAtualizado em: $atualizadoEmFormatted',
                      ),
                      onTap: () {
                        if (!isProf) {
                          Navigator.pushNamed(context, '/exercicio_respond');
                        } else {
                          Navigator.pushNamed(context, '/exercicio_detalhes');
                        }
                      },
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Erro ao carregar exercícios'));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
      floatingActionButton: isProf
          ? FloatingActionButton(
              onPressed: () =>
                  Navigator.pushNamed(context, '/exercicio_add'),
              backgroundColor: const Color.fromARGB(255, 14, 82, 199),
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}

