import 'package:flutter/material.dart';
import 'package:healyou/healyou/core/constants/color_palatte.dart';
import 'package:healyou/healyou/core/helper/text_styles.dart';
import 'package:healyou/healyou/core/models/food/food.dart';
import 'package:healyou/healyou/presentations/screens/map/run_map_screen.dart';
import 'package:healyou/healyou/presentations/screens/recommendfood/recommendfood.dart';
import 'package:healyou/healyou/presentations/screens/run/track/run_track.dart';
import 'package:healyou/healyou/presentations/widgets/AppBar.dart';
import 'package:healyou/healyou/presentations/widgets/button_widget.dart';
import 'package:healyou/healyou/presentations/widgets/recommendFoodWidget.dart';
import 'package:intl/intl.dart';
import 'package:healyou/healyou/presentations/screens/recommendedDishes/recommended_dishes_screen.dart';
import '../../../core/helper/assets_helper.dart';
import '../../../core/helper/image_helper.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.animationController});
  static const String routeName = 'home_screen';
  final AnimationController? animationController;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  AnimationController? animationController;
  bool multiple = true;
  List<FoodModel> recommendFood = [];
  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    FoodModel food = FoodModel(
        Id: "",
        Name: "Biryani",
        Weight: "200g",
        ImageLink: AssetHelper.food,
        Description:
            "Need the best thing for cheat day. Biryani is the thing for you.....",
        url: '');
    recommendFood.add(food);
    recommendFood.add(food);

    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 0));
    return true;
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppBarWidget(title: "Home Screen"),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                margin: const EdgeInsets.only(top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 230,
                      decoration: BoxDecoration(
                          color: ColorPalette.primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Row(children: [
                        Expanded(
                            flex: 5,
                            child: Container(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  Text(
                                    "Welcome back, Heal You",
                                    style: TextStyles.h1.bold
                                        .copyWith(color: Colors.white),
                                  ),
                                  Spacer(),
                                  Text(
                                    "Today workout:Running - 30 minutes",
                                    style: TextStyles.h6
                                        .copyWith(color: Colors.white),
                                  ),
                                  Spacer(),
                                  SizedBox(
                                    height: 50,
                                    width: 150,
                                    child: ButtonWidget(
                                      label: "Start now",
                                      color: ColorPalette.white,
                                      textColor: ColorPalette.primaryColor,
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                            RunTrackScreen.routeName);
                                      },
                                    ),
                                  )
                                ],
                              ),
                            )),
                        Expanded(
                            flex: 2,
                            child: Column(
                              children: [
                                Expanded(
                                    child: ImageHelper.loadFromAsset(
                                        AssetHelper.banner)),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 16, bottom: 30),
                                  child: Text(
                                    DateFormat('d/M/y').format(DateTime.now()),
                                    style: TextStyles.h6.bold
                                        .copyWith(color: Colors.white),
                                  ),
                                )
                              ],
                            ))
                      ]),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          "Trending Food",
                          style: TextStyles.h3.bold,
                        ),
                        Spacer(),
                        // Container(
                        //   height: 35,
                        //   decoration: BoxDecoration(
                        //       color: ColorPalette.primaryColor,
                        //       borderRadius: BorderRadius.circular(10)),
                        //   child: TextButton(
                        //     onPressed: () {
                        //       Navigator.pushNamed(
                        //           context, RecommendFoodSrceen.routeName);
                        //     },
                        //     child: Text(
                        //       "View all",
                        //       style: TextStyles.h6
                        //           .copyWith(color: ColorPalette.white),
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 170,
                      child: GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        childAspectRatio: 1,
                        children: [
                          ...recommendFood.map((e) => RecommendFoodWidget(
                                food: e,
                                onTap: () {},
                              ))
                        ],
                      ),
                    ),
                    Container(
                      height: 180,
                      margin: EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        children: [
                          Expanded(
                              child: Container(
                            decoration: BoxDecoration(
                              color: ColorPalette.primaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, RunMap.routeName);
                              },
                              child: Column(
                                children: [
                                  Container(
                                    child: Text(
                                      "Workout\nof the week",
                                      style: TextStyles.h6.whiteTextColor.bold,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Expanded(
                                    child: ImageHelper.loadFromAsset(
                                        AssetHelper.running,
                                        fit: BoxFit.fill),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    child: Text(
                                      "jogging",
                                      style: TextStyles.h6.whiteTextColor.bold
                                          .copyWith(
                                              fontStyle: FontStyle.italic),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: Column(
                            children: [
                              Expanded(
                                  child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image:
                                        AssetImage(AssetHelper.caloBackground),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          "2281",
                                          style:
                                              TextStyles.h3.whiteTextColor.bold,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "Today's calories",
                                      style: TextStyles.h6.whiteTextColor,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    )
                                  ],
                                ),
                              )),
                              SizedBox(
                                height: 10,
                              ),
                              Expanded(
                                  child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image:
                                        AssetImage(AssetHelper.WaterBackground),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "H2O",
                                      style: TextStyles.h3.whiteTextColor.bold,
                                    ),
                                    Spacer(),
                                    Text(
                                      "200",
                                      style: TextStyles.h6.whiteTextColor.bold,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ),
                              )),
                            ],
                          )),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
