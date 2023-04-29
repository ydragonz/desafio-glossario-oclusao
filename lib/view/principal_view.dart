import 'package:flutter/material.dart';
import 'package:glossario_oclusao/model/termo_model.dart';  // Ainda será implementado.
import 'package:glossario_oclusao/controller/login_controller.dart';

class PrincipalView extends StatefulWidget {
  const PrincipalView({super.key});

  @override
  State<PrincipalView> createState() => _PrincipalViewState();
}

class _PrincipalViewState extends State<PrincipalView> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 14, 82, 199),
        leading: IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            Navigator.of(context).pop();  // Atualizar depois para limpar todas as telas da pilha e voltar para a tela de login
            //logout();  Sera implementada a funcao de logout de login_controller.dart
          }, 
        ),
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
          //Image.asset("assets/logo_unaerp_rounded.png"),
          Center(
            child: Container(
              width: 325,
              height: 150,
              decoration: const BoxDecoration(
                
                color: Colors.black54,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: 
                const Center(
                  child: 
                    Text(
                      "Bem-vindo de volta (usuario)!",
                      style: TextStyle(
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

class CustomSearchDelegate extends SearchDelegate {
  Map<String, String> searchTerms = {
    'Relação Cêntrica (RC)': 'Relacionamento maxilomandibular independente do contato dentário, no qual os côndilos se articulam na posição anterossuperior contra as inclinações posteriores das eminências articulares. Nesta posição, a mandíbula realiza apenas um movimento de rotação. A partir desta posição fisiológica, de relação maxilomandibular, o paciente pode realizar movimentos laterais, verticais ou protrusivos. Clinicamente é uma posição de referência útil e repetível. Portanto, a RC é uma posição condilar que independe dos contatos dentários.',
    'Espaço Funcional Livre (EFL)': 'É a distância entre os dentes antagonistas quando a mandíbula está em posição de repouso postural. É a diferença entre a dimensão vertical de repouso e a de oclusão e apresenta valores médios de 3 mm. O Glossário de termos protéticos, em sua 9ª edição (GPT-9, 2017) conceitua esse espaço como Espaço de Repouso Interoclusal (IORS – interoclusal rest space).',
    'Máxima Intercuspidação Habitual (MIH)': 'Posição de intercuspidação completa dos dentes opostos, independentemente da posição condilar. Às vezes referida como o melhor ajuste dos dentes, independentemente da posição condilar.',
  };

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override 
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) =>
    Padding(
      padding: const EdgeInsets.only(
        top: 30,
        left: 20,
        right: 20,
      ),
      child: Column(
        children: [
          Text(
            query,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox (
            height: 20,
          ),
          Text(
            searchTerms[query]?.toString() ?? '',
            style: const TextStyle(fontSize: 22),
          ),
        ],
      )
      
      
    );

  @override
  Widget buildSuggestions(BuildContext context) {
    Map<String, String> matchQuery = {};
    for (var term in searchTerms.keys) {
      if(term.toLowerCase().contains(query.toLowerCase())) {
        matchQuery[term] = searchTerms[term] ?? '';
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery.keys.toList()[index];

        return ListTile(
          title: Text(result),
          onTap: () {
            query = result;

            showResults(context);
          },
        );
      },
    );
  }
}
