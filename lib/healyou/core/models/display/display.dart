import 'dart:ui';

class Display {
  late List<String> plan;
  late List<String> activites;
  late List<double> weights;
  late List<double> activityLevels;
  late List<String> losses;

  Display() {
    plan = [
      "Maintain weight",
      "Mild weight loss",
      "Weight loss",
      "Extreme weight loss"
    ];
    activites = [
      'Little/no exercise',
      'Light exercise',
      'Moderate exercise (3-5 days/week)',
      'Very active (6-7 days/week)',
      'Extra active (very active & physical job)'
    ];
    activityLevels = [1.2, 1.375, 1.55, 1.725, 1.9];
    weights = [1, 0.9, 0.8, 0.6];
    losses = ['-0 kg/week', '-0.25 kg/week', '-0.5 kg/week', '-1 kg/week'];
  }
  double getWeightLoss(String option) {
    return weights[plan.indexOf(option)];
  }

  double getActivityLevel(String option) {
    return activityLevels[activites.indexOf(option)];
  }

  Map<String, dynamic> getMealsPerc(int numberOfMeal) {
    if (numberOfMeal == 3) {
      return {'breakfast': 0.35, 'lunch': 0.40, 'dinner': 0.25};
    } else if (numberOfMeal == 4) {
      return {
        'breakfast': 0.30,
        'morning snack': 0.05,
        'lunch': 0.40,
        'dinner': 0.25
      };
    } else {
      return {
        'breakfast': 0.30,
        'morning snack': 0.05,
        'lunch': 0.40,
        'afternoon snack': 0.05,
        'dinner': 0.20
      };
    }
  }
}
