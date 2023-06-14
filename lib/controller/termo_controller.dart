import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate {

  // Termos relacionados a oclusão dentária
  Map<String, String> searchTerms = {
    'Relação Cêntrica (RC)': 'Relacionamento maxilomandibular independente do contato dentário, no qual os côndilos se articulam na posição anterossuperior contra as inclinações posteriores das eminências articulares. Nesta posição, a mandíbula realiza apenas um movimento de rotação. A partir desta posição fisiológica, de relação maxilomandibular, o paciente pode realizar movimentos laterais, verticais ou protrusivos. Clinicamente é uma posição de referência útil e repetível. Portanto, a RC é uma posição condilar que independe dos contatos dentários.',
    'Espaço Funcional Livre (EFL)': 'É a distância entre os dentes antagonistas quando a mandíbula está em posição de repouso postural. É a diferença entre a dimensão vertical de repouso e a de oclusão e apresenta valores médios de 3 mm. O Glossário de termos protéticos, em sua 9ª edição (GPT-9, 2017) conceitua esse espaço como Espaço de Repouso Interoclusal (IORS – interoclusal rest space).',
    'Máxima Intercuspidação Habitual (MIH)': 'Posição de intercuspidação completa dos dentes opostos, independentemente da posição condilar. Às vezes referida como o melhor ajuste dos dentes, independentemente da posição condilar.',
    'Curva de Spee': 'Curva anteroposterior que se estende da ponta do canino até as cúspides do último dente, em formato ascendente.',
    'Curva de Wilson': 'Curva mediolateral. Em teoria, a oclusão deve ser esférica, a curvatura das cúspides, tal como previsto no plano frontal expresso em ambos os arcos; a curvatura no arco mandibular sendo côncava e o no arco maxilar sendo convexa.',
    'Fenômeno de Christensen': 'O espaço que ocorre entre as superfícies oclusais dos dentes posteriores antagonistas durante a protrusão mandibular.',
    'Guia anterior': 'Relação dos dentes anteriores que evita o contato dos dentes posteriores em todos os movimentos mandibulares excêntricos.',
    'Guia Canina': 'Uma forma de proteção articular mútua, na qual o overlap horizontal e vertical dos caninos desocluem os dentes posteriores nos movimentos excursivos da mandíbula.',
    'Interferência Oclusal': 'qualquer contato dentário que impeça as demais superfícies oclusais de realizarem contatos oclusais estáveis e harmônicos.',
    'Trauma Oclusal': 'Trauma nos tecidos periodontais a partir de forças funcionais ou parafuncionais, causando prejuízos que excedem as capacidades adaptativas e reparadoras, pode ser autolimitado ou progressivo.',
    'Dimensão Vertical de Oclusão (DVO)': 'Distância entre dois pontos anatômicos ou selecionados/marcados (geralmente um na ponta do nariz e outro no queixo) na posição de máxima intercuspidação habitual (MIH).',
    'Dimensão Vertical de Repouso (DVR) / Relação de Repouso Mandibular': 'quando o paciente está em posição de repouso confortável, com os côndilos em posição neutra, não forçada, e os músculos encontram-se em estado de mínima atividade de contração.',
    'Plano Oclusal': 'Plano estabelecido pelas superfícies incisais e oclusais dos dentes.',
    'Posição Oclusal': 'Relação entre a maxila e mandíbula quando a mandíbula está fechada e os destes estão na posição de máxima intercuspidação, esta posição pode ou não ser coincidente com a oclusão cêntrica.',
    'Oclusão cêntrica': 'Posição de contatos dentários na qual a mandíbula está em relação cêntrica, pode ou não coincidir com a máxima intercuspidação habitual.',
  };

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSearch(
            context: context,
            delegate: CustomSearchDelegate()
          );
        },
      ),
    ];
  }

  @override 
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.popUntil(context, (route) => route.settings.name == '/principal');

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
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.17,
            decoration: const BoxDecoration( 
              color: Color.fromARGB(255, 14, 82, 199),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Center(
              child: Text(
                query,
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
          const Divider(),
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
    return ListView.separated(
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
      separatorBuilder: (context, index) {
        return const Divider();
      },
    );
  }
}