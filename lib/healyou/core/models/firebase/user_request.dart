import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healyou/healyou/core/helper/firebase_helper.dart';
import 'package:healyou/healyou/core/models/user/user.dart';

class UserRequest {
  static Stream<UserModel?> getById(String id) {
    StreamController<UserModel?> controller = StreamController<UserModel?>();

    // Get the document by its ID
    FirebaseHelper.userCollection.doc(id).snapshots().listen(
        (DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        // Document found, parse data and add to the stream
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        UserModel user = UserModel.fromJson(data);
        controller.add(user);
      } else {
        // Document does not exist, add null to the stream
        controller.add(null);
      }
    }, onError: (error) {
      // Handle any errors
      controller.addError(error);
    });

    // Return the stream from the StreamController
    return controller.stream;
  }
}
