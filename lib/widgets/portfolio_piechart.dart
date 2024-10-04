import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PortfolioPiechart extends StatefulWidget {
  const PortfolioPiechart({super.key});

  @override
  State<PortfolioPiechart> createState() => _PortfolioPiechartState();
}

class _PortfolioPiechartState extends State<PortfolioPiechart> {
  @override
  Widget build(BuildContext context) {
    return PieChart(PieChartData(sections: [
      PieChartSectionData(
        value: 20,
        color: Colors.yellow,
      ),
      PieChartSectionData(
        value: 30,
        color: Colors.red,
      ),
      PieChartSectionData(
        value: 40,
        color: Colors.green,
      ),
      PieChartSectionData(
        value: 10,
        color: Colors.blue,
      )
    ]));
  }
}
