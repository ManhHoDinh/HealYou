import 'package:dio/dio.dart';

class Generator {
  late List nutritionInput;
  final dio = Dio();
  List ingredients;
  Map<String, dynamic> params;
  Generator(
      {required this.nutritionInput,
      this.ingredients = const [],
      this.params = const {'n_neighbors': 5, 'return_distance': false}});
  Future<Map<String, dynamic>> generate() async {
    Map<String, dynamic> request = {
      'nutrition_input': nutritionInput,
      'ingredients': ingredients,
      'params': params
    };
    var response = await dio.post(
        "https://recommend-dish.onrender.com/predict/",
        data: request);
    return response.data;
  }
}
