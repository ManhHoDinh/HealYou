import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healyou/healyou/presentations/screens/runTarget/widgets/progress_widget.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class MonthTarget extends StatefulWidget {
  const MonthTarget({super.key});

  @override
  State<MonthTarget> createState() => _MonthTargetState();
}

class _MonthTargetState extends State<MonthTarget> {
  List<Map<String, dynamic>> listTime = [
    {"createdAt": DateTime.utc(2024, 3, 20), "target": 3000, "reached": 2000}
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        TableCalendar(
          calendarBuilders: CalendarBuilders(
            defaultBuilder: (context, date, _) {
              for (int i = 0; i < listTime.length; i++) {
                Map<String, dynamic> item = listTime[i];
                if (item["createdAt"] == date) {
                  return ProgressWidget(
                      value: 0.3, child: Text(date.day.toString()));
                }
              }
            },
            todayBuilder: (context, date, _) {
              for (int i = 0; i < listTime.length; i++) {
                Map<String, dynamic> item = listTime[i];
                if (item["createdAt"] == date) {
                  return ProgressWidget(
                      value: 0.3, child: Text(date.day.toString()));
                }
              }
            },
          ),
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
              tablePadding: EdgeInsets.symmetric(horizontal: 16),
              weekendDecoration: BoxDecoration(
                  color: Color(0xffe7e7e9), shape: BoxShape.circle),
              defaultDecoration: BoxDecoration(
                  color: Color(0xffe7e7e9), shape: BoxShape.circle)),
        )
      ],
    );
  }
}
