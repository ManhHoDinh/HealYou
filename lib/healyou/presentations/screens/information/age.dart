import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: AgeSelector(),
      ),
    );
  }
}

class AgeSelector extends StatefulWidget {
  @override
  _AgeSelectorState createState() => _AgeSelectorState();
}

class _AgeSelectorState extends State<AgeSelector> {
  late ScrollController _scrollController;
  int _currentAge = 58;
  final int _minAge = 30;
  final int _maxAge = 100;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController(
      initialScrollOffset: (28 *
          60.0), // Set the initial offset to show the current age in the center
    );
    _scrollController.addListener(_selectAge);
  }

  void _selectAge() {
    double center = _scrollController.position.pixels +
        _scrollController.position.viewportDimension / 2;
    int ageIndex = (center / 60).round();
    int newAge = _minAge + ageIndex;

    if (_currentAge != newAge && newAge >= _minAge && newAge <= _maxAge) {
      setState(() {
        _currentAge = newAge;
      });
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(top: 100.0),
          child: Text(
            'HealYou',
            style: TextStyle(
              fontSize: 20,
              color: Colors.blue,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 50.0),
          child: Text(
            'Tell us your age',
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
                _selectAge();
              }
              return true;
            },
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
                        SizedBox(height: 10),
                        Container(
                          width: 2,
                          height: (_minAge + index) == _currentAge ? 100 : 50,
                          color: (_minAge + index) == _currentAge
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
        // Padding(
        //   padding: const EdgeInsets.only(bottom: 60.0),
        //   child: Text(
        //     'Selected age: $_currentAge kg',
        //     style: TextStyle(
        //       fontSize: 22,
        //       fontAge: FontAge.bold,
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
