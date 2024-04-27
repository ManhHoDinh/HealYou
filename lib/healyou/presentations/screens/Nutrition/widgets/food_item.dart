import 'package:flutter/material.dart';

class FoodItem extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String calories;
  final String protein;
  final String fat;
  FoodItem(
      {required this.imageUrl,
      required this.name,
      required this.calories,
      required this.protein,
      required this.fat});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          Image.network(imageUrl, width: 50, height: 50),
          SizedBox(width: 10),
          Spacer(),
          Text('$calories cal', style: TextStyle(fontSize: 16)),
          SizedBox(width: 10),
        ],
      ),
    );
  }
}
