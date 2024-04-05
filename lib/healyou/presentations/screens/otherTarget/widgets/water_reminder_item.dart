import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:healyou/healyou/core/models/target/target.dart';
import 'package:healyou/healyou/core/models/waterTargetItem/water_target_item.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/color_palatte.dart';

class WaterReminderItem extends StatefulWidget {
  final WaterTargetItem item;
  const WaterReminderItem({super.key, required this.item});

  @override
  State<WaterReminderItem> createState() => _WaterReminderItemState();
}

class _WaterReminderItemState extends State<WaterReminderItem> {
  bool switchValue = true;

  @override
  Widget build(BuildContext context) {
    DateTime time = widget.item.time;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Switch(
                value: switchValue,
                activeColor: Colors.white,
                inactiveThumbColor: Color.fromARGB(255, 203, 203, 203),
                activeTrackColor: Color(0xff30CCF5),
                inactiveTrackColor: Colors.white,
                onChanged: (value) {
                  setState(() {
                    switchValue = value;
                  });
                }),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat("hh:mm aa").format(time),
                  style: TextStyle(
                      color: Color(0xff4F8795),
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
                Text(widget.item.target.toString(),
                    style: TextStyle(color: Color(0xff4F8795), fontSize: 16))
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_horiz,
              color: Color(0xff30CCF5),
              size: 24,
            ),
          )
        ],
      ),
    );
  }
}
