import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healyou/healyou/core/controller/water_item_controller.dart';
import 'package:healyou/healyou/core/models/firebase/water_item_request.dart';
import 'package:healyou/healyou/core/models/waterTargetItem/water_target_item.dart';
import 'package:intl/intl.dart';


class WaterReminderItem extends StatefulWidget {
  final WaterTargetItem item;
  final bool? isHistory;
  const WaterReminderItem({super.key, required this.item, this.isHistory});

  @override
  State<WaterReminderItem> createState() => _WaterReminderItemState();
}

class _WaterReminderItemState extends State<WaterReminderItem> {
  WaterItemController waterItemController = Get.find();
  @override
  Widget build(BuildContext context) {
    DateTime time = widget.item.time!.toUtc();
    bool switchValue = widget.item.isNotify;
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
            child: widget.isHistory == null
                ? Switch(
                    value: switchValue,
                    activeColor: Colors.white,
                    inactiveThumbColor: Color.fromARGB(255, 203, 203, 203),
                    activeTrackColor: Color(0xff30CCF5),
                    inactiveTrackColor: Colors.white,
                    onChanged: (value) {
                      setState(() {
                        switchValue = value;
                      });
                      WaterItemRequest.updateNotify(widget.item.id, value);
                      if (!value) {
                        int id = time.millisecondsSinceEpoch ~/ 1000;
                        AwesomeNotifications().cancel(id);
                      }
                    })
                : Container(),
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
            onPressed: () {
              WaterItemRequest.deleteWaterReminder(widget.item.id);
              waterItemController.updateItems();
            },
            icon: Icon(
              Icons.delete,
              color: Color(0xff30CCF5),
              size: 24,
            ),
          )
        ],
      ),
    );
  }
}
