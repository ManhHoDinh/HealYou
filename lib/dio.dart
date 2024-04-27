import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:healyou/healyou/core/controller/information_controller.dart';
import 'package:healyou/healyou/core/controller/water_item_controller.dart';

class MyBindings extends Bindings {
  @override
  void dependencies() {
    // Sử dụng Get.lazyPut() thay vì Get.put()

    Get.lazyPut(() => WaterItemController(), fenix: true);
    Get.lazyPut(() => InformationController(), fenix: true);
  }
}
