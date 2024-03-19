import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:healyou/healyou/core/helper/text_styles.dart';

import 'tabs/date_target.dart';

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
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TabBarView(
              children: [
                SingleChildScrollView(
                    scrollDirection: Axis.vertical, child: DateTarget()),
                Icon(Icons.directions_transit, size: 350),
                Icon(Icons.directions_car, size: 350),
              ],
            ),
          ),
        ));
  }
}
