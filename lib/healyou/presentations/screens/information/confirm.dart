import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: ReviewInformationScreen(),
      ),
    );
  }
}

class ReviewInformationScreen extends StatelessWidget {
  const ReviewInformationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 100.0),
              child: Text(
                'HealYou',
                style: TextStyle(fontSize: 20, color: Colors.blue),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(70.0),
              child: Text(
                'Review Your Information',
                style: TextStyle(fontSize: 40, color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 8),
            InfoCard(
              title: 'WEIGHT',
              value: '58',
              onTap: () {
                navigateToEditScreen(context, 'WEIGHT');
              },
            ),
            const SizedBox(height: 8),
            InfoCard(
              title: 'HEIGHT',
              value: '170',
              onTap: () {
                navigateToEditScreen(context, 'HEIGHT');
              },
            ),
            const SizedBox(height: 8),
            InfoCard(
              title: 'AGE',
              value: '25',
              onTap: () {
                navigateToEditScreen(context, 'AGE');
              },
            ),
            const SizedBox(height: 8),
            InfoCard(
              title: 'GENDER',
              value: 'MALE',
              onTap: () {
                navigateToEditScreen(context, 'GENDER');
              },
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Add event handling for the Confirm button
                },
                child: const Text('Confirm'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
            ),
          ],
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
