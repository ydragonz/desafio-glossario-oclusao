
import 'package:flutter/material.dart';

class CadastroView extends StatefulWidget {
  const CadastroView({super.key});

  @override
  State<CadastroView> createState() => _CadastroViewState();
}

class _CadastroViewState extends State<CadastroView> {
  /*final _formKey = GlobalKey<FormState>();

  String? _nome;
  String? _matricula;
  String? _email;*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0E52C7),
      ),

      body: Container(
        padding: const EdgeInsets.only(
          top: 40,
          left: 40,
          right: 40,
        ),

        child: ListView(
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
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
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
            ),

            const SizedBox(
              height: 10,
            ),

            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
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
            ),

            const SizedBox(
              height: 10,
            ),

            TextFormField(
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: const InputDecoration(
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
                    var snackBar = const SnackBar(content: Text('Usuário cadastrado!'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    Navigator.pop(context);
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
        )
      )

      /*body: Padding(
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
  }

  /*void _submitForm() {
    final form = _formKey.currentState;
    if (form != null && form.validate()) {
      form.save();
    }
  }*/
}
