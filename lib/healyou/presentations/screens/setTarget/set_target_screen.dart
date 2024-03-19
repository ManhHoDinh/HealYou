import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:healyou/healyou/core/constants/color_palatte.dart';
import 'package:healyou/healyou/core/helper/assets_helper.dart';
import 'package:healyou/healyou/presentations/screens/setTarget/widgets/set_item_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SetTargetScreen extends StatefulWidget {
  const SetTargetScreen({super.key});

  @override
  State<SetTargetScreen> createState() => _SetTargetScreenState();
}

class _SetTargetScreenState extends State<SetTargetScreen> {
  int step = 7000;
  int kcal = 300;
  int distance = 3;
  int time = 30;
  double fontSize = 32;
  bool switchValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back_ios),
          style: IconButton.styleFrom(backgroundColor: Color(0xffECF0F4)),
        ),
        title: Text(
          'Target',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'Set goals. Count your steps. Burn calories',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              SetItemWidget(
                  title: Row(
                    children: [
                      Image.asset(AssetHelper.step),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Step',
                          style: TextStyle(fontSize: 16),
                        ),
                      )
                    ],
                  ),
                  value: step,
                  addHandler: () => addHandler("step", 500),
                  removeHandler: () => removeHandler("step", 500)),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Icon(
                          Icons.notifications,
                          fill: 1,
                          size: 30,
                          color: ColorPalette.mainRunColor,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text('Notification',
                              style: TextStyle(fontSize: 16)),
                        )
                      ],
                    ),
                  ),
                  Icon(Icons.chevron_right,
                      size: 30, color: ColorPalette.mainRunColor)
                ],
              ),
              Divider(
                height: 2,
                color: Color(0xffE1DEDE),
                thickness: 2,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.ads_click,
                          fill: 1,
                          size: 30,
                          color: ColorPalette.mainRunColor,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text('More targets',
                              style: TextStyle(fontSize: 16)),
                        )
                      ],
                    ),
                    Switch(
                        value: switchValue,
                        activeColor: ColorPalette.mainRunColor,
                        inactiveThumbColor: Colors.white,
                        activeTrackColor: ColorPalette.mediumRunColor,
                        inactiveTrackColor: Color.fromARGB(255, 203, 203, 203),
                        onChanged: (value) {
                          setState(() {
                            switchValue = value;
                          });
                        })
                  ],
                ),
              ),
              switchValue
                  ? Column(
                      children: [
                        SetItemWidget(
                            title: Row(
                              children: [
                                Icon(Icons.local_fire_department,
                                    color: ColorPalette.mainRunColor),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    'kcal',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                )
                              ],
                            ),
                            value: kcal,
                            addHandler: () => addHandler("kcal", 100),
                            removeHandler: () => removeHandler("kcal", 100)),
                        SizedBox(
                          height: 20,
                        ),
                        SetItemWidget(
                            title: Row(
                              children: [
                                Icon(Icons.arrow_forward,
                                    color: ColorPalette.mainRunColor),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    'km',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                )
                              ],
                            ),
                            value: distance,
                            addHandler: () => addHandler("distance", 100),
                            removeHandler: () => removeHandler("distance", 1)),
                        SizedBox(
                          height: 20,
                        ),
                        SetItemWidget(
                            title: Row(
                              children: [
                                Icon(Icons.schedule,
                                    color: ColorPalette.mainRunColor),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    'minutes',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                )
                              ],
                            ),
                            value: time,
                            addHandler: () => addHandler("time", 100),
                            removeHandler: () => removeHandler("time", 10)),
                      ],
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }

  void addHandler(String type, int stepValue) {
    switch (type) {
      case "step":
        setState(
          () {
            step += stepValue;
          },
        );
        break;
      case "kcal":
        setState(
          () {
            kcal += stepValue;
          },
        );
        break;
      case "time":
        setState(
          () {
            time += stepValue;
          },
        );
        break;
      case "distance":
        setState(
          () {
            distance += stepValue;
          },
        );
        break;
    }
  }

  void removeHandler(String type, int stepValue) {
    switch (type) {
      case "step":
        setState(
          () {
            step -= stepValue;
          },
        );
        break;
      case "kcal":
        setState(
          () {
            kcal -= stepValue;
          },
        );
        break;
      case "time":
        setState(
          () {
            time -= stepValue;
          },
        );
        break;
      case "distance":
        setState(
          () {
            distance -= stepValue;
          },
        );
        break;
    }
  }
}
