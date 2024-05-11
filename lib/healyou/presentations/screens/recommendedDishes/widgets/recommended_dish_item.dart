import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:healyou/healyou/core/models/dish/dish.dart';

class RecommendedDishItem extends StatelessWidget {
  final Dish dish;
  const RecommendedDishItem({super.key, required this.dish});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(dish.imageLink), fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(16)),
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                dish.Name,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                dish.RecipeInstructions[0],
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        )
      ],
    );
  }
}
