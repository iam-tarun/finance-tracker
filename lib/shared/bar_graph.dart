import 'package:finance_tracker/models/bar_data_model.dart';
import 'package:finance_tracker/shared/custom_text.dart';
import 'package:finance_tracker/theme.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarGraph extends StatelessWidget {
  const BarGraph(this.data, {super.key});

  final BarData data;


  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        gridData: const FlGridData(
          drawHorizontalLine: false,
          drawVerticalLine: false
        ),
        minY: data.minY,
        maxY: data.maxY,
        backgroundColor: AppColors.backgroundColor,
        titlesData: FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (double value, TitleMeta meta) {
              int index = value.toInt();
              if (index < 0 || index >= data.xAxisLabels.length) {
                return const SizedBox.shrink();
              }
              return TextSmall(data.xAxisLabels[index]);
            }
          )
          )
        ),
        barGroups: data.barAmounts.asMap().entries.map((entry) => 
            BarChartGroupData(
              x: entry.key,
              barRods: [
                BarChartRodData(
                  toY: entry.value,
                  width: 16,
                  borderRadius:const BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                  color: AppColors.primaryTextColor
                )
              ],
            )
          ).toList(),
      ),
    );
  }
}