import 'dart:convert';
import 'dart:math';
import 'dart:ui';
import 'package:healyou/healyou/core/models/display/display.dart';
import 'package:healyou/healyou/core/models/generator/generator.dart';
import 'package:healyou/healyou/core/models/imageFinder/image_finder.dart';
import 'package:healyou/healyou/core/models/user/user.dart';

class RecommendController {
  static double caloriesCalculator(UserModel user) {
    List<String> activites = [
      'Little/no exercise',
      'Light exercise',
      'Moderate exercise (3-5 days/week)',
      'Very active (6-7 days/week)',
      'Extra active (very active & physical job)'
    ];
    print(user);
    List<double> weights = [1.2, 1.375, 1.55, 1.725, 1.9];
    double weight = weights[activites.indexOf(user.activity)];
    print("weight: $weight");
    double maintain_calories = calculateBmr(user) * weight;
    return maintain_calories;
  }

  static double calculateBmr(UserModel user) {
    double bmr;
    if (user.gender == 'male') {
      bmr = 10 * user.weight + 6.25 * user.height - 5 * user.age + 5;
    } else {
      bmr = 10 * user.weight + 6.25 * user.height - 5 * user.age - 161;
    }
    print(bmr);
    return bmr;
  }

  //random
  static double rnd(double min, double max) {
    return min + Random().nextDouble() * (max - min);
  }

  static Future<dynamic> generateRecommendations(UserModel user) async {
    Display display = Display();
    double totalCalories =
        display.getWeightLoss(user.weightLoss) * caloriesCalculator(user);
    print(totalCalories);
    List recommendations = [];
    Map<String, dynamic> mealsCaloriesPerc =
        display.getMealsPerc(user.mealPerDay);

    for (String meal in mealsCaloriesPerc.keys) {
      double mealCalories = mealsCaloriesPerc[meal].toDouble() * totalCalories;

      List recommendedNutrition;
      if (meal == 'breakfast') {
        recommendedNutrition = [
          mealCalories,
          rnd(10, 30),
          rnd(0, 4),
          rnd(0, 30),
          rnd(0, 400),
          rnd(40, 75),
          rnd(4, 10),
          rnd(0, 10),
          rnd(30, 100)
        ];
      } else if (meal == 'lunch') {
        recommendedNutrition = [
          mealCalories,
          rnd(20, 40),
          rnd(0, 4),
          rnd(0, 30),
          rnd(0, 400),
          rnd(40, 75),
          rnd(4, 20),
          rnd(0, 10),
          rnd(50, 175)
        ];
      } else if (meal == 'dinner') {
        recommendedNutrition = [
          mealCalories,
          rnd(20, 40),
          rnd(0, 4),
          rnd(0, 30),
          rnd(0, 400),
          rnd(40, 75),
          rnd(4, 20),
          rnd(0, 10),
          rnd(50, 175)
        ];
      } else {
        recommendedNutrition = [
          mealCalories,
          rnd(10, 30),
          rnd(0, 4),
          rnd(0, 30),
          rnd(0, 400),
          rnd(40, 75),
          rnd(4, 10),
          rnd(0, 10),
          rnd(30, 100)
        ];
      }
      Generator generator = Generator(nutritionInput: recommendedNutrition);
      var recommended_recipes = (await generator.generate())["output"];
      recommendations.add(recommended_recipes);
    }

    for (var recommendation in recommendations) {
      for (var recipe in recommendation) {
        recipe['image_link'] = await ImageFinder.getImagesLinks(recipe['Name']);
      }
    }
    return recommendations;
  }
}
