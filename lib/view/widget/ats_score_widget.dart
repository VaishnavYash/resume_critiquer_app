import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart' as charts;

class ChartData {
  final String category;
  final int value;
  final Color color;

  ChartData(this.category, this.value, this.color);
}

class AtsScoreWidget extends StatelessWidget {
  const AtsScoreWidget({required this.atsScore, super.key});

  final int atsScore;

  @override
  Widget build(BuildContext context) {
    return charts.SfCircularChart(
      annotations: [
        charts.CircularChartAnnotation(
          widget: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                atsScore.toString(),
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Text(
                '/100',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],

      series: <charts.CircularSeries>[
        charts.RadialBarSeries<ChartData, String>(
          dataSource: <ChartData>[
            ChartData('Strengths', atsScore, Colors.green),
          ],
          xValueMapper: (ChartData data, _) => data.category,
          yValueMapper: (ChartData data, _) => data.value,
          pointColorMapper: (ChartData data, _) => data.color,
          innerRadius: "85%",
          maximumValue: 100,
          enableTooltip: false,
          cornerStyle: charts.CornerStyle.bothCurve,
          dataLabelSettings: charts.DataLabelSettings(isVisible: false),
        ),
      ],
    );
  }
}
