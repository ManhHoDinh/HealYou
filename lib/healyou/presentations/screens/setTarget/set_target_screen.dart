import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:healyou/healyou/core/constants/color_palatte.dart';
import 'package:healyou/healyou/core/helper/assets_helper.dart';
import 'package:healyou/healyou/core/models/firebase/target_request.dart';
import 'package:healyou/healyou/core/models/target/target.dart';
import 'package:healyou/healyou/presentations/screens/setTarget/widgets/set_item_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SetTargetScreen extends StatefulWidget {
  const SetTargetScreen({super.key});

  @override
  State<SetTargetScreen> createState() => _SetTargetScreenState();
}

class _SetTargetScreenState extends State<SetTargetScreen> {
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
              StreamBuilder<Target?>(
                  stream: TargetRequest.getTarget(TargetType.step),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return SetItemWidget(
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
                          value: snapshot.data!.target,
                          addHandler: () async => addHandler(
                              snapshot.data!.target, 500, snapshot.data!.id),
                          removeHandler: () async => removeHandler(
                              snapshot.data!.target, 500, snapshot.data!.id));
                    }
                    return Container();
                  }),
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
                        StreamBuilder<Target?>(
                            stream: TargetRequest.getTarget(TargetType.kcal),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return SetItemWidget(
                                    title: Row(
                                      children: [
                                        Icon(Icons.local_fire_department,
                                            color: ColorPalette.mainRunColor),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Text(
                                            'kcal',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        )
                                      ],
                                    ),
                                    value: snapshot.data!.target,
                                    addHandler: () => addHandler(
                                        snapshot.data!.target,
                                        100,
                                        snapshot.data!.id),
                                    removeHandler: () => removeHandler(
                                        snapshot.data!.target,
                                        100,
                                        snapshot.data!.id));
                              }
                              return Container();
                            }),
                        SizedBox(
                          height: 20,
                        ),
                        StreamBuilder<Target?>(
                            stream:
                                TargetRequest.getTarget(TargetType.distance),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return SetItemWidget(
                                    title: Row(
                                      children: [
                                        Icon(Icons.arrow_forward,
                                            color: ColorPalette.mainRunColor),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Text(
                                            'km',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        )
                                      ],
                                    ),
                                    value: snapshot.data!.target,
                                    addHandler: () => addHandler(
                                        snapshot.data!.target,
                                        1,
                                        snapshot.data!.id),
                                    removeHandler: () => removeHandler(
                                        snapshot.data!.target,
                                        1,
                                        snapshot.data!.id));
                              }
                              return Container();
                            }),
                        SizedBox(
                          height: 20,
                        ),
                        StreamBuilder<Target?>(
                            stream: TargetRequest.getTarget(TargetType.time),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return SetItemWidget(
                                    title: Row(
                                      children: [
                                        Icon(Icons.schedule,
                                            color: ColorPalette.mainRunColor),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Text(
                                            'minutes',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        )
                                      ],
                                    ),
                                    value: snapshot.data!.target,
                                    addHandler: () => addHandler(
                                        snapshot.data!.target,
                                        10,
                                        snapshot.data!.id),
                                    removeHandler: () => removeHandler(
                                        snapshot.data!.target,
                                        10,
                                        snapshot.data!.id));
                              }
                              return Container();
                            }),
                      ],
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }

  void addHandler(int currentValue, int stepValue, String id) async {
    currentValue += stepValue;
    await TargetRequest.updateTarget(id, currentValue);
  }

  void removeHandler(int currentValue, int stepValue, String id) async {
    if (currentValue >= stepValue) {
      currentValue -= stepValue;
    }
    await TargetRequest.updateTarget(id, currentValue);
  }
}
