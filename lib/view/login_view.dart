import 'package:flutter/material.dart';
import 'package:glossario_oclusao/controller/login_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  final LoginController _loginController = LoginController();

  /*@override
  void dispose() {
    _emailController.dispose();
    _senhaController.dispose();

    super.dispose();
  }*/

  /*@override
  void initState() {
    super.initState();
  }*/

  @override
  Widget build(BuildContext context) => Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 120, left: 25, right: 25,),
        color: Colors.white10,
        child: Form(
          key: _formKey,
          child: Column(

            children: <Widget>[
              Container (
                width: 128,
                height: 128,
                
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),

                child: Image.asset("assets/logo_unaerp_rounded.png",),
              ),

              const SizedBox (
                height: 50,
              ),

              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  labelText: "E-mail",
                  labelStyle: TextStyle(
                    color: Colors.black38,
                    fontWeight:FontWeight.w400,
                    fontSize: 20,
                  )
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Por favor, insira seu e-mail';
                  }
                  if (value != null && !value.endsWith('@sou.unaerp.edu.br') && !value.endsWith('@unaerp.br')) {
                    return 'Por favor, insira um e-mail institucional válido';
                  }
                  return null;
                }
              ),

              const SizedBox (
                height: 20,
              ),

              TextFormField(
                controller: _senhaController,
                keyboardType: TextInputType.text,
                obscureText: true,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  labelText: "Senha",
                  labelStyle: TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                ),
                style: const TextStyle(fontSize: 20),
                validator: (value) {
                  if(value?.isEmpty ?? true) {
                    return 'Por favor, insira sua senha';
                  }
                },
              ),

              const SizedBox (
                height: 5,
              ),

              Container(
                height: 40,
                alignment: Alignment.centerRight,
                child: TextButton(
                  child: const Text(
                    "Esqueceu a senha?",
                  ),
                  
                  onPressed: () {
                    Navigator.pushNamed(context, '/esqueceu_senha');
                  },
                ),
              ),

              const SizedBox (
                height: 50,
              ),

              Container(
                height: 60,
                alignment: Alignment.centerLeft,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 41, 109, 228),
                  borderRadius: BorderRadius.all(Radius.circular(10),),
                ),
                child: SizedBox.expand(
                  child: TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _loginController.login(context, _emailController.text, _senhaController.text);
                      }
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    )
                    
                  ),
                ),
              ),

              const SizedBox (
                height: 5,
              ),

              SizedBox(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('Ainda não tem conta?', textAlign: TextAlign.center,),
                    TextButton(
                      child: const Text(
                        "Cadastre-se",
                        textAlign: TextAlign.center,
                      ),
                      onPressed: () => Navigator.pushNamed(context, '/cadastro'),
                    ),
                  ],
                ),
              ),
            ],
          )
        ),
      ));
}
