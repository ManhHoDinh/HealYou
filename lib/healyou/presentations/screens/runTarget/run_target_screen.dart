import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:healyou/healyou/core/helper/text_styles.dart';
import 'package:healyou/healyou/presentations/screens/runTarget/tabs/month_target.dart';

import '../setTarget/set_target_screen.dart';
import 'tabs/date_target.dart';
import 'tabs/week_target.dart';

class RuntargetScreen extends StatefulWidget {
  const RuntargetScreen({super.key});

  @override
  State<RuntargetScreen> createState() => _RuntargetScreenState();
}

class _RuntargetScreenState extends State<RuntargetScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 4,
              padding: EdgeInsets.symmetric(horizontal: 80),
              tabs: [
                Tab(icon: Text('Date')),
                Tab(icon: Text('Week')),
                Tab(icon: Text('Month')),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              SingleChildScrollView(
                  scrollDirection: Axis.vertical, child: DateTarget()),
              WeekTarget(),
              MonthTarget()
            ],
          ),
        ));
  }
}
