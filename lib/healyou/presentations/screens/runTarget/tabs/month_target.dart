import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healyou/healyou/presentations/screens/runTarget/widgets/progress_widget.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../core/constants/color_palatte.dart';

class MonthTarget extends StatefulWidget {
  const MonthTarget({super.key});

  @override
  State<MonthTarget> createState() => _MonthTargetState();
}

class _MonthTargetState extends State<MonthTarget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> listTargets = [
      {"createdAt": DateTime.utc(2024, 3, 18), "target": 3000, "reached": 2000}
    ];
    Map<String, dynamic> selectedTarget = listTargets[0];
    double kcal = 100;
    double distance = 2.3;
    double time = 100;
    DateTime selectedDate = DateTime.now();
    return Column(
      children: [
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    selectedTarget["reached"].toString(),
                    style: TextStyle(
                        height: 1, fontWeight: FontWeight.w600, fontSize: 32),
                  ),
                  Text('This week')
                ],
              ),
              GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(width: 1, color: Color(0xffe7e7e9))),
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('2333'),
                        Container(
                          margin: EdgeInsets.only(left: 8),
                          padding: EdgeInsets.all(4),
                          child: Center(
                            child: Icon(
                              Icons.north_east,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Color(0xff00d800)),
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TableCalendar(
          calendarBuilders: CalendarBuilders(
            defaultBuilder: (context, date, _) {
              for (int i = 0; i < listTargets.length; i++) {
                Map<String, dynamic> item = listTargets[i];
                if (item["createdAt"] == date) {
                  return ProgressWidget(
                      value: 0.3, child: Text(date.day.toString()));
                }
              }
            },
            todayBuilder: (context, date, _) {
              for (int i = 0; i < listTargets.length; i++) {
                Map<String, dynamic> item = listTargets[i];
                if (item["createdAt"] == date) {
                  return ProgressWidget(
                      value: 0.3, child: Text(date.day.toString()));
                }
              }
            },
          ),
          onDaySelected: ((selectedDay, focusedDay) {
            setState(() {
              selectedDate = selectedDay;
            });
          }),
          focusedDay: DateTime.now(),
          firstDay: DateTime.utc(2010, 10, 16),
          lastDay: DateTime.utc(2030, 3, 14),
          headerVisible: false,
          daysOfWeekStyle: DaysOfWeekStyle(
              decoration: BoxDecoration(
            color: Color(0xffE6E6E8),
          )),
          daysOfWeekHeight: 30,
          calendarStyle: CalendarStyle(
              selectedTextStyle: TextStyle(color: Colors.red),
              tablePadding: EdgeInsets.symmetric(horizontal: 16),
              weekendDecoration: BoxDecoration(
                  color: Color(0xffe7e7e9), shape: BoxShape.circle),
              defaultDecoration: BoxDecoration(
                  color: Color(0xffe7e7e9), shape: BoxShape.circle)),
        ),
        SizedBox(
          height: 20,
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
}
