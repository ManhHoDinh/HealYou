import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:healyou/healyou/core/constants/color_palatte.dart';
import 'package:healyou/healyou/core/models/firebase/target_request.dart';

class LineChartWidget extends StatefulWidget {
  final double target;
  const LineChartWidget({super.key, required this.target});

  @override
  State<LineChartWidget> createState() => _LineChartWidgetState();
}

class _LineChartWidgetState extends State<LineChartWidget> {
  List<Color> gradientColors = [ColorPalette.mainRunColor, Colors.white];
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
            child: StreamBuilder<List<Map<String, dynamic>>>(
                stream: TargetRequest.getWeekTargets(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    print(snapshot.data);
                    return LineChart(
                      mainData(snapshot.data!),
                    );
                  }
                  return Container();
                }),
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
      fontSize: 14,
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
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  LineChartData mainData(List<Map<String, dynamic>> data) {
    double maxValue = 0;
    for (var element in data) {
      if (element["reached"].toDouble() >= maxValue) {
        maxValue = element["reached"].toDouble();
      }
    }
    if (maxValue <= widget.target) {
      maxValue = widget.target;
    }
    return LineChartData(
      extraLinesData: ExtraLinesData(
        horizontalLines: [
          HorizontalLine(
            y: widget.target,
            color: Color(0xffcccccc), // Color of the horizontal line
            strokeWidth: 1, // Width of the horizontal line
            dashArray: [5, 5], // Optional: dash pattern for the line
          ),
        ],
      ),
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
            color: Color(0xffcccccc),
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
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border(
              left: BorderSide(width: 1, color: Color(0xffcccccc)),
              right: BorderSide(width: 1, color: Color(0xffcccccc)))),
      minX: 0,
      maxX: 6,
      minY: 0,
      maxY: maxValue,
      lineBarsData: [
        LineChartBarData(
          spots: data
              .map((item) =>
                  FlSpot(item["index"].toDouble(), item["reached"].toDouble()))
              .toList(),
          isCurved: true,
          color: ColorPalette.mainRunColor,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: gradientColors
                  .map((color) => color.withOpacity(0.5))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
