import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../controller/exercicio_controller.dart';
import '../controller/login_controller.dart';
import '../controller/relatorio_controller.dart';

class RelatoriosView extends StatefulWidget {
  const RelatoriosView({Key? key}) : super(key: key);

  @override
  State<RelatoriosView> createState() => _RelatoriosViewState();
}

class _RelatoriosViewState extends State<RelatoriosView> {
  late RelatorioController _relatorioController;
  late ExercicioController _exercicioController;
  late LoginController _loginController;
  Future<List<DocumentSnapshot>>? _exerciciosFuture;
  Future<List<DocumentSnapshot>>? _alunosFuture;
  int _currentIndex = 1;
  late String? _alunoUid; // Renomeado para _alunoUid

  @override
  void initState() {
    super.initState();
    _relatorioController = RelatorioController();
    _exercicioController = ExercicioController();
    _loginController = LoginController();
    _alunoUid = null; // Inicializa _alunoUid como nulo
    _loadExercicios();
    _loadAlunos();
    _loadAlunoUid();
  }

  Future<void> _loadExercicios() async {
    final exercicios = await _exercicioController.getExercicios();
    setState(() {
      _exerciciosFuture = Future.value(exercicios);
    });
  }

  Future<void> _loadAlunos() async {
    final alunos = await _loginController.getAlunos();
    setState(() {
      _alunosFuture = Future.value(alunos);
    });
  }

  Future<void> _loadAlunoUid() async {
    final String? uid = await _loginController.getUidUsuarioLogado();
    setState(() {
      _alunoUid = uid;
    });
  }

  List<Widget Function(BuildContext)> body = [
    (context) => relatoriosAluno(context),
    (context) => relatoriosExercicio(context),
  ];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection('usuarios')
          .where('uid', isEqualTo: _alunoUid)
          .limit(1)
          .get()
          .then((querySnapshot) => querySnapshot.docs.first),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Erro ao carregar usuário')),
          );
        } else if (snapshot.hasData) {
          final userData = snapshot.data!.data() as Map<String, dynamic>?;
          print(userData?['nome']);

          if (userData != null) {
            final isProfessor = userData['professor'] ?? false;


            return Scaffold(
              appBar: AppBar(
                backgroundColor: const Color(0xFF0E52C7),
                title: const Text("Relatórios"),
              ),
              body: body[_currentIndex](context),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: _currentIndex,
                onTap: (int newIndex) {
                  setState(() {
                    if (newIndex == 0 && !isProfessor) { // Verifica se o índice selecionado é o da aba "Exercicios"
                      // Exibe uma mensagem de acesso negado
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("Acesso Negado"),
                          content: Text("Você não tem permissão para acessar esta função."),
                          actions: [
                            TextButton(
                              child: Text("OK"),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                      );
                    } else {
                      _currentIndex = newIndex;
                    }
                  });
                },
                items: [
                  BottomNavigationBarItem(
                    label: "Alunos",
                    icon: Icon(Icons.person),
                  ),
                  BottomNavigationBarItem(
                    label: "Exercicios",
                    icon: Icon(Icons.book),
                  ),
                ],
              ),
            );
          
          } else {
            return const Scaffold(
              body: Center(child: Text('Dados não encontrados')),
            );
          }
        } else {
          return const Scaffold(
            body: Center(child: Text('Usuário não encontrado')),
          );
        }
      },
    );
  }
}

Widget relatoriosAluno(BuildContext context) {
  return Container(
    padding: const EdgeInsets.only(
      top: 20,
      left: 10,
      right: 10,
    ),
    child: FutureBuilder<List<DocumentSnapshot>>(
      future: _getAlunos(), // Função que busca a lista de alunos
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Erro ao carregar alunos'));
        } else if (snapshot.hasData) {
          final alunos = snapshot.data!;
          return ListView.builder(
            itemCount: alunos.length,
            itemBuilder: (context, index) {
              final aluno = alunos[index].data() as Map<String, dynamic>;
              final nome = aluno['nome'] as String;
              final codigo = aluno['codigo'] as String;

              return Card(
                child: ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(nome),
                  subtitle: Text('Código: $codigo'),
                  onTap: () {
                    // Ação quando um aluno é selecionado
                  },
                ),
              );
            },
          );
        } else {
          return const Center(child: Text('Sem alunos disponíveis'));
        }
      },
    ),
  );
}

Future<List<DocumentSnapshot>> _getAlunos() async {
  final alunosSnapshot = await FirebaseFirestore.instance.collection('usuarios').where('professor', isEqualTo: false).get();
  return alunosSnapshot.docs;
}

Widget relatoriosExercicio(BuildContext context) {
  return Container();
}
