import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:healyou/healyou/core/models/firebase/target_request.dart';
import 'package:healyou/healyou/core/models/target/target.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/color_palatte.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late DateTime selectedDate = DateTime.now();
  late List<DateTime> range;
  @override
  void initState() {
    initRange();

    super.initState();
  }

  void initRange() async {
    List<DateTime> rangeData = await TargetRequest.getRangeWaterStatistic();
    setState(() {
      range = rangeData;
      print(range);
      selectedDate = range.last;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'History',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
        ),
        body: Column(
          children: [
            Center(
              child: FutureBuilder<List<DateTime>>(
                  future: TargetRequest.getRangeWaterStatistic(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      print(snapshot.data);
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                              width: 24,
                              height: 24,
                              child: IconButton(
                                  onPressed: checkTime(
                                          DateTime(
                                              selectedDate.year,
                                              selectedDate.month - 1,
                                              selectedDate.day),
                                          range.first)
                                      ? () {
                                          setState(() {
                                            selectedDate = DateTime(
                                                selectedDate.year,
                                                selectedDate.month - 1,
                                                selectedDate.day);
                                          });
                                        }
                                      : () {},
                                  icon: Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                  style: IconButton.styleFrom(
                                    backgroundColor:
                                        checkTime(selectedDate, range.first)
                                            ? Colors.grey
                                            : ColorPalette.primaryColor,
                                    padding: EdgeInsets.all(0),
                                  ))),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            DateFormat("MMM yyyy").format(selectedDate),
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                              width: 24,
                              height: 24,
                              child: IconButton(
                                  disabledColor: Colors.red,
                                  onPressed: checkTime(
                                          DateTime(
                                              selectedDate.year,
                                              selectedDate.month + 1,
                                              selectedDate.day),
                                          range.last)
                                      ? () {
                                          setState(() {
                                            selectedDate = DateTime(
                                                selectedDate.year,
                                                selectedDate.month + 1,
                                                selectedDate.day);
                                          });
                                        }
                                      : () {},
                                  icon: Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                  style: IconButton.styleFrom(
                                    backgroundColor:
                                        checkTime(selectedDate, range.last)
                                            ? Colors.grey
                                            : ColorPalette.primaryColor,
                                    padding: EdgeInsets.all(0),
                                  )))
                        ],
                      );
                    }
                    return Text(snapshot.error.toString());
                  }),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 360,
              padding: EdgeInsets.only(left: 20, top: 20, right: 10),
              child: StreamBuilder<List<double>>(
                  stream: TargetRequest.waterStatistic(
                      TargetType.water, selectedDate),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      print(snapshot.data);
                      return BarChart(
                        BarChartData(
                            borderData: FlBorderData(
                                show: true,
                                border: Border(
                                    left: BorderSide(
                                        width: 1, color: Colors.black),
                                    bottom: BorderSide(
                                        width: 1, color: Colors.black))),
                            gridData: FlGridData(
                              show: true,
                              checkToShowHorizontalLine: (value) =>
                                  value % 20 == 0, // Customize as needed
                              getDrawingHorizontalLine: (value) => FlLine(
                                color: Colors.grey.withOpacity(0.3),
                                dashArray: [10, 5],
                                strokeWidth: 1,
                              ),
                              getDrawingVerticalLine: (value) => FlLine(
                                color: Colors.grey,
                                strokeWidth: 1,
                              ),
                            ),
                            barTouchData: barTouchData,
                            titlesData: titlesData,
                            barGroups: barGroups(snapshot.data!),
                            alignment: BarChartAlignment.spaceAround,
                            minY: 0,
                            maxY: 100),
                      );
                    } else {
                      return Text("error");
                    }
                  }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Drinking water report',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Weekly average',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        '0 ml / day',
                        style: TextStyle(
                            fontSize: 16, color: ColorPalette.primaryColor),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Monthly average',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        '0 ml / day',
                        style: TextStyle(
                            fontSize: 16, color: ColorPalette.primaryColor),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Monthly average',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        '0 ml / day',
                        style: TextStyle(
                            fontSize: 16, color: ColorPalette.primaryColor),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Average completion',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        '${TargetRequest.averageCompletion.toStringAsFixed(1)} %',
                        style: TextStyle(
                            fontSize: 16, color: ColorPalette.primaryColor),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ));
  }
}

BarTouchData get barTouchData => BarTouchData(
      enabled: false,
      touchTooltipData: BarTouchTooltipData(
        getTooltipColor: (group) => Colors.transparent,
        tooltipPadding: EdgeInsets.zero,
        tooltipMargin: 8,
        getTooltipItem: (
          BarChartGroupData group,
          int groupIndex,
          BarChartRodData rod,
          int rodIndex,
        ) {
          return BarTooltipItem(
            rod.toY.round().toString(),
            const TextStyle(
              color: Colors.transparent,
            ),
          );
        },
      ),
    );

Widget getTitles(double value, TitleMeta meta) {
  final style = TextStyle(
    color: ColorPalette.primaryColor,
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );
  String text;
  switch (value.toInt()) {
    case 0:
      text = '0';
      break;
    case 7:
      text = '7';
      break;
    case 14:
      text = '14';
      break;
    case 21:
      text = '21';
      break;
    case 28:
      text = '28';
      break;

    default:
      text = '';
      break;
  }
  return SideTitleWidget(
    axisSide: meta.axisSide,
    space: 4,
    child: Text(text, style: style),
  );
}

Widget leftTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 15,
  );
  String text;
  switch (value.toInt()) {
    case 0:
      text = '0';
      break;
    case 20:
      text = '20';
      break;
    case 40:
      text = '40';
      break;
    case 60:
      text = '60';
      break;
    case 80:
      text = '80';
      break;
    case 100:
      text = '%\n100';
      break;
    default:
      return Container();
  }
  return Text(text, style: style, textAlign: TextAlign.left);
}

FlTitlesData get titlesData => FlTitlesData(
      show: true,
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 30,
          getTitlesWidget: getTitles,
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 30,
          getTitlesWidget: leftTitleWidgets,
        ),
      ),
      topTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      rightTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
    );

LinearGradient get _barsGradient => LinearGradient(
      colors: const [ColorPalette.primaryColor, ColorPalette.primaryColor],
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
    );

List<BarChartGroupData> barGroups(List<double> data) {
  int count = -1;
  return data.map((e) {
    count++;
    return BarChartGroupData(
      x: count,
      barRods: [
        BarChartRodData(
            toY: e,
            gradient: _barsGradient,
            borderRadius: BorderRadius.circular(0))
      ],
      showingTooltipIndicators: [0],
    );
  }).toList();
}

bool checkTime(DateTime selectedTime, DateTime targetTime) {
  return selectedTime.month == targetTime.month &&
      selectedTime.year == targetTime.year;
}
