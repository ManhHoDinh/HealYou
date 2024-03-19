import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:healyou/healyou/core/constants/color_palatte.dart';

class LineChartWidget extends StatefulWidget {
  const LineChartWidget({super.key});

  @override
  State<LineChartWidget> createState() => _LineChartWidgetState();
}

class _LineChartWidgetState extends State<LineChartWidget> {
  List<Color> gradientColors = [
    ColorPalette.primaryColor,
    ColorPalette.mainRunColor
  ];
  bool showAvg = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.70,
          child: Padding(
            padding: const EdgeInsets.only(
              right: 18,
              left: 12,
              top: 24,
              bottom: 12,
            ),
            child: LineChart(
              mainData(),
            ),
          ),
        ),
        SizedBox(
          width: 60,
          height: 34,
          child: TextButton(
            onPressed: () {
              setState(() {
                showAvg = !showAvg;
              });
            },
            child: Text(
              'avg',
              style: TextStyle(
                fontSize: 12,
                color: showAvg ? Colors.white.withOpacity(0.5) : Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget topTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    DateTime now = DateTime.now();
    int dayOfWeek = now.weekday;
    Widget text;

    switch (value.toInt()) {
      case 0:
        if (dayOfWeek - 6 <= 0) {
          dayOfWeek += 7;
        }
        text = Text(_getDayOfWeekString(dayOfWeek - 6), style: style);
        break;
      case 1:
        if (dayOfWeek - 5 <= 0) {
          dayOfWeek += 7;
        }
        text = Text(_getDayOfWeekString(dayOfWeek - 5), style: style);
        break;
      case 2:
        if (dayOfWeek - 4 <= 0) {
          dayOfWeek += 7;
        }
        text = Text(_getDayOfWeekString(dayOfWeek - 4), style: style);

        break;
      case 3:
        if (dayOfWeek - 3 <= 0) {
          dayOfWeek += 7;
        }
        text = Text(_getDayOfWeekString(dayOfWeek - 3), style: style);
        break;
      case 4:
        if (dayOfWeek - 2 <= 0) {
          dayOfWeek += 7;
        }
        text = Text(_getDayOfWeekString(dayOfWeek - 2), style: style);
        break;
      case 5:
        if (dayOfWeek - 1 <= 0) {
          dayOfWeek += 7;
        }
        text = Text(_getDayOfWeekString(dayOfWeek - 1), style: style);
        break;
      case 6:
        text = Text(_getDayOfWeekString(dayOfWeek), style: style);
        break;

      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  String _getDayOfWeekString(int dayOfWeek) {
    switch (dayOfWeek) {
      case 1:
        return 'Sun';
      case 2:
        return 'Mon';
      case 3:
        return 'Tue';
      case 4:
        return 'Wed';
      case 5:
        return 'Thu';
      case 6:
        return 'Fri';
      case 7:
        return 'Sat';
      default:
        return '';
    }
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '10K';
        break;
      case 3:
        text = '30k';
        break;
      case 5:
        text = '50k';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: ColorPalette.backgroundColor,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: ColorPalette.greenText,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: topTitleWidgets,
          ),
        ),
        bottomTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 6,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3),
            FlSpot(1, 2),
            FlSpot(2, 5),
            FlSpot(3, 5),
            FlSpot(4, 2),
            FlSpot(5, 7),
            FlSpot(6, 3),
            // FlSpot(6.8, 3.1),
            // FlSpot(8, 4),
            // FlSpot(9.5, 3),
            // FlSpot(11, 4),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
