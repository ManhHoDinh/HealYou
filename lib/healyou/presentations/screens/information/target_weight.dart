import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healyou/healyou/core/controller/information_controller.dart';
import 'package:healyou/healyou/core/helper/firebase_helper.dart';
import 'package:healyou/healyou/presentations/screens/information/confirm.dart';
import 'package:healyou/healyou/presentations/screens/information/goal_screen.dart';

class TargetWeightScreen extends StatefulWidget {
  const TargetWeightScreen({super.key});
  static const String routeName = 'weight_screen';

  @override
  State<TargetWeightScreen> createState() => _TargetWeightScreenState();
}

class _TargetWeightScreenState extends State<TargetWeightScreen> {
  late ScrollController _scrollController;
  int _currentWeight = 60;
  final int _minWeight = 20;
  final int _maxWeight = 100;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController(
      initialScrollOffset: (_currentWeight - _minWeight) * 60.0,
    );
    _scrollController.addListener(_selectWeight);
  }

  void _selectWeight() {
    if (_scrollController.hasClients) {
      double center = _scrollController.offset +
          _scrollController.position.viewportDimension / 2;
      int weightIndex = (center / 60).round();
      int newWeight = _minWeight + weightIndex;
      if (_currentWeight != newWeight &&
          newWeight >= _minWeight &&
          newWeight <= _maxWeight) {
        setState(() {
          _currentWeight = newWeight;
        });
      }
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_selectWeight);
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
              'Tell us your target weight',
              style: TextStyle(fontSize: 32, color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 250, // Đặt một chiều cao cố định cho ListView
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: _maxWeight - _minWeight + 1,
              itemBuilder: (context, index) {
                return Center(
                  child: Container(
                    width: 60,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          (_minWeight + index).toString(),
                          style: TextStyle(
                            color: (_minWeight + index) == _currentWeight
                                ? Colors.blue
                                : Colors.grey,
                            fontSize: (_minWeight + index) == _currentWeight
                                ? 24
                                : 16,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: 2,
                          height:
                              (_minWeight + index) == _currentWeight ? 120 : 70,
                          color: (_minWeight + index) == _currentWeight
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
                informationController.updateTargetWeight(_currentWeight);
                Get.to(() => GoalScreen());
              },
            ),
          ),
        ],
      ),
    );
  }
}
