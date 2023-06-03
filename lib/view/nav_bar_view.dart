import 'package:flutter/material.dart';
import 'package:glossario_oclusao/controller/login_controller.dart';

class NavBar extends StatelessWidget {
  final String nome;
  final String email;
  final LoginController loginController;

  const NavBar({
    required this.nome,
    required this.email,
    required this.loginController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(nome),
            accountEmail: Text(email),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset('assets/user_icon.png'),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.assignment),
            title: const Text("Atividades"),
            onTap: () => Navigator.pushNamed(context, '/atividades'),
          ),
          ListTile(
            leading: const Icon(Icons.insert_drive_file),
            title: const Text("Relatórios"),
            onTap: () => Navigator.pushNamed(context, '/relatorios'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text("Sobre nós"),
            onTap: () => Navigator.pushNamed(context, '/sobre'),
          ),              
          ListTile(
            
            leading: const Icon(Icons.logout),
            title: const Text("Sair"),
            onTap: () => loginController.logout(context),
          ),
        ],
      ),
    );
  }
}
