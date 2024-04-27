import 'package:get/get.dart';
import 'package:healyou/healyou/core/models/firebase/water_item_request.dart';
import 'package:healyou/healyou/core/models/waterTargetItem/water_target_item.dart';

class WaterItemController extends GetxController {
  RxList<WaterTargetItem> listItems = <WaterTargetItem>[].obs;

  void updateItems() async {
    listItems.value = await WaterItemRequest.getAll().first;
  }
}
