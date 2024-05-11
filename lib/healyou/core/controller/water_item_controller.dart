import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:healyou/healyou/core/models/firebase/water_item_request.dart';
import 'package:healyou/healyou/core/models/waterTargetItem/water_target_item.dart';

class WaterItemController extends GetxController {
  RxList<WaterTargetItem> listItems = <WaterTargetItem>[].obs;

  void updateItems() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    listItems.value = await WaterItemRequest.getAll(userId);
  }
}
