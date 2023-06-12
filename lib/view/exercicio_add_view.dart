import 'package:flutter/material.dart';
import '../controller/exercicio_controller.dart';

class ExercicioAddView extends StatefulWidget {
  const ExercicioAddView({Key? key}) : super(key: key);

  @override
  State<ExercicioAddView> createState() => _ExercicioAddViewState();
}

class _ExercicioAddViewState extends State<ExercicioAddView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _enunciadoController = TextEditingController();
  final TextEditingController _alternativaAController = TextEditingController();
  final TextEditingController _alternativaBController = TextEditingController();
  final TextEditingController _alternativaCController = TextEditingController();
  final TextEditingController _alternativaDController = TextEditingController();
  String? _alternativaCorreta;

  final ExercicioController _exercicioController = ExercicioController();

  @override
  void dispose() {
    _enunciadoController.dispose();
    _alternativaAController.dispose();
    _alternativaBController.dispose();
    _alternativaCController.dispose();
    _alternativaDController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar exercício'),
        backgroundColor: const Color(0xFF0E52C7),
      ),
      body: Container(
        padding: const EdgeInsets.only(
          top: 20,
          left: 25,
          right: 25,
        ),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _enunciadoController,
                keyboardType: TextInputType.multiline,
                minLines: 4,
                maxLines: 10,
                decoration: const InputDecoration(
                  labelText: 'Enunciado:',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(
                    color: Color.fromARGB(182, 0, 0, 0),
                    fontWeight: FontWeight.w400,
                    fontSize: 25,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
                style: const TextStyle(
                  fontSize: 20,
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Por favor, não deixe o enunciado em branco';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 25,
              ),
              TextFormField(
                controller: _alternativaAController,
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'A)',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(
                    color: Color.fromARGB(182, 0, 0, 0),
                    fontWeight: FontWeight.w400,
                    fontSize: 25,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
                style: const TextStyle(
                  fontSize: 20,
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Por favor, digite a alternativa A)';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 25,
              ),
              TextFormField(
                controller: _alternativaBController,
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'B)',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(
                    color: Color.fromARGB(182, 0, 0, 0),
                    fontWeight: FontWeight.w400,
                    fontSize: 25,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
                style: const TextStyle(
                  fontSize: 20,
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Por favor, digite a alternativa B)';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 25,
              ),
              TextFormField(
                controller: _alternativaCController,
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'C)',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(
                    color: Color.fromARGB(182, 0, 0, 0),
                    fontWeight: FontWeight.w400,
                    fontSize: 25,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
                style: const TextStyle(
                  fontSize: 20,
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Por favor, digite a alternativa C)';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 25,
              ),
              TextFormField(
                controller: _alternativaDController,
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'D)',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(
                    color: Color.fromARGB(182, 0, 0, 0),
                    fontWeight: FontWeight.w400,
                    fontSize: 25,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
                style: const TextStyle(
                  fontSize: 20,
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Por favor, digite a alternativa D)';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                "Alternativa correta:",
                style: TextStyle(
                  color: Color.fromARGB(182, 0, 0, 0),
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        Radio<String>(
                          value: "a",
                          groupValue: _alternativaCorreta,
                          onChanged: (String? value) {
                            setState(() {
                              _alternativaCorreta = value;
                            });
                          },
                        ),
                        const Expanded(
                          child: Text('A)'),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        Radio<String>(
                          value: "b",
                          groupValue: _alternativaCorreta,
                          onChanged: (String? value) {
                            setState(() {
                              _alternativaCorreta = value;
                            });
                          },
                        ),
                        const Expanded(child: Text('B)'))
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        Radio<String>(
                          value: "c",
                          groupValue: _alternativaCorreta,
                          onChanged: (String? value) {
                            setState(() {
                              _alternativaCorreta = value;
                            });
                          },
                        ),
                        const Expanded(child: Text('C)'))
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        Radio<String>(
                          value: "d",
                          groupValue: _alternativaCorreta,
                          onChanged: (String? value) {
                            setState(() {
                              _alternativaCorreta = value;
                            });
                          },
                        ),
                        const Expanded(child: Text('D)'))
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 60,
                alignment: Alignment.centerLeft,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 41, 109, 228),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: SizedBox.expand(
                  child: TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (_alternativaCorreta == null) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Selecione uma alternativa correta"), backgroundColor: Colors.red,));
                        } else {
                          _exercicioController.exercicioAdd(
                            context,
                            _enunciadoController.text,
                            _alternativaAController.text,
                            _alternativaBController.text,
                            _alternativaCController.text,
                            _alternativaDController.text,
                            _alternativaCorreta,
                          );
                        }
                      }
                    },
                    child: const Text(
                      "Enviar",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
              
              const SizedBox(
                height: 2,
              ),
              Container(
                height: 60,
                alignment: Alignment.centerLeft,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(182, 116, 116, 116),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: SizedBox.expand(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Cancelar",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
