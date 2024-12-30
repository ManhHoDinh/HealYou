import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healyou/healyou/core/constants/color_palatte.dart';
import 'package:healyou/healyou/core/controller/information_controller.dart';
import 'package:healyou/healyou/presentations/screens/information/confirm.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  List<String> goals = [
    "Little/no exercise",
    "Light exercise",
    "Moderate exercise (3-5 days/week)",
    "Very active (6-7 days/week)",
    "Extra active (very active day & physical job)"
  ];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    InformationController informationController = Get.find();
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          children: [
            Text(
              'What is your activity level?',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
            ),
            SizedBox(
              height: 40,
            ),
            ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => ElevatedButton(
                      onPressed: () {
                        informationController.updateActivity(goals[index]);
                        Get.to(() => ReviewInformationScreen());
                      },
                      style: ButtonStyle(
                        padding: WidgetStateProperty.all<EdgeInsets>(
                          EdgeInsets.symmetric(
                              vertical: 30,
                              horizontal: 40), // Adjust padding as needed
                        ),
                        backgroundColor:
                            WidgetStateProperty.all<Color>(Colors.white),
                        shape:
                            WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                      ),
                      child: Text(
                        goals[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                separatorBuilder: (context, index) => SizedBox(
                      height: 30,
                    ),
                itemCount: goals.length)
          ],
        ),
      ),
    );
  }
}
