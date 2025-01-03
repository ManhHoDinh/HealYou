import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healyou/healyou/core/controller/notify_controller.dart';
import 'package:healyou/healyou/core/controller/water_item_controller.dart';
import 'package:healyou/healyou/core/helper/assets_helper.dart';
import 'package:healyou/healyou/core/helper/firebase_helper.dart';
import 'package:healyou/healyou/core/models/firebase/target_request.dart';
import 'package:healyou/healyou/core/models/firebase/water_item_request.dart';
import 'package:healyou/healyou/core/models/target/target.dart';
import 'package:healyou/healyou/core/models/waterTargetItem/water_target_item.dart';
import 'package:healyou/healyou/presentations/screens/otherTarget/widgets/history_screen.dart';
import 'package:healyou/healyou/presentations/screens/otherTarget/widgets/water_reminder_item.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:water_bottle/water_bottle.dart';
import 'package:get/get.dart';

class WaterTarget extends StatefulWidget {
  const WaterTarget({super.key});

  @override
  State<WaterTarget> createState() => _WaterTargetState();
}

class _WaterTargetState extends State<WaterTarget> {
  final sphericalBottleRef = GlobalKey<SphericalBottleState>();
  var hour = 0;
  var minute = 0;
  var timeFormat = "AM";
  int targetItem = 200;
  WaterItemController waterItemController = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    String userId = FirebaseAuth.instance.currentUser!.uid;
    waterItemController.updateItems();
    return StreamBuilder<Target?>(
        stream:
            TargetRequest.getTarget(TargetType.water, DateTime.now(), userId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Target target = snapshot.data!;
            sphericalBottleRef.currentState?.waterLevel =
                target.reached / target.target;
            double waterLevel = target.reached / target.target;
            return Stack(children: [
              SingleChildScrollView(
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'today\'s goal',
                            style: TextStyle(
                                color: Color(0xff4F8795), fontSize: 16),
                          ),
                          Text(
                            'Drink ${target.target.toStringAsFixed(0)}ml',
                            style: TextStyle(
                                color: Color(0xff4F8795),
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                height: height * 3 / 10,
                                child: SphericalBottle(
                                    key: sphericalBottleRef,
                                    waterColor: Colors.blue,
                                    bottleColor: Colors.lightBlue,
                                    capColor: Colors.blueGrey),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Column(
                                  children: [
                                    Text(
                                      "${(waterLevel * 100).toStringAsFixed(0)}%",
                                      style: TextStyle(
                                          fontSize: 30,
                                          color: Color(0xff4F8795),
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                        '${((1 - waterLevel) * target.target).toStringAsFixed(0)}ml more',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Color(0xff4F8795),
                                            fontWeight: FontWeight.w600)),
                                  ],
                                ),
                              ),
                              Positioned(
                                bottom: 10,
                                child: IconButton(
                                    onPressed: () async {
                                      double newReached = target.reached + 200;
                                      DateTime now = DateTime.now();
                                      DateTime time = DateTime.utc(
                                          now.year,
                                          now.month,
                                          now.day,
                                          now.hour,
                                          now.minute);
                                      Timestamp timeStamp =
                                          Timestamp.fromDate(time);
                                      Map<String, dynamic> data = {
                                        "time": timeStamp,
                                        "target": targetItem,
                                        "isNotify": true,
                                        "userId": userId
                                      };
                                      WaterItemRequest.addWaterReminder(data);
                                      await TargetRequest.updateReached(
                                          target.id, newReached);
                                      waterItemController.updateItems();
                                    },
                                    icon: Image.asset(AssetHelper.glass)),
                              ),
                            ],
                          ),
                          Icon(
                            Icons.arrow_upward,
                            weight: 700,
                            color: Color(0xff34A2DD),
                            size: 30,
                          ),
                          Text(
                            'Confirm that you have just drunk water',
                            style: TextStyle(
                                color: Color.fromARGB(255, 132, 132, 132)),
                          ),
                          Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: Color(0xffECF9FF),
                                borderRadius: BorderRadius.circular(40)),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Text(
                                    'Next Schedule',
                                    style: TextStyle(
                                        fontSize: 18, color: Color(0xff4F8795)),
                                  ),
                                ),
                                Obx(() {
                                  List<WaterTargetItem> data =
                                      waterItemController.listItems
                                          .where((element) {
                                    DateTime date = DateTime.now();
                                    DateTime dateTime = (DateTime.utc(
                                        date.year,
                                        date.month,
                                        date.day,
                                        date.hour,
                                        date.minute,
                                        date.second));
                                    return element.time!.isAfter(dateTime);
                                  }).toList();

                                  return ListView.separated(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: ((context, index) {
                                        return WaterReminderItem(
                                            item: data[index]);
                                      }),
                                      separatorBuilder: ((context, index) {
                                        return SizedBox(
                                          height: 16,
                                        );
                                      }),
                                      itemCount: data.length);
                                }),
                              ],
                            ),
                          ),
                          SizedBox(height: 40),
                          Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: Color(0xffECF9FF),
                                borderRadius: BorderRadius.circular(40)),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Text(
                                    'History',
                                    style: TextStyle(
                                        fontSize: 18, color: Color(0xff4F8795)),
                                  ),
                                ),
                                Obx(() {
                                  List<WaterTargetItem> data =
                                      waterItemController.listItems
                                          .where((element) {
                                    DateTime date = DateTime.now();
                                    DateTime dateTime = (DateTime.utc(
                                        date.year,
                                        date.month,
                                        date.day,
                                        date.hour,
                                        date.minute,
                                        date.second));
                                    return element.time!.isBefore(dateTime) ||
                                        element.time!
                                            .isAtSameMomentAs(dateTime);
                                  }).toList();
                                  return ListView.separated(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: ((context, index) {
                                        return WaterReminderItem(
                                            isHistory: true, item: data[index]);
                                      }),
                                      separatorBuilder: ((context, index) {
                                        return SizedBox(
                                          height: 16,
                                        );
                                      }),
                                      itemCount: data.length);
                                }),
                              ],
                            ),
                          ),
                        ],
                      ))),
              Positioned(
                  top: 0,
                  left: 0,
                  child: IconButton(
                      icon: Icon(Icons.history),
                      onPressed: () {
                        Get.to(() => HistoryScreen());
                      })),
              Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    icon: Icon(
                      Icons.settings,
                      color: Color(0xff30CCF5),
                    ),
                    onPressed: () {
                      Get.defaultDialog(
                          title: "Add Schedule",
                          middleText: "Hello world!",
                          backgroundColor: Colors.white,
                          onCancel: () {
                            setState(() {
                              targetItem = 200;
                            });
                          },
                          onConfirm: () {
                            confirmHandler(target);
                          },
                          titleStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 20),
                          middleTextStyle: TextStyle(color: Colors.black),
                          textConfirm: "Confirm",
                          textCancel: "Cancel",
                          cancelTextColor: Color(0xff1AAEEE),
                          confirmTextColor: Colors.white,
                          buttonColor: Color(0xff1AAEEE),
                          barrierDismissible: false,
                          radius: 50,
                          content: StatefulBuilder(
                            builder: (context, setState) {
                              return Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Target',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              setState(() {
                                                if (targetItem > 0) {
                                                  targetItem -= 50;
                                                }
                                              });
                                            },
                                            icon: Icon(
                                              Icons.remove,
                                              color: Colors.white,
                                              size: 24,
                                            ),
                                            style: IconButton.styleFrom(
                                                backgroundColor: Color.fromARGB(
                                                    255, 143, 198, 224)),
                                          ),
                                          Column(
                                            children: [
                                              AnimatedContainer(
                                                duration:
                                                    Duration(milliseconds: 300),
                                                curve: Curves.easeInOut,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10),
                                                  child: Text(
                                                    targetItem.toString(),
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w800),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              setState(() {
                                                if (targetItem <
                                                    target.target) {
                                                  targetItem += 50;
                                                }
                                              });
                                            },
                                            icon: Icon(
                                              Icons.add,
                                              size: 24,
                                              color: Colors.white,
                                            ),
                                            style: IconButton.styleFrom(
                                                backgroundColor: Color.fromARGB(
                                                    255, 143, 198, 224)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Time',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        NumberPicker(
                                          minValue: 0,
                                          maxValue: 12,
                                          value: hour,
                                          zeroPad: true,
                                          infiniteLoop: true,
                                          itemWidth: 40,
                                          itemHeight: 40,
                                          onChanged: (value) {
                                            setState(() {
                                              hour = value;
                                            });
                                          },
                                          textStyle: const TextStyle(
                                              color: Colors.grey, fontSize: 16),
                                          selectedTextStyle: const TextStyle(
                                              color: Color(0xff4F8795),
                                              fontSize: 20),
                                          decoration: const BoxDecoration(
                                            border: Border(
                                                top: BorderSide(
                                                  color: Colors.white,
                                                ),
                                                bottom: BorderSide(
                                                    color: Colors.white)),
                                          ),
                                        ),
                                        NumberPicker(
                                          minValue: 0,
                                          maxValue: 59,
                                          value: minute,
                                          zeroPad: true,
                                          infiniteLoop: true,
                                          itemWidth: 40,
                                          itemHeight: 40,
                                          onChanged: (value) {
                                            setState(() {
                                              minute = value;
                                            });
                                          },
                                          textStyle: const TextStyle(
                                              color: Colors.grey, fontSize: 16),
                                          selectedTextStyle: const TextStyle(
                                              color: Color(0xff4F8795),
                                              fontSize: 20),
                                          decoration: const BoxDecoration(
                                            border: Border(
                                                top: BorderSide(
                                                  color: Colors.white,
                                                ),
                                                bottom: BorderSide(
                                                    color: Colors.white)),
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  timeFormat = "AM";
                                                });
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  color: timeFormat == "AM"
                                                      ? Color(0xff4F8795)
                                                      : Colors.grey.shade700,
                                                ),
                                                child: const Text(
                                                  "AM",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  timeFormat = "PM";
                                                });
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  color: timeFormat == "PM"
                                                      ? Color(0xff4F8795)
                                                      : Colors.grey.shade700,
                                                ),
                                                child: const Text(
                                                  "PM",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16),
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      ])
                                ]),
                              );
                            },
                          ));
                    },
                  ))
            ]);
          }
          return Container();
        });
  }

  void confirmHandler(Target target) {
    DateTime now = DateTime.now();
    if (timeFormat == 'PM') hour = hour + 12;

    DateTime time = DateTime.utc(now.year, now.month, now.day, hour, minute);
    Timestamp timeStamp = Timestamp.fromDate(time);
    Map<String, dynamic> data = {
      "time": timeStamp,
      "target": targetItem,
      "isNotify": true,
      "userId": target.userId
    };
    WaterItemRequest.addWaterReminder(data);
    waterItemController.updateItems();

    setState(() {
      hour = 0;
      minute = 0;
      timeFormat = 'AM';
    });
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: NotifyController.onActionReceivedMethod,
        onNotificationCreatedMethod:
            NotifyController.onNotificationCreatedMethod,
        onNotificationDisplayedMethod:
            NotifyController.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod:
            NotifyController.onDismissActionReceivedMethod);
    NotifyController.scheduleNotification(
        time,
        "Water reminder",
        "You have scheduled to drink at ${DateFormat("hh:mm aa").format(time)}",
        target,
        targetItem);
    Get.back();
  }
}
