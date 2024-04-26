import 'package:flutter/material.dart';
import 'package:healyou/healyou/core/helper/firebase_helper.dart';
import 'package:healyou/healyou/presentations/screens/information/weight.dart';

// void main() => runApp(const MyApp());

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: const SafeArea(
//           top: false, // Không thêm padding ở phía trên
//           child: HightSelector(),
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

class HightSelectorScreen extends StatefulWidget {
  const HightSelectorScreen({super.key});
  static const String routeName = 'hight_screen';

  @override
  _HightSelectorState createState() => _HightSelectorState();
}

class _HightSelectorState extends State<HightSelectorScreen> {
  late ScrollController _scrollController;
  int _currentHight = 20;
  final int _minHight = 120;
  final int _maxHight = 240;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController(
      initialScrollOffset: (_currentHight - _minHight) * 60.0,
    );
    _scrollController.addListener(_selectHight);
  }

  void _selectHight() {
    if (_scrollController.hasClients) {
      double center = _scrollController.offset +
          _scrollController.position.viewportDimension / 2;
      int hightIndex = (center / 60).round();
      int newHight = _minHight + hightIndex;
      if (_currentHight != newHight &&
          newHight >= _minHight &&
          newHight <= _maxHight) {
        setState(() {
          _currentHight = newHight;
        });
      }
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_selectHight);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              'Tell us your height',
              style: TextStyle(fontSize: 40, color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 250, // Đặt một chiều cao cố định cho ListView
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: _maxHight - _minHight + 1,
              itemBuilder: (context, index) {
                return Center(
                  child: Container(
                    width: 60,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          (_minHight + index).toString(),
                          style: TextStyle(
                            color: (_minHight + index) == _currentHight
                                ? Colors.blue
                                : Colors.grey,
                            fontSize:
                                (_minHight + index) == _currentHight ? 24 : 16,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: 2,
                          height:
                              (_minHight + index) == _currentHight ? 120 : 70,
                          color: (_minHight + index) == _currentHight
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
                FirebaseHelper.userCollection
                    .doc(FirebaseHelper.userId)
                    .update({"height": _currentHight});
                Navigator.pushNamed(context, WeightSelectorScreen.routeName);
              },
            ),
          ),
        ],
      ),
    );
  }
}
