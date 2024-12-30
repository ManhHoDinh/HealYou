import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healyou/healyou/core/controller/information_controller.dart';
import 'package:healyou/healyou/presentations/screens/information/age.dart';

class GenderSelectorScreen extends StatefulWidget {
  const GenderSelectorScreen({super.key});
  static const String routeName = 'gender_screen';

  @override
  _GenderSelectorState createState() => _GenderSelectorState();
}

class _GenderSelectorState extends State<GenderSelectorScreen> {
  bool isMaleSelected = false;
  bool isFemaleSelected = false;

  @override
  Widget build(BuildContext context) {
    InformationController informationController = Get.find();

    return Scaffold(
      body: Column(
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
              'Tell us your gender',
              style: TextStyle(
                fontSize: 32,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: GenderOption(
                    gender: 'Male',
                    icon: Icons.male,
                    isSelected: isMaleSelected,
                    onSelect: () {
                      setState(() {
                        isMaleSelected = true;
                        isFemaleSelected = false;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 10), // For spacing between the buttons
                Expanded(
                  child: GenderOption(
                    gender: 'Female',
                    icon: Icons.female,
                    isSelected: isFemaleSelected,
                    onSelect: () {
                      setState(() {
                        isMaleSelected = false;
                        isFemaleSelected = true;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 60.0), // Adjust the padding as needed
            child: FloatingActionButton(
              child: const Icon(Icons.arrow_forward),
              onPressed: () {
                informationController
                    .updateGender(isMaleSelected ? "male" : "female");
                Navigator.pushNamed(context, AgeSelectorScreen.routeName);
              },
            ),
          ),
          // Add other widgets if necessary
        ],
      ),
    );
  }
}

class GenderOption extends StatelessWidget {
  final String gender;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onSelect;

  const GenderOption({
    Key? key,
    required this.gender,
    required this.icon,
    required this.isSelected,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelect,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        padding: const EdgeInsets.all(50.0),
        decoration: BoxDecoration(
          color: isSelected ? Colors.orange.shade100 : Colors.transparent,
          border: Border.all(
            color: isSelected ? Colors.orange : Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, color: isSelected ? Colors.orange : Colors.grey),
            Text(
              gender,
              style: TextStyle(
                color: isSelected ? Colors.orange : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
