import 'package:flutter/material.dart';
import '../controller/exercicio_controller.dart';

class ExercicioEditView extends StatefulWidget {
  const ExercicioEditView({Key? key}) : super(key: key);

  @override
  State<ExercicioEditView> createState() => _ExercicioEditViewState();
}

class _ExercicioEditViewState extends State<ExercicioEditView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _enunciadoController = TextEditingController();
  final TextEditingController _alternativaAController = TextEditingController();
  final TextEditingController _alternativaBController = TextEditingController();
  final TextEditingController _alternativaCController = TextEditingController();
  final TextEditingController _alternativaDController = TextEditingController();
  String? _alternativaCorreta;
  bool? _ativo;
  String? _exercicioUid;

  final ExercicioController _exercicioController = ExercicioController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      final Map<String, dynamic> exercicio =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

      setState(() {
        _ativo = exercicio['ativo'];
        _exercicioUid = exercicio['uid'];
        _enunciadoController.text = exercicio['enunciado'];
        _alternativaAController.text = exercicio['alternativa_a'];
        _alternativaBController.text = exercicio['alternativa_b'];
        _alternativaCController.text = exercicio['alternativa_c'];
        _alternativaDController.text = exercicio['alternativa_d'];
        _alternativaCorreta = exercicio['alternativa_correta'];
      });
    });
  }

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
        title: const Text('Editar exercício'),
        backgroundColor: const Color(0xFF0E52C7),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: const EdgeInsets.only(
          top: 20,
          left: 10,
          right: 10,
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
                height: 25,
              ),
              const Text(
                "Status:",
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
                  Row(
                    children: [
                      Radio<bool>(
                        value: true,
                        groupValue: _ativo,
                        onChanged: (bool? value) {
                          setState(() {
                            _ativo = value!;
                          });
                        },
                      ),
                      const Text('Ativo'),
                    ],
                  ),
                  Row(
                    children: [
                      Radio<bool>(
                        value: false,
                        groupValue: _ativo,
                        onChanged: (bool? value) {
                          setState(() {
                            _ativo = value!;
                          });
                        },
                      ),
                      const Text('Inativo'),
                    ],
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
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text("Selecione uma alternativa correta"),
                            backgroundColor: Colors.red,
                          ));
                        } else {
                          _exercicioController.exercicioEdit(
                            context,
                            _exercicioUid,
                            _enunciadoController.text,
                            _alternativaAController.text,
                            _alternativaBController.text,
                            _alternativaCController.text,
                            _alternativaDController.text,
                            _alternativaCorreta,
                            _ativo,
                          );
                        }
                      }
                    },
                    child: const Text(
                      "Salvar",
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
