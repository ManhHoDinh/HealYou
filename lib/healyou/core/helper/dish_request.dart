import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:healyou/healyou/core/controller/recommend_controller.dart';
import 'package:healyou/healyou/core/models/dish/dish.dart';
import 'package:healyou/healyou/core/models/firebase/user_request.dart';
import 'package:healyou/healyou/core/models/user/user.dart';

class DishRequest {
  static Future<List<Dish>> getDishes() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    UserModel? user = await UserRequest.getById(userId).first;
    List res = await RecommendController.generateRecommendations(user!);
    List<Dish> dishes = [];
    res[0].forEach((e) {
      Dish dish = Dish.fromJson(e);
      dishes.add(dish);
    });

    return dishes;
  }
}
