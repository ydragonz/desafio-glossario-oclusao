import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final String nome;
  final String email;

  const NavBar({
    required this.nome,
    required this.email,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    

    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(accountName: Text(nome), accountEmail: Text(email))
        ],
      ),

    );
  }
}