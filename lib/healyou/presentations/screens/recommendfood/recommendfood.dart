import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:healyou/app_theme.dart';
import 'package:healyou/healyou/core/constants/color_palatte.dart';
import 'package:healyou/healyou/core/helper/text_styles.dart';
import 'package:healyou/healyou/core/models/food/food.dart';
import 'package:healyou/healyou/presentations/screens/map/run_map_screen.dart';
import 'package:healyou/healyou/presentations/widgets/AppBar.dart';
import 'package:healyou/healyou/presentations/widgets/button_widget.dart';
import 'package:healyou/healyou/presentations/widgets/recommendFoodWidget.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../../../core/constants/dimension_constants.dart';
import '../../../core/helper/assets_helper.dart';
import '../../../core/helper/image_helper.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RecommendFoodSrceen extends StatefulWidget {
  const RecommendFoodSrceen({super.key, this.animationController});
  static final String routeName = 'home_screen';
  final AnimationController? animationController;

  @override
  State<RecommendFoodSrceen> createState() => _RecommendFoodSrceenState();
}

class _RecommendFoodSrceenState extends State<RecommendFoodSrceen>
    with TickerProviderStateMixin {
  final url =
      'https://api.edamam.com/search?q=rice&app_id=ff91fcd3&app_key=7bda438b43ce3c13d7ce49ef25aee31f&from=0&to=10&calories=591-722&health=alcohol-free';
  getApiData() async {
    var response = await http.get(Uri.parse(url));
    Map<String, dynamic> json = jsonDecode(response.body);
    List<dynamic> data = json['hits'];
    recommendFood.clear();
    data.forEach((item) {
      FoodModel food = FoodModel(
        Id: item['recipe']['uri'],
        Name: item['recipe']['label'],
        Weight: item['recipe']['totalWeight'].toString(),
        ImageLink: item['recipe']['image'],
        Description: item['recipe']['source'],
        url: item['recipe']['url'],
      );
      recommendFood.add(food);
    });
    setState(() {});
  }

  String? text;

  void initState() {
    super.initState();
    getApiData();
  }

  AnimationController? animationController;
  bool multiple = true;
  List<FoodModel> recommendFood = [];
  @override
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
        child: Column(
          children: [
            AppBarWidget(title: "Trending Food"),
            Expanded(
                child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              margin: const EdgeInsets.only(top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (v) {
                        text = v;
                      },
                      onSubmitted: (v) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SearchPage(
                              search: text,
                            ),
                          ),
                        );
                      },
                      decoration: InputDecoration(
                        labelText: 'Search',
                        suffixIcon: IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SearchPage(
                                  search: text,
                                ),
                              ),
                            );
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "Recommended Food",
                        style: TextStyles.h3.bold,
                      ),
                      Spacer(),
                      Container(
                        height: 35,
                        decoration: BoxDecoration(
                            color: ColorPalette.primaryColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "View all",
                            style: TextStyles.h6
                                .copyWith(color: ColorPalette.white),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 600,
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      childAspectRatio: 1,
                      children: [
                        ...recommendFood.map((e) => Expanded(
                                child: RecommendFoodWidget(
                              food: e,
                              onTap: () {
                                print('Navigating to URL: ${e.url}');
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => WebPage(
                                              url: e.url,
                                            )));
                              },
                            )))
                      ],
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}

class SearchPage extends StatefulWidget {
  String? search;
  SearchPage({this.search});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  getApiData(search) async {
    final url =
        'https://api.edamam.com/search?q=$search&app_id=ff91fcd3&app_key=7bda438b43ce3c13d7ce49ef25aee31f&from=0&to=10&calories=591-722&health=alcohol-free';
    var response = await http.get(Uri.parse(url));
    Map<String, dynamic> json = jsonDecode(response.body);
    List<dynamic> data = json['hits'];
    recommendFood.clear();
    data.forEach((item) {
      FoodModel food = FoodModel(
        Id: item['recipe']['uri'],
        Name: item['recipe']['label'],
        Weight: item['recipe']['totalWeight'].toString(),
        ImageLink: item['recipe']['image'],
        Description: item['recipe']['source'],
        url: item['recipe']['url'],
      );
      recommendFood.add(food);
    });
    setState(() {});
  }

  String? text;

  void initState() {
    super.initState();
    getApiData(widget.search);
  }

  AnimationController? animationController;
  bool multiple = true;
  List<FoodModel> recommendFood = [];
  @override
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
        child: Column(
          children: [
            AppBarWidget(title: "Trending Food"),
            Expanded(
                child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              margin: const EdgeInsets.only(top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        "Recommended Food",
                        style: TextStyles.h3.bold,
                      ),
                      Spacer(),
                      Container(
                        height: 35,
                        decoration: BoxDecoration(
                            color: ColorPalette.primaryColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "View all",
                            style: TextStyles.h6
                                .copyWith(color: ColorPalette.white),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 600,
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      childAspectRatio: 1,
                      children: [
                        ...recommendFood.map((e) => Expanded(
                                child: RecommendFoodWidget(
                              food: e,
                              onTap: () {
                                print('Navigating to URL: ${e.url}');
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => WebPage(
                                              url: e.url,
                                            )));
                              },
                            )))
                      ],
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}

class WebPage extends StatefulWidget {
  final String url;

  WebPage({required this.url});

  @override
  _WebPageState createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WebView(
          initialUrl: widget.url,
        ),
      ),
    );
  }
}
