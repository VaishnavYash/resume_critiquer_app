import 'package:flutter/material.dart';
import 'package:resume_critiquer_app/framework/digital/sizer.dart';
import 'package:resume_critiquer_app/framework/widgets/text_widget.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ChartData {
  final String category;
  final int value;
  final Color color;

  ChartData(this.category, this.value, this.color);
}

class AtsScoreWidget extends StatelessWidget {
  const AtsScoreWidget({required this.atsScore, super.key});

  final double atsScore;

  @override
  Widget build(BuildContext context) {
    var colorCode = Colors.red;
    if (atsScore >= 80) {
      colorCode = Colors.green;
    } else if (atsScore >= 60) {
      colorCode = Colors.amber;
    }

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
              value: atsScore,
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

          canScaleToFit: true,
          annotations: [
            GaugeAnnotation(
              widget: TextWidget(
                text: atsScore.toStringAsFixed(1),
                style: TextStyle().copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 28.0.sp,
                  color: colorCode,
                ),
              ),
            ),
            GaugeAnnotation(
              angle: 180,
              positionFactor: 1,
              widget: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 18),
                  TextWidget(
                    text: '0',
                    style: TextStyle().copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0.sp,
                      color: Colors.white,
                    ),
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
                  SizedBox(height: 18),
                  TextWidget(
                    text: '100',
                    style: TextStyle().copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0.sp,
                      color: Colors.white,
                    ),
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
      enableLoadingAnimation: true,
      animationDuration: 1500,
    );
  }
}
