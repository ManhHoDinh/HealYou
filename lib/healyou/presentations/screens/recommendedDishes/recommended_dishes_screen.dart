import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:healyou/healyou/core/helper/dish_request.dart';
import 'package:healyou/healyou/core/models/dish/dish.dart';
import 'package:healyou/healyou/presentations/screens/recommendedDishes/detail_dish_screen.dart';
import 'package:healyou/healyou/presentations/screens/recommendedDishes/widgets/recommended_dish_item.dart';

class RecommendedDishesScreen extends StatefulWidget {
  const RecommendedDishesScreen({super.key});

  @override
  State<RecommendedDishesScreen> createState() =>
      _RecommendedDishesScreenState();
}

class _RecommendedDishesScreenState extends State<RecommendedDishesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Recommended Dishes',
            style: TextStyle(fontSize: 24),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(16),
          child: FutureBuilder<List<Dish>>(
              future: DishRequest.getDishes(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.separated(
                      itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              Get.to(() => DetailFoodScreen(
                                    dish: snapshot.data![index],
                                  ));
                            },
                            child: RecommendedDishItem(
                              dish: snapshot.data![index],
                            ),
                          ),
                      separatorBuilder: (context, index) => SizedBox(
                            height: 20,
                          ),
                      itemCount: snapshot.data!.length);
                }
                return Container();
              }),
        ));
  }
}
