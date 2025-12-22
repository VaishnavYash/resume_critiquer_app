import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ChartData {
  final String category;
  final int value;
  final Color color;

  ChartData(this.category, this.value, this.color);
}

class AtsScoreWidget extends StatelessWidget {
  const AtsScoreWidget({this.atsScore, super.key});

  final double? atsScore;

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      axes: [
        RadialAxis(
          showTicks: false,
          showLabels: false,
          axisLabelStyle: GaugeTextStyle(fontSize: 100, color: Colors.white),
          endAngle: 0,
          startAngle: 180,
          pointers: [
            MarkerPointer(
              value: atsScore ?? 0,
              markerType: MarkerType.invertedTriangle,
              color: const Color.fromARGB(255, 215, 86, 35),
              markerHeight: 20,
              markerWidth: 15,
              elevation: 10,
              borderColor: Colors.white,
              animationDuration: 3000,
              enableAnimation: true,
              markerOffset: -35,
              animationType: AnimationType.ease,
            ),
          ],

          onLabelCreated: (value) {
            value.text = '200%';
            value.labelStyle = GaugeTextStyle(
              fontSize: 12,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            );
          },
          canScaleToFit: true,
          annotations: [
            GaugeAnnotation(
              widget: Text(
                atsScore == null ? '0' : atsScore!.toStringAsFixed(1),
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ),
            GaugeAnnotation(
              angle: 180,
              positionFactor: 1,
              widget: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 24),
                  Text(
                    '0',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            GaugeAnnotation(
              angle: 0,
              positionFactor: 1,
              widget: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 24),
                  Text(
                    '100',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
          showFirstLabel: true,
          labelsPosition: ElementsPosition.outside,
          showLastLabel: true,
          showAxisLine: true,
          axisLineStyle: AxisLineStyle(
            thickness: 70,
            gradient: SweepGradient(
              colors: [
                const Color.fromARGB(255, 191, 45, 249),
                const Color.fromARGB(255, 71, 215, 231),
              ],
              stops: [0.0, 1.0],
            ),
            thicknessUnit: GaugeSizeUnit.logicalPixel,
          ),
        ),
      ],
      title: GaugeTitle(
        text: 'ATS Score',
        textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),

      enableLoadingAnimation: true,
      animationDuration: 1500,
    );
  }
}
