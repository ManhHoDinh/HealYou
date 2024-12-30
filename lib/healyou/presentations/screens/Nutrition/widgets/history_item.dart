import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:healyou/healyou/core/models/firebase/nutrition_request.dart';
import 'package:healyou/healyou/core/models/nutrition/nutrition.dart';
import 'package:healyou/healyou/presentations/screens/Nutrition/history_nutrition.dart';
import 'package:healyou/healyou/presentations/screens/Nutrition/widgets/food_item.dart';
import 'package:collection/collection.dart';
import 'package:intl/intl.dart';

class HistoryItem extends StatelessWidget {
  final Nutrition nutrition;
  const HistoryItem({super.key, required this.nutrition});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(nutrition.name),
              content: SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width * 0.8,
                child: ListView.builder(
                  itemCount: nutrition.foodItems?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    Map<String, dynamic> foodItem = nutrition.foodItems?[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Meal: ${foodItem['meal'] ?? ''}'),
                        Text('Calories: ${foodItem['calories'] ?? ''}'),
                      ],
                    );
                  },
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Close'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Text(
              nutrition.name,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              DateFormat('MMMM d, yyyy').format(nutrition.time!),
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
