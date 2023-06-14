import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../controller/relatorio_controller.dart';

class RelatorioExercicioView extends StatefulWidget {
  const RelatorioExercicioView({Key? key}) : super(key: key);

  @override
  State<RelatorioExercicioView> createState() => _RelatorioExercicioViewState();
}

class _RelatorioExercicioViewState extends State<RelatorioExercicioView> {

  late RelatorioController _relatorioController;

  @override
  void initState() {
    super.initState();
    
    _relatorioController = RelatorioController();

  }

  @override
  Widget build(BuildContext context) {
    final exercicio = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String exercicioUid = exercicio['uid'];

    return FutureBuilder<Map<String, int>>(
      future: _relatorioController.getRelatorioExercicio(context, exercicioUid),
      builder: (BuildContext context, AsyncSnapshot<Map<String, int>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Exibir um indicador de carregamento enquanto os dados estão sendo buscados
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // Lidar com erros caso ocorram durante a busca dos dados
          return const Center(child: Text('Ocorreu um erro ao receber dados de exercícios'));
        } else {
          // Acesso aos dados obtidos a partir do snapshot
          final relatorio = snapshot.data!;
          final int numAcertos = relatorio['acertos'] ?? 0;
          final int numTotal = relatorio['total'] ?? 0;

          return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xFF0E52C7),
              title: const Text('Relatório de Exercício'),
            ),
            body: Container(
              padding: const EdgeInsets.only(
                top: 10,
                left: 10,
                right: 10,
              ),
              child: Center(
                child: PieChart(
                  PieChartData(
                    sections: [
                      PieChartSectionData(
                        value: numAcertos.toDouble(),
                        color: Colors.green,
                        title: numAcertos.toString(),
                        radius: 80,
                        titleStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      PieChartSectionData(
                        value: numTotal.toDouble() - numAcertos.toDouble(),
                        color: Colors.red,
                        title: (numTotal - numAcertos).toString(),
                        radius: 80,
                        titleStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );

        }
      },
    );
  }

}