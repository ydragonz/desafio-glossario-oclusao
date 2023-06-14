import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../controller/exercicio_controller.dart';
import '../controller/login_controller.dart';

class RelatoriosView extends StatefulWidget {
  const RelatoriosView({Key? key}) : super(key: key);

  @override
  State<RelatoriosView> createState() => _RelatoriosViewState();
}

class _RelatoriosViewState extends State<RelatoriosView> {
  late LoginController _loginController;
  int _currentIndex = 1;
  late String? _alunoUid;

  @override
  void initState() {
    super.initState();
    _loginController = LoginController();
    _alunoUid = null; // Inicializa _alunoUid como nulo
    _loadAlunoUid();
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
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return const Scaffold(
            body: Center(child: Text('Erro ao carregar usuário')),
          );
        } else if (snapshot.hasData) {
          final userData = snapshot.data!.data() as Map<String, dynamic>?;

          if (userData != null) {
            final isProfessor = userData['professor'] ?? false;

            return Scaffold(
              appBar: AppBar(
                backgroundColor: const Color(0xFF0E52C7),
                title: Text(_currentIndex == 0 ? 'Relatórios de Alunos' : 'Relatórios de Exercícios'),
                actions: _currentIndex == 0 ? [_buildSearchButton()] : null,
              ),
              body: body[_currentIndex](context),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: _currentIndex,
                onTap: (int newIndex) {
                  setState(() {
                    if (newIndex == 0 && !isProfessor) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Acesso Negado"),
                          content: const Text("Você não tem permissão para acessar esta função."),
                          actions: [
                            TextButton(
                              child: const Text("OK"),
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
                items: const [
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

  Widget _buildSearchButton() {
    return IconButton(
      icon: const Icon(Icons.search),
      onPressed: () {
        showSearch(
          context: context,
          delegate: AlunoSearchDelegate(),
        );
      },
    );
  }
}

class AlunoSearchDelegate extends SearchDelegate<String> {
  final _loginController = LoginController();

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      appBarTheme: theme.appBarTheme.copyWith(
        backgroundColor: const Color(0xFF0E52C7),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.white54),
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<DocumentSnapshot>>(
      future: _loginController.getAlunos(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Erro ao carregar alunos'));
        } else if (snapshot.hasData) {
          final List<DocumentSnapshot> alunos = snapshot.data!;
          final List<DocumentSnapshot> filteredAlunos = alunos.where((aluno) {
            final Map<String, dynamic> data = aluno.data() as Map<String, dynamic>;
            final nome = data['nome'].toString().toLowerCase();
            final codigo = data['codigo'].toString().toLowerCase();
            final queryLower = query.toLowerCase();
            return nome.contains(queryLower) || codigo.contains(queryLower);
          }).toList();

          return ListView.builder(
            itemCount: filteredAlunos.length,
            itemBuilder: (context, index) {
              final aluno = filteredAlunos[index].data() as Map<String, dynamic>;
              final nome = aluno['nome'] as String;
              final codigo = aluno['codigo'] as String;

              return ListTile(
                title: Text(nome),
                subtitle: Text('Código: $codigo'),
                onTap: () {

                  close(context, codigo); // Retorna o código do aluno selecionado
                },
              );
            },
          );
        } else {
          return const Center(child: Text('Sem alunos disponíveis'));
        }
      },
    );
  }
}

Widget relatoriosAluno(BuildContext context) {
  return Container(
    padding: const EdgeInsets.only(
      top: 10,
      left: 10,
      right: 10,
    ),
    child: FutureBuilder<List<DocumentSnapshot>>(
      future: _getAlunos(),
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
              final alunoUid = aluno['uid'] as String;

              return Card(
                child: ListTile(
                  leading: Icon(Icons.person),
                  title: Text(nome),
                  subtitle: Text('Código: $codigo'),
                  onTap: () {
                    Navigator.pushNamed(context, '/relatorio_aluno', arguments: {'uid': alunoUid});
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

Widget relatoriosExercicio(BuildContext context) {
  return Container(
    padding: const EdgeInsets.only(
      top: 10,
      left: 10,
      right: 10,
    ),
    child: FutureBuilder<QuerySnapshot>(
      future: _getExercicios(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Erro ao carregar exercícios'));
        } else if (snapshot.hasData) {
          final exercicios = snapshot.data!.docs;
          return ListView.builder(
            itemCount: exercicios.length,
            itemBuilder: (context, index) {
              final exercicio = exercicios[index];
              final enunciado = exercicio['enunciado'] as String;
              final criadoEm = exercicio['criado_em'] as Timestamp;
              final dateTime = criadoEm.toDate();
              final criadoEmAtualizado = ExercicioController().formatDateTime(dateTime);
              final enunciadoCortado = enunciado.length > 30 ? '${enunciado.substring(0, 30)}...' : enunciado;

              final exercicioUid = exercicio.id;
              

              return Card(
                child: ListTile(
                  leading: Icon(Icons.book),
                  title: Text(enunciadoCortado),
                  subtitle: Text('Criado em: $criadoEmAtualizado'),
                  onTap: () {
                    Navigator.pushNamed(context, '/relatorio_exercicio', arguments: {'uid': exercicioUid});
                  },
                ),
              );
            },
          );
        } else {
          return const Center(child: Text('Sem exercícios disponíveis'));
        }
      },
    ),
  );
}




Future<List<DocumentSnapshot>> _getAlunos() async {
  final alunosSnapshot = await FirebaseFirestore.instance.collection('usuarios').where('professor', isEqualTo: false).get();
  return alunosSnapshot.docs;
}

Future<QuerySnapshot<Object?>> _getExercicios() async {
  final exerciciosRef = FirebaseFirestore.instance.collection('exercicios');
  final exerciciosSnapshot = await exerciciosRef.get();
  return exerciciosSnapshot;
}
