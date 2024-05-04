import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healyou/healyou/core/controller/information_controller.dart';
import 'package:healyou/healyou/core/helper/firebase_helper.dart';
import 'package:healyou/healyou/core/models/firebase/target_request.dart';
import 'package:healyou/healyou/core/models/firebase/user_request.dart';
import 'package:healyou/healyou/core/models/user/user.dart';
import 'package:healyou/healyou/presentations/screens/Home/navigation_home.dart';

class ReviewInformationScreen extends StatelessWidget {
  const ReviewInformationScreen({Key? key}) : super(key: key);
  static const String routeName = 'review_screen';

  @override
  Widget build(BuildContext context) {
    InformationController informationController = Get.find();
    String userId = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Obx(() {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.all(70.0),
                    child: Text(
                      'Review Your Information',
                      style: TextStyle(fontSize: 32, color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 8),
                  InfoCard(
                    title: 'WEIGHT',
                    value: informationController.weight.value.toString(),
                    onTap: () {
                      navigateToEditScreen(context, 'WEIGHT');
                    },
                  ),
                  const SizedBox(height: 8),
                  InfoCard(
                    title: 'HEIGHT',
                    value: informationController.height.value.toString(),
                    onTap: () {
                      navigateToEditScreen(context, 'HEIGHT');
                    },
                  ),
                  const SizedBox(height: 8),
                  InfoCard(
                    title: 'AGE',
                    value: informationController.age.value.toString(),
                    onTap: () {
                      navigateToEditScreen(context, 'AGE');
                    },
                  ),
                  const SizedBox(height: 8),
                  InfoCard(
                    title: 'GENDER',
                    value: informationController.gender.value,
                    onTap: () {
                      navigateToEditScreen(context, 'GENDER');
                    },
                  ),
                  const SizedBox(height: 8),
                  InfoCard(
                    title: 'TARGET WEIGHT',
                    value: informationController.targetWeight.value.toString(),
                    onTap: () {
                      navigateToEditScreen(context, 'TARGET_WEIGHT');
                    },
                  ),
                  const SizedBox(height: 8),
                  // InfoCard(
                  //   title: 'ACTIVITY LEVEL',
                  //   value: informationController.activity.value.toString(),
                  //   onTap: () {
                  //     navigateToEditScreen(context, 'TARGET_WEIGHT');
                  //   },
                  // ),
                  const SizedBox(height: 8),
                  InfoCard(
                    title: 'WEIGHT LOSS',
                    value: informationController.weightLoss.value.toString(),
                    onTap: () {
                      navigateToEditScreen(context, 'TARGET_WEIGHT');
                    },
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        List activityValue = [1.2, 1.375, 1.55, 1.725, 1.9];
                        List goalValue = [1, 0.9, 0.8, 0.6];
                        List<String> activities = [
                          "Little/no exercise",
                          "Light exercise",
                          "Moderate exercise (3-5 days/week)",
                          "Very active (6-7 days/week)",
                          "Extra active (very active day & physical job)"
                        ];
                        List<String> goals = [
                          "Maintain weight",
                          "Mild weight loss",
                          "Weight loss",
                          "Extreme weight loss"
                        ];
                        print(informationController.activity.value);
                        print(informationController.weightLoss.value);
                        FirebaseHelper.userCollection.doc(userId).update({
                          "age": informationController.age.value,
                          "height": informationController.height.value,
                          "weight": informationController.weight.value,
                          "gender": informationController.gender.value,
                          "activity": activityValue[activities
                              .indexOf(informationController.activity.value)],
                          "weightLoss": goalValue[goals
                              .indexOf(informationController.weightLoss.value)],
                          "targetWeight":
                              informationController.targetWeight.value
                        });
                        await TargetRequest.autoAddRunTarget();
                        Get.to(() => NavigationHome());
                      },
                      child: const Text('Confirm'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  void navigateToEditScreen(BuildContext context, String infoType) {
    // Depending on the type of information, navigate to the respective screen
    Widget screen;
    switch (infoType) {
      // case 'WEIGHT':
      //   screen = const EditWeightScreen();
      //   break;
      // case 'HEIGHT':
      //   screen = const EditHeightScreen();
      //   break;
      // case 'AGE':
      //   screen = const EditAgeScreen();
      //   break;
      // case 'GENDER':
      //   screen = const EditGenderScreen();
      //   break;
      default:
        return;
    }

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => screen),
    // );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String value;
  final VoidCallback? onTap;

  const InfoCard({
    Key? key,
    required this.title,
    required this.value,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    InformationController informationController = Get.find();
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
            Row(
              children: [
                Text(
                  value,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w400),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.edit, size: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
