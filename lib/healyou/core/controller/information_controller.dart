import 'package:get/get.dart';

class InformationController extends GetxController {
  RxInt age = 0.obs;
  RxInt weight = 0.obs;
  RxInt height = 0.obs;
  RxString gender = "".obs;
  RxString weightLoss = "".obs;
  RxInt targetWeight = 0.obs;
  RxString activity = "".obs;
  void updateAge(int value) {
    age.value = value;
  }

  void updateWeight(int value) {
    weight.value = value;
  }

  void updateTargetWeight(int value) {
    targetWeight.value = value;
  }

  void updateHeight(int value) {
    height.value = value;
  }

  void updateGender(String value) {
    gender.value = value;
  }

  void updateWeightLoss(String value) {
    weightLoss.value = value;
  }

  void updateActivity(String value) {
    activity.value = value;
  }
}
