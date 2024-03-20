import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';

import '../../../../core/constants/color_palatte.dart';

class WeekTarget extends StatefulWidget {
  const WeekTarget({super.key});

  @override
  State<WeekTarget> createState() => _WeekTargetState();
}

class _WeekTargetState extends State<WeekTarget> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = 200;
    DateTime now = DateTime.now();
    double kcal = 400;
    double distance = 9.5;
    double time = 120;
    int dayOfWeek = now.weekday;
    List<String> days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    List<List<double>> targets = [
      [1000, 2000],
      [3000, 2000],
      [1000, 2000],
      [1000, 1500],
      [1000, 2000],
      [1000, 2000],
      [1000, 2000]
    ];
    double maxTarget = getMaxTarget(targets);
    List<Stack> listProgress = targets
        .map((e) => Stack(children: [
              Positioned(
                child: SizedBox(
                  width: width * 1 / 13,
                  height: e[0] > e[1]
                      ? e[0] * height / maxTarget
                      : e[1] * height / maxTarget,
                  child: FAProgressBar(
                    currentValue: e[0],
                    maxValue: e[1],
                    borderRadius: BorderRadius.circular(20),
                    backgroundColor: Color(0xffe7e7e7),
                    progressColor: ColorPalette.mainRunColor,
                    direction: Axis.vertical,
                    verticalDirection: VerticalDirection.up,
                    size: 30,
                    displayText: "",
                    displayTextStyle: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              e[0] > e[1]
                  ? Positioned(
                      bottom: e[1] * height / maxTarget,
                      child: DottedLine(
                          direction: Axis.horizontal,
                          dashLength: 3,
                          dashColor: Colors.white,
                          lineLength: width * 1 / 13,
                          lineThickness: 2),
                    )
                  : Container()
            ]))
        .toList();

    List<Container> dayTexts = days
        .map((day) => Container(
              width: width * 1 / 13,
              child: Text(day,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 12,
                      color: _getDayOfWeekString(dayOfWeek) == day
                          ? Colors.black
                          : Color(0xff87858E))),
            ))
        .toList();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  '9034',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 32),
                ),
                Text('This week')
              ],
            ),
            TextButton(
                onPressed: () {},
                child: Row(
                  children: [Text('3200'), Icon(Icons.north_east)],
                ))
          ],
        ),
        Container(
          color: Color(0xffE6E6E8),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: dayTexts,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 40),
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: listProgress),
        ),
        SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Icon(Icons.local_fire_department,
                    color: ColorPalette.mainRunColor),
                Text(
                  '${kcal.toStringAsFixed(0)} kcal',
                  style: TextStyle(fontSize: 16),
                )
              ],
            ),
            Column(
              children: [
                Icon(Icons.arrow_forward, color: ColorPalette.mainRunColor),
                Text(
                  '${distance} km',
                  style: TextStyle(fontSize: 16),
                )
              ],
            ),
            Column(
              children: [
                Icon(Icons.schedule, color: ColorPalette.mainRunColor),
                Text(
                  '${time}',
                  style: TextStyle(fontSize: 16),
                )
              ],
            ),
          ],
        )
      ],
    );
  }

  double getMaxTarget(List<List<double>> list) {
    double max = 0;
    for (int i = 0; i < list.length; i++) {
      for (int j = 0; j < 2; j++) {
        if (list[i][j] > max) {
          max = list[i][j];
        }
      }
    }
    print(max);
    return max;
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
}
