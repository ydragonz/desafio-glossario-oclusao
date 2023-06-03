import 'package:flutter/material.dart';
import 'package:glossario_oclusao/controller/login_controller.dart';

class CadastroView extends StatefulWidget {
  const CadastroView({super.key});

  @override
  State<CadastroView> createState() => _CadastroViewState();
}

class _CadastroViewState extends State<CadastroView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _codigoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  final LoginController _loginController = LoginController();
  /*
  @override
  void initState() {
    super.initState();
  }
  */

  @override
  void dispose() {
    _nomeController.dispose();
    _codigoController.dispose();
    _emailController.dispose();
    _senhaController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0E52C7),
      ),

      body: Container(
        padding: const EdgeInsets.only(
          top: 40,
          left: 25,
          right: 25,
        ),

        child: Form(
          key: _formKey,

          child: Column(
            children: <Widget>[
              SizedBox(
                width: 100,
                height: 100,
                child: Image.asset("assets/user_icon.png"),
              ),

              const SizedBox(
                height: 40,
              ),

              TextFormField(
                controller: _nomeController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.account_box_rounded),
                  labelText: "Nome",
                  labelStyle: TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                ),
                style: const TextStyle(
                  fontSize: 20,
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Por favor, insira seu nome';
                  }
                  return null;
                }
              ),

              const SizedBox(
                height: 10,
              ),

              TextFormField(
                controller: _codigoController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.assignment),
                  labelText: "Código de matrícula",
                  labelStyle: TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                ),
                style: const TextStyle(
                  fontSize: 20,
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Por favor, insira seu código de matrícula';
                  }
                  return null;
                }
              ),

              const SizedBox(
                height: 10,
              ),

              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  labelText: "E-mail",
                  labelStyle: TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                ),
                style: const TextStyle(
                  fontSize: 20,
                ),
                validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Por favor, insira seu e-mail';
                }
                if (value != null && !value.endsWith('@sou.unaerp.edu.br')) {
                  return 'Por favor, insira um e-mail institucional válido';
                }
                return null;
              },
              ),

              const SizedBox(
                height: 10,
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
                style: const TextStyle(
                  fontSize: 20,
                ),
                validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Por favor, insira sua senha';
                }
                return null;
              },
              ),

              const SizedBox(
                height: 30,
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
                        _loginController.criarConta(
                          context, 
                          _nomeController.text, 
                          _codigoController.text,
                          _emailController.text,
                          _senhaController.text,
                        );
                      }
                    },
                    child: const Text(
                      "Enviar",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    )
                    
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      /*
      
      Codigo de teste de verificacao de formulario, atualizar para o novo layout depois.
      
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira seu nome';
                  }
                  return null;
                },
                onSaved: (value) => _nome = value,
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(labelText: 'Matrícula'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira sua matrícula';
                  }
                  return null;
                },
                onSaved: (value) => _matricula = value,
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(labelText: 'E-mail'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira seu e-mail';
                  }
                  if (!value.endsWith('@sou.unaerp.edu.br')) {
                    return 'Apenas alunos podem se cadastrar na plataforma';
                  }
                  return null;
                },
                onSaved: (value) => _email = value,
              ),
              SizedBox(height: 16.0),

              Container(
                height: 60,
                alignment: Alignment.centerLeft,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 41, 109, 228),
                  borderRadius: BorderRadius.all(Radius.circular(10),),
                ),
                child: SizedBox.expand(
                  child: TextButton(
                    onPressed: _submitForm,
                    child: const Text(
                      "Cadastrar",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    )
                    
                  ),
                ),
              ),
            ],
          ),
        ),
      ),*/
    );
  

  /*void _submitForm() {
    final form = _formKey.currentState;
    if (form != null && form.validate()) {
      form.save();
    }
  }*/
}
