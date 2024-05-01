import 'package:get/get.dart';

class InformationController extends GetxController {
  RxInt age = 0.obs;
  RxInt weight = 0.obs;
  RxInt height = 0.obs;
  RxString gender = "".obs;
  void updateAge(int value) {
    age.value = value;
  }

  void updateWeight(int value) {
    weight.value = value;
  }

  void updateHeight(int value) {
    height.value = value;
  }

  void updateGender(String value) {
    gender.value = value;
  }
}
