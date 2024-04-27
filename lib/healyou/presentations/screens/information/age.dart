import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healyou/healyou/core/controller/information_controller.dart';
import 'package:healyou/healyou/core/helper/firebase_helper.dart';
import 'package:healyou/healyou/presentations/screens/information/hight.dart';

// void main() => runApp(const MyApp());

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: const SafeArea(
//           top: false, // Không thêm padding ở phía trên
//           child: AgeSelector(),
//         ),
//         floatingActionButton: Padding(
//           padding: const EdgeInsets.all(75.0),
//           child: FloatingActionButton(
//             child: const Icon(Icons.arrow_forward),
//             onPressed: () {},
//           ),
//         ),
//         floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       ),
//     );
//   }
// }

class AgeSelectorScreen extends StatefulWidget {
  const AgeSelectorScreen({super.key});
  static const String routeName = 'age_screen';
  @override
  _AgeSelectorState createState() => _AgeSelectorState();
}

class _AgeSelectorState extends State<AgeSelectorScreen> {
  late ScrollController _scrollController;
  int _currentAge = 20;
  final int _minAge = 20;
  final int _maxAge = 100;
  String userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController(
      initialScrollOffset: (_currentAge - _minAge) * 60.0,
    );
    _scrollController.addListener(_selectAge);
  }

  void _selectAge() {
    if (_scrollController.hasClients) {
      double center = _scrollController.offset +
          _scrollController.position.viewportDimension / 2;
      int ageIndex = (center / 60).round();
      int newAge = _minAge + ageIndex;
      if (_currentAge != newAge && newAge >= _minAge && newAge <= _maxAge) {
        setState(() {
          _currentAge = newAge;
        });
      }
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_selectAge);
    _scrollController.dispose();
    super.dispose();
  }

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
              'Tell us your age',
              style: TextStyle(fontSize: 40, color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 250, // Đặt một chiều cao cố định cho ListView
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: _maxAge - _minAge + 1,
              itemBuilder: (context, index) {
                return Center(
                  child: Container(
                    width: 60,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          (_minAge + index).toString(),
                          style: TextStyle(
                            color: (_minAge + index) == _currentAge
                                ? Colors.blue
                                : Colors.grey,
                            fontSize:
                                (_minAge + index) == _currentAge ? 24 : 16,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: 2,
                          height: (_minAge + index) == _currentAge ? 120 : 70,
                          color: (_minAge + index) == _currentAge
                              ? Colors.blue
                              : Colors.grey,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 60.0), // Adjust the padding as needed
            child: FloatingActionButton(
              child: const Icon(Icons.arrow_forward),
              onPressed: () {
                informationController.updateAge(_currentAge);
                Navigator.pushNamed(context, HightSelectorScreen.routeName);
              },
            ),
          ),
        ],
      ),
    );
  }
}
