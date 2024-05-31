import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:healyou/healyou/core/helper/text_styles.dart';
import 'package:healyou/healyou/presentations/screens/otherTarget/tabs/sleepTarget.dart';
import 'package:healyou/healyou/presentations/screens/otherTarget/tabs/water_target.dart';
import 'package:healyou/healyou/presentations/screens/runTarget/tabs/month_target.dart';
import 'package:healyou/healyou/presentations/widgets/AppBar.dart';
import 'package:intl/intl.dart';

import '../Nutrition/nutrition_tab.dart';
import '../setTarget/set_target_screen.dart';

class OtherTargetScreen extends StatefulWidget {
  AnimationController? animationController;
  OtherTargetScreen({super.key, this.animationController});

  @override
  State<OtherTargetScreen> createState() => _OtherTargetScreenState();
}

class _OtherTargetScreenState extends State<OtherTargetScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);

    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: AppBarWidget(
              title: DateFormat("dd/MM/yyyy").format(DateTime.now()),
            ),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
            bottom: TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 4,
              indicatorColor: Color(0xff1AAEEE),
              padding: EdgeInsets.symmetric(horizontal: 16),
              tabs: [
                Tab(icon: Text('Water')),
                Tab(icon: Text('Nutrition')),
                //  Tab(icon: Text('Sleep')),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              WaterTarget(),
              NutritionSreen(),
              //  SleepTarget(),
            ],
          ),
        ));
  }
}
