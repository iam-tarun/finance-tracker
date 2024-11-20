class BarData {
  final double numBars;
  final List<double> barAmounts;
  final double minY;
  final double maxY;
  final double barWidth;
  final List<String> xAxisLabels;

  BarData({
    required this.numBars,
    required this.barAmounts,
    required this.minY,
    required this.maxY,
    required this.xAxisLabels,
    this.barWidth = 20
  });
}