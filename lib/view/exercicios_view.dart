import 'package:flutter/material.dart';
import '../controller/login_controller.dart';

class ExerciciosView extends StatefulWidget {
  const ExerciciosView({Key? key}) : super(key: key);

  @override
  State<ExerciciosView> createState() => _ExerciciosViewState();
}

class _ExerciciosViewState extends State<ExerciciosView> {
  late LoginController _loginController;
  bool isProf = false;

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
        title: const Text("Exercícios"),
      ),
      body: Container(
        padding: const EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
        ),
        child: ListView.builder(
          itemCount: 15, // mudar dps
          itemBuilder: (context, index) => Card(
            child: ListTile(
              leading: const Icon(Icons.assignment_outlined),
              title: const Text("Exercício de Oclusão"),
              subtitle: Text("Criado: "), //Text("Por Jeremias Alberto Nunes"),
              /*trailing: IconButton(
                icon: Icon(Icons.edit_outlined),
                onPressed: () {
                },
              ),*/
              onTap: () {
                if (!isProf) {
                  Navigator.pushNamed(context, '/exercicio_respond');
                } else {
                  Navigator.pushNamed(context, '/exercicio_detalhes');
                }
              },
            ),
          ),
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
