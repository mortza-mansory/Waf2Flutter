import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';

class CircleChart extends StatelessWidget {
  final Color circleColor;
  final String mainText;
  final String subText;

  const CircleChart({
    Key? key,
    required this.circleColor,
    required this.mainText,
    required this.subText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          PieChart(
            PieChartData(
              sectionsSpace: 0,
              startDegreeOffset: -90,
              centerSpaceRadius: 70,
              sections: [
                PieChartSectionData(
                  value: 1,
                  color: circleColor,
                  showTitle: false,
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  mainText.tr,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(subText.tr),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
