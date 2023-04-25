import 'package:flutter/material.dart';

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
            Navigator.of(context).pop();
            logout();
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
    );
  }
}

logout() {
  // Codigo para realizar logout será implementado aqui.
}

class CustomSearchDelegate extends SearchDelegate {
  List<String> searchTerms = [
    'Relação Cêntrica (RC)',
    'Espaço Funcional Livre (EFL)',
    'Máxima Intercuspidação Habitual (MIH)',
  ];

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
            style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
          ),
          const SizedBox (
            height: 20,
          ),
          Text(
            query, // Atualizar para passar a descricao.
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      )
      
      
    );

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var term in searchTerms) {
      if(term.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(term);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];

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
