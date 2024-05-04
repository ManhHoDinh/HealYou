import 'dart:async';
import 'dart:isolate';

import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
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
import 'package:audio_waveforms/audio_waveforms.dart';

class SleepTarget extends StatefulWidget {
  const SleepTarget({Key? key}) : super(key: key);
  @override
  _SleepTargetState createState() => _SleepTargetState();
}

class _SleepTargetState extends State<SleepTarget> {
  var seeMoreSelected = false;
  late DateTime startSleepTime;
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now();
  Color color = Colors.greenAccent;
  late Stream<List<Sleep>> sleepListStream;
  var _sleepTime = false;
  late List<Sleep> sleepList;
  var recording = false;
  late RecorderController controller;
  @override
  void initState() {
    super.initState();
    var start = DateTime.now();
    start = start.subtract(Duration(hours: 6));
    var end = start.add(Duration(hours: 6));
    sleepListStream = SleepRequest.getByDate(start, end);
    sleepListStream.listen((event) {
      debugPrint(event.toString());
      setState(() {
        event.sort((a, b) =>
            (closestToNow(a.startTime, b.startTime, DateTime.now()) ==
                    a.startTime
                ? 1
                : -1));
        if (event.isEmpty) return;
        if (event[0].startTime.isBefore(DateTime.now()) &&
            event[0].endTime.isAfter(DateTime.now())) _sleepTime = true;
        if (event[0].startTime.isAfter(DateTime.now())) {
          Future.delayed(DateTime.now().difference(event[0].startTime), () {
            setState(() {
              _sleepTime = true;
            });
          });
        }

        sleepList = event;
      });
    });
    controller = RecorderController(); // Initialise
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Sleep>>(
        stream: sleepListStream,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            var _sleepList = snapshot.data;
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          ..._sleepList!
                              .asMap()
                              .map(
                                (key, value) => MapEntry(
                                    key,
                                    TimeArc(
                                      width: 200,
                                      height: 200,
                                      padding: 10 + key * 20.0,
                                      sleep: value,
                                    )),
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
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(),
                      duration: Duration(seconds: 2),
                      child: _sleepList.isEmpty
                          ? TextButton(
                              onPressed: () {
                                _showAddSleepModel();
                              },
                              child: Text(
                                  "Add sleep to start schedule your sleep"))
                          : Column(
                              children: [
                                ..._sleepList
                                    .map((e) => buildNextSleepItem(e))
                                    .toList()
                              ],
                            ),
                    ),
                    // _sleepTime &&
                    //         _sleepList.isNotEmpty &&
                    //         DateTime.now().isAfter(_sleepList[0].startTime) &&
                    //         DateTime.now().isBefore(_sleepList[0].endTime) &&
                    //         !seeMoreSelected
                    //     ? Container(
                    //         width: 50,
                    //         height: 50,
                    //         decoration: BoxDecoration(
                    //             shape: BoxShape.circle, color: Colors.orange),
                    //         child: Center(
                    //             child: IconButton(
                    //           onPressed: () {
                    //             _handleOnRecording();
                    //           },
                    //           icon: Icon(
                    //             recording ? Icons.square : Icons.alarm_on,
                    //             color: Colors.white,
                    //           ),
                    //         )))
                    //     : SizedBox.shrink(),
                    Center(
                      child: AudioWaveforms(
                        size: Size(MediaQuery.of(context).size.width, 50.0),
                        recorderController: controller,
                        enableGesture: true,
                        waveStyle: WaveStyle(
                          waveColor: Colors.blueAccent.shade200,
                          spacing: 8.0,
                          showBottom: false,
                          extendWaveform: true,
                          showMiddleLine: false,
                        ),
                      ),
                    ),
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
                            if (value != null) {
                              startTime = DateTime(
                                value.year,
                                value.month,
                                value.day,
                                startTime.hour,
                                startTime.minute,
                              );
                              setState(() {});
                            }
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
                              setState(() {});
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
                              setState(() {});
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
                              setState(() {});
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
              var start = DateTime.now();
              start = start.subtract(Duration(hours: 6));
              var end = start.add(Duration(hours: 6));
              sleepListStream = SleepRequest.getByDate(start, end);
              sleepListStream.listen((event) {
                setState(() {
                  event.sort((a, b) =>
                      (closestToNow(a.startTime, b.startTime, DateTime.now()) ==
                              a.startTime
                          ? 1
                          : -1));
                  sleepList = event;
                });
              });
            }));
  }

  void _handleDeleteSleep(String? id) {
    debugPrint("Delete sleep with id $id");
    if (id != null) {
      SleepRequest.deleteSleep(id).then((value) => setState(() {
            var start = DateTime.now();
            start = start.subtract(Duration(hours: 6));
            var end = start.add(Duration(hours: 6));
            sleepListStream = SleepRequest.getByDate(start, end);
            sleepListStream.listen((event) {
              setState(() {
                event.sort((a, b) =>
                    (closestToNow(a.startTime, b.startTime, DateTime.now()) ==
                            a.startTime
                        ? 1
                        : -1));
                sleepList = event;
              });
            });
          }));
    }
  }

  void _handleOnRecording() async {
    if (recording) {
      await Alarm.stopAll();
      await controller.stop();
      controller.refresh();
      for (var element in sleepList) {
        if (element.startTime.isBefore(DateTime.now()) &&
            startTime.isBefore(element.endTime)) {
          SleepRequest.addSleepTime(
              element.id!,
              element.startTime.isAfter(startTime)
                  ? element.startTime
                  : startTime,
              DateTime.now());
        }
      }
    } else {
      startSleepTime = DateTime.now();
      await controller.record();
      final alarmSettings = AlarmSettings(
        id: 42,
        dateTime: sleepList[0].endTime,
        assetAudioPath: "assets/sound/marimba.mp3",
        loopAudio: true,
        vibrate: true,
        volume: 0.8,
        fadeDuration: 3.0,
        notificationTitle: 'Wake up.',
        notificationBody: ' You have sleep enough',
        enableNotificationOnKill: true,
        androidFullScreenIntent: true,
      );
      Alarm.ringStream.stream.listen((event) {}, onDone: () {
        _handleOnRecording();
      });
      await Alarm.set(alarmSettings: alarmSettings);
    }
    setState(() {
      recording = !recording;
    });
  }
}

DateTime closestToNow(DateTime a, DateTime b, DateTime now) {
  if (a.isBefore(now) && b.isAfter(now)) return b;
  if (b.isBefore(now) && a.isAfter(now)) return a;

  return (now.difference(a).abs() < now.difference(b).abs()) ? a : b;
}
