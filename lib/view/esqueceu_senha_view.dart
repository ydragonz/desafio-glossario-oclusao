import 'package:flutter/material.dart';
import 'package:glossario_oclusao/controller/login_controller.dart';

class EsqueceuSenhaView extends StatefulWidget {
  
  const EsqueceuSenhaView({super.key});

  @override
  State<EsqueceuSenhaView> createState() => _EsqueceuSenhaViewState();
}

class _EsqueceuSenhaViewState extends State<EsqueceuSenhaView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  final LoginController _loginController = LoginController();

  @override
  void dispose() {
    _emailController.dispose();

    super.dispose();
  }
  /*
  @override
  void initState() {
    super.initState();
  }*/


  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: const Color.fromARGB(255, 14, 82, 199),
    ),

    body: Container(
      padding: const EdgeInsets.only(
        top: 50,
        left: 10,
        right: 10,
      ),

      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            SizedBox(
              width: 200,
              height: 200,
              child: Image.asset("assets/password_reset_icon.png"),
            ),

            const SizedBox(
              height: 20,
            ),

            const Text(
              "Esqueceu sua senha?",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            const Text(
              "Por favor, digite o seu e-mail institucional (deve terminar em @sou.unaerp.edu.br) e então enviaremos um link para redefinição de senha.",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(
              height: 20,
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
                        //try {
                          _loginController.esqueceuSenha(context, _emailController.text);
                        /*} catch (e) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Erro de autenticação'),
                              content: Text(e.toString()),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            ),
                          );
                        }*/
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
      )
      
      

        
      
    )

  );

}