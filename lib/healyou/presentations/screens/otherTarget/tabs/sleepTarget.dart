import 'package:flutter/material.dart';
import 'package:analog_clock/analog_clock.dart';
import 'package:healyou/healyou/presentations/widgets/timeArc.dart';

var sleepList = [
  {
    "startTime": DateTime(2024, 4, 1, 8, 30),
    "endTime": DateTime(2024, 4, 1, 5, 30),
    'color': Color(0xff00D0C3),
  },
  {
    "startTime": DateTime(2024, 4, 1, 1, 30),
    "endTime": DateTime(2024, 4, 1, 3, 30),
  }
];

class SleepTarget extends StatefulWidget {
  const SleepTarget({Key? key}) : super(key: key);
  @override
  _SleepTargetState createState() => _SleepTargetState();
}

class _SleepTargetState extends State<SleepTarget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  ...sleepList
                      .asMap()
                      .map(
                        (key, value) => MapEntry(
                            key,
                            TimeArc(
                                width: 200,
                                height: 200,
                                padding: 10 + key * 20.0,
                                startTime: value["startTime"] as DateTime,
                                endTime: value['endTime'] as DateTime,
                                color: value['color'] == null
                                    ? null
                                    : value['color'] as Color)),
                      )
                      .values
                      .toList(),
                  AnalogClock(
                    decoration: BoxDecoration(
                        color: Colors.transparent, shape: BoxShape.circle),
                    width: 200.0,
                    height: 200.0,
                    isLive: true,
                    hourHandColor: Colors.black,
                    minuteHandColor: Colors.black,
                    showSecondHand: false,
                    numberColor: Colors.black87,
                    showNumbers: true,
                    showAllNumbers: false,
                    textScaleFactor: 1.4,
                    showTicks: true,
                    showDigitalClock: false,
                    datetime: DateTime.now(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
