import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:healyou/healyou/core/constants/color_palatte.dart';
import 'package:healyou/healyou/core/helper/assets_helper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:healyou/healyou/presentations/screens/Nutrition/tab/nutrition_tab.dart'; // Import this
import 'package:healyou/healyou/presentations/screens/map/time_run_map.dart';

class Nutrition extends StatefulWidget {
  const Nutrition({super.key});

  @override
  State<Nutrition> createState() => NutritionState();
}

class NutritionState extends State<Nutrition> {
  // ...

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text(
                    'TODAY',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w900,
                      height: 0,
                    ),
                  ),
                  const Text(
                    '14/03/2023',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w100,
                      height: 0,
                    ),
                  ),
                ],
              ),
            ),
            TabBar(
              tabs: [
                Tab(text: 'Water'),
                Tab(text: 'Nutrition'),
                Tab(text: 'Sleep'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Center(child: Text('Water Content')),
                  DateTarget(),
                  Center(child: Text('Sleep Content')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
