import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weight Selector',
      home: Scaffold(
        body: WeightSelector(),
      ),
    );
  }
}

class WeightSelector extends StatefulWidget {
  @override
  _WeightSelectorState createState() => _WeightSelectorState();
}

class _WeightSelectorState extends State<WeightSelector> {
  late ScrollController _scrollController;
  int _currentWeight = 58;
  final int _minWeight = 30;
  final int _maxWeight = 100;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController(
      initialScrollOffset: (28 *
          60.0), // Set the initial offset to show the current weight in the center
    );
    _scrollController.addListener(_selectWeight);
  }

  void _selectWeight() {
    double center = _scrollController.position.pixels +
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

  @override
  void dispose() {
    _scrollController.removeListener(_selectWeight);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
              top: 100.0), // Thêm padding 8.0 điểm ảnh vào tất cả các cạnh
          child: Text(
            'HealYou',
            style: TextStyle(
              fontSize: 20,
              color: Colors.blue,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: 50.0), // Thêm padding 8.0 điểm ảnh vào tất cả các cạnh
          child: Text(
            'Tell us your weight',
            style: TextStyle(
              fontSize: 40,
              color: Colors.black,
            ),
          ),
        ),
        Expanded(
          child: NotificationListener<ScrollNotification>(
            onNotification: (scrollNotification) {
              if (scrollNotification is ScrollEndNotification) {
                _selectWeight();
              }
              return true;
            },
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
                        SizedBox(height: 10),
                        Container(
                          width: 2,
                          height:
                              (_minWeight + index) == _currentWeight ? 100 : 50,
                          color: (_minWeight + index) == _currentWeight
                              ? Colors.black
                              : Colors.grey,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 60.0),
          child: Text(
            'Selected weight: $_currentWeight kg',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
