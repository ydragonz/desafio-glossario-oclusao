import 'package:flutter/material.dart';
import 'package:glossario_oclusao/controller/login_controller.dart';
import 'package:glossario_oclusao/view/nav_bar_view.dart';
import '../controller/termo_controller.dart';

class PrincipalView extends StatefulWidget {
  const PrincipalView({super.key});

  @override
  State<PrincipalView> createState() => _PrincipalViewState();
}

class _PrincipalViewState extends State<PrincipalView> {

  //final usuario = FirebaseAuth.instance.currentUser;
  final LoginController _loginController = LoginController();

  //final usuario = LoginController.usuarioLogado();
  Map<String, String> dadosUsuario = {};

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<Map<String, String>>(
      future: _loginController.usuarioLogado(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Exibir um indicador de carregamento enquanto os dados do usuário estão sendo carregados
          return const CircularProgressIndicator();

        } else if (snapshot.hasError) {
          // Tratar qualquer erro ocorrido ao obter os dados do usuário
          return Text('Erro: ${snapshot.error}');

        } else {
          // Os dados do usuário foram obtidos com sucesso
          dadosUsuario = snapshot.data!;
          
          // Verificar se a variável dadosUsuario contém dados válidos antes de usá-los
          final nomeUsuario = dadosUsuario['nome'] ?? '';
          final emailUsuario = dadosUsuario['email'] ?? '';

          return Scaffold(
            drawer: NavBar(nome: nomeUsuario, email: emailUsuario),
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(255, 14, 82, 199),
              /*leading: IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () {
                  _loginController.logout(context);
                }, 
              ),*/
              title: const Text("Glossário de Oclusão"),
              actions: [
                IconButton(
                  icon: const Icon(Icons.search), 
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: CustomSearchDelegate()
                    );
                  }
                ),
              ],
            ),
            body: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/unaerp_background.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child:
                Center(
                  child: Container(
                    width: 325,
                    height: 150,
                    decoration: const BoxDecoration(
                      
                      color: Colors.black54,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: 
                      Center(
                        child: 
                          Text(
                            "Seja bem vindo(a) de volta \n$nomeUsuario",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                            ),
                          ),
                      )
                      
                    
                  ),
                ),
                
            ),

            floatingActionButton: FloatingActionButton(
              onPressed: () => Navigator.pushNamed(context, '/sobre'),
              backgroundColor: const Color.fromARGB(255, 14, 82, 199),
              child: const Icon(Icons.info_outline),
            ),
          );
        }
      }
    );
  }
}


