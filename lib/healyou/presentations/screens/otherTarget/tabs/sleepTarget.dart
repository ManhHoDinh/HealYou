import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:analog_clock/analog_clock.dart';
import 'package:flutter/widgets.dart';
import 'package:healyou/healyou/core/constants/color_palatte.dart';
import 'package:healyou/healyou/core/helper/text_styles.dart';
import 'package:healyou/healyou/core/models/firebase/sleep_request.dart';
import 'package:healyou/healyou/core/models/sleep/sleep.dart';
import 'package:healyou/healyou/presentations/widgets/timeArc.dart';
import 'package:intl/intl.dart';

class SleepTarget extends StatefulWidget {
  const SleepTarget({Key? key}) : super(key: key);
  @override
  _SleepTargetState createState() => _SleepTargetState();
}

class _SleepTargetState extends State<SleepTarget> {
  var seeMoreSelected = false;
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now();
  Color color = Colors.greenAccent;
  late Stream<List<Sleep>> sleepListStream;
  @override
  void initState() {
    super.initState();
    sleepListStream = SleepRequest.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Sleep>>(
        stream: sleepListStream,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            var sleepList = snapshot.data;
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          ...sleepList!
                              .asMap()
                              .map(
                                (key, value) => MapEntry(
                                    key,
                                    TimeArc(
                                        width: 200,
                                        height: 200,
                                        padding: 10 + key * 20.0,
                                        startTime: value.startTime,
                                        endTime: value.endTime,
                                        color: value.color)),
                              )
                              .values
                              .toList(),
                          AnalogClock(
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                shape: BoxShape.circle),
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
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Row(
                              children: [
                                Text("Your sleep schedule",
                                    style: TextStyles.labelStaffDetail),
                                IconButton(
                                    onPressed: () {
                                      _showAddSleepModel();
                                    },
                                    icon: Icon(
                                      Icons.add_circle,
                                      color: ColorPalette.primaryColor,
                                    ))
                              ],
                            ),
                          ],
                        ),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                seeMoreSelected = !seeMoreSelected;
                              });
                            },
                            child: Text(
                              "see more",
                              style:
                                  TextStyle(fontSize: 13, color: Colors.grey),
                            ))
                      ],
                    ),
                    AnimatedContainer(
                      height: seeMoreSelected ? null : 80,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(),
                      duration: Duration(seconds: 2),
                      child: sleepList.isEmpty
                          ? TextButton(
                              onPressed: () {
                                _showAddSleepModel();
                              },
                              child: Text(
                                  "Add sleep to start schedule your sleep"))
                          : Column(
                              children: [
                                ...sleepList
                                    .map((e) => buildNextSleepItem(e))
                                    .toList()
                              ],
                            ),
                    )
                  ],
                ),
              ),
            );
          } else if (snapshot.error != null) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else
            // ignore: curly_braces_in_flow_control_structures
            return Center(
              child: CircularProgressIndicator(),
            );
        });
  }

  Widget buildNextSleepItem(Sleep sleep) {
    return Container(
        width: double.infinity,
        height: 80,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
                image: AssetImage(
                    DateFormat('hh:mm a').format(sleep.startTime).contains("AM")
                        ? "assets/healyou/sleep_background.png"
                        : "assets/healyou/sleep_background_night.png"),
                fit: BoxFit.cover)),
        child: Stack(
          children: [
            Positioned(
              bottom: 8,
              left: 8,
              child: Text(
                "${DateFormat.Hm().format(sleep.startTime)} - ${DateFormat.Hm().format(sleep.endTime)}",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontSize: 25),
              ),
            ),
            Positioned(
                bottom: 0,
                right: 0,
                child: IconButton(
                    onPressed: () {
                      _handleDeleteSleep(sleep.id);
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 20,
                    )))
          ],
        ));
  }

  void _showAddSleepModel() {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(builder: (context, setState) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            "Schedule",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
          ),
          content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: const [
                    Text(
                      "Start time: ",
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
                Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          showDatePicker(
                                  context: context,
                                  firstDate: DateTime(DateTime.now().year),
                                  lastDate: DateTime(DateTime.now().year + 1))
                              .then((value) {
                            if (value != null) startTime = value;
                          });
                        },
                        child: Text(DateFormat.yMd().format(startTime))),
                    TextButton(
                        onPressed: () {
                          showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now())
                              .then((value) {
                            if (value != null) {
                              startTime = DateTime(
                                startTime.year,
                                startTime.month,
                                startTime.day,
                                value.hour,
                                value.minute,
                              );
                            }
                          });
                        },
                        child: Text(DateFormat.Hms().format(startTime))),
                  ],
                ),
                Row(
                  children: const [
                    Text(
                      "End time: ",
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
                Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          showDatePicker(
                                  context: context,
                                  firstDate: DateTime(DateTime.now().year),
                                  lastDate: DateTime(DateTime.now().year + 1))
                              .then((value) {
                            if (value != null) {
                              endTime = DateTime(
                                value.year,
                                value.month,
                                value.day,
                                endTime.hour,
                                endTime.minute,
                              );
                            }
                          });
                        },
                        child: Text(DateFormat.yMd().format(endTime))),
                    TextButton(
                        onPressed: () {
                          showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now())
                              .then((value) {
                            if (value != null) {
                              endTime = DateTime(
                                endTime.year,
                                endTime.month,
                                endTime.day,
                                value.hour,
                                value.minute,
                              );
                            }
                          });
                        },
                        child: Text(DateFormat.Hms().format(endTime))),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Color: ",
                      style: TextStyle(fontSize: 15),
                    ),
                    IconButton(
                        onPressed: () {
                          showColorPickerDialog(context, Colors.greenAccent)
                              .then((value) {
                            setState(() {
                              color = value;
                            });
                          });
                        },
                        icon: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: color),
                        ))
                  ],
                ),
                SizedBox(
                  width: 100,
                  child: TextButton(
                      onPressed: () {
                        _handleSetSchedule();
                        Navigator.of(context).pop();
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            ColorPalette.primaryColor),
                      ),
                      child: Text(
                        "Set",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      )),
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  void _handleSetSchedule() {
    SleepRequest.addSleep(
            Sleep(startTime: startTime, endTime: endTime, color: color))
        .then((value) => setState(() {
              sleepListStream = SleepRequest.getAll();
            }));
  }

  void _handleDeleteSleep(String? id) {
    debugPrint("Delete sleep with id $id");
    if (id != null) {
      SleepRequest.deleteSleep(id).then((value) => setState(() {
            sleepListStream = SleepRequest.getAll();
          }));
    }
  }
}
