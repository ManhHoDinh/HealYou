import 'package:flutter/material.dart';
import 'package:healyou/healyou/core/helper/text_styles.dart';
import 'package:healyou/healyou/core/models/food/food.dart';

class RecommendFoodWidget extends StatelessWidget {
  final FoodModel food;
  final VoidCallback onTap;

  RecommendFoodWidget({required this.food, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.grey.withOpacity(0.5),
          ),
          image: DecorationImage(
            image: NetworkImage(
              food.ImageLink,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: Container()),
            Text(
              "${food.Name}-${food.Weight}",
              style: TextStyles.h6.whiteTextColor,
              textAlign: TextAlign.left,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "${food.Description}",
              style: TextStyles.h6.whiteTextColor.copyWith(fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }
}