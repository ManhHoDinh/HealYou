import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healyou/healyou/core/helper/firebase_helper.dart';
import 'package:healyou/healyou/core/models/firebase/target_request.dart';
import 'package:healyou/healyou/core/models/target/target.dart';
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
  DateTime selectedDate = DateTime.now();
  Target selectedTarget = Target(reached: 0);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    return StreamBuilder<List<Target>>(
        stream: TargetRequest.getAll(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Target> listTargets = snapshot.data!
                .where((element) => element.type == TargetType.step)
                .toList();
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
                            selectedTarget.reached.toStringAsFixed(0),
                            style: TextStyle(
                                height: 1,
                                fontWeight: FontWeight.w600,
                                fontSize: 32),
                          ),
                          Text(DateFormat("dd/MM/yyyy").format(selectedDate))
                        ],
                      ),
                      GestureDetector(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    width: 1, color: Color(0xffe7e7e9))),
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('2333'),
                                Container(
                                  margin: EdgeInsets.only(left: 8),
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xff00d800)),
                                  child: Center(
                                    child: Icon(
                                      Icons.north_east,
                                      size: 16,
                                      color: Colors.white,
                                    ),
                                  ),
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
                        Target item = listTargets[i];

                        if (item.time!.day == date.day &&
                            item.time!.month == date.month &&
                            item.time!.year == date.year) {
                          return ProgressWidget(
                              value: item.reached / item.target,
                              child: Text(date.day.toString()));
                        }
                      }
                      return null;
                    },
                    todayBuilder: (context, date, _) {
                      for (int i = 0; i < listTargets.length; i++) {
                        Target item = listTargets[i];
                        if (item.time == date) {
                          return ProgressWidget(
                              value: 0.3, child: Text(date.day.toString()));
                        }
                      }
                      return null;
                    },
                  ),
                  onDaySelected: ((selectedDay, focusedDay) {
                    setState(() {
                      selectedDate = selectedDay;
                      Target target = listTargets.firstWhere((element) =>
                          element.time!.day == selectedDate.day &&
                          element.time!.month == selectedDate.month &&
                          element.time!.year == selectedDate.year);
                      selectedTarget = target;
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
                        StreamBuilder<Target?>(
                            stream: TargetRequest.getTarget(
                                TargetType.kcal, selectedDate, userId),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Text(
                                  '${snapshot.data!.reached.toStringAsFixed(0)} kcal',
                                  style: TextStyle(fontSize: 16),
                                );
                              }
                              return Container();
                            })
                      ],
                    ),
                    Column(
                      children: [
                        Icon(Icons.arrow_forward,
                            color: ColorPalette.mainRunColor),
                        StreamBuilder<Target?>(
                            stream: TargetRequest.getTarget(
                                TargetType.distance, selectedDate, userId),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                print(snapshot.data);
                                return Text(
                                  '${snapshot.data!.reached.toStringAsFixed(1)} km',
                                  style: TextStyle(fontSize: 16),
                                );
                              }
                              return Container();
                            })
                      ],
                    ),
                    Column(
                      children: [
                        Icon(Icons.schedule, color: ColorPalette.mainRunColor),
                        StreamBuilder<Target?>(
                            stream: TargetRequest.getTarget(
                                TargetType.time, selectedDate, userId),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Text(
                                  (snapshot.data!.reached * 60).toStringAsFixed(0),
                                  style: TextStyle(fontSize: 16),
                                );
                              }
                              return Container();
                            })
                      ],
                    ),
                  ],
                )
              ],
            );
          }
          return Container();
        });
  }
}
