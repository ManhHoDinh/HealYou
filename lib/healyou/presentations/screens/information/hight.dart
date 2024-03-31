import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: HightSelector(),
      ),
    );
  }
}

class HightSelector extends StatefulWidget {
  @override
  _HightSelectorState createState() => _HightSelectorState();
}

class _HightSelectorState extends State<HightSelector> {
  late ScrollController _scrollController;
  int _currentHight = 58;
  final int _minHight = 30;
  final int _maxHight = 100;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController(
      initialScrollOffset: (28 *
          60.0), // Set the initial offset to show the current hight in the center
    );
    _scrollController.addListener(_selectHight);
  }

  void _selectHight() {
    double center = _scrollController.position.pixels +
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

  @override
  void dispose() {
    _scrollController.removeListener(_selectHight);
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
            'Tell us your hight',
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
                _selectHight();
              }
              return true;
            },
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
                              (_minHight + index) == _currentHight ? 100 : 50,
                          color: (_minHight + index) == _currentHight
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
        //     'Selected hight: $_currentHight kg',
        //     style: TextStyle(
        //       fontSize: 22,
        //       fontHight: FontHight.bold,
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
