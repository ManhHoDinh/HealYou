import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:healyou/healyou/core/constants/color_palatte.dart';
import 'package:healyou/healyou/presentations/screens/Nutrition/tab/food_item.dart';
import 'package:healyou/healyou/presentations/screens/Nutrition/tab/food_item.dart';
import 'package:healyou/healyou/presentations/screens/Nutrition/widgets/progress_widget.dart';

class DateTarget extends StatefulWidget {
  const DateTarget({super.key});

  @override
  State<DateTarget> createState() => _DateTargetState();
}

class _DateTargetState extends State<DateTarget> {
  List<Widget> _infoBoxes = [];
  final _formKey = GlobalKey<FormState>();
  int _boxIndex = 3;
  String _title = '';
  int _value = 0;
  String _unit = '';
  int _expandedItemIndex = -1;
  List<FoodItem> _foodItems = [
    FoodItem(
      imageUrl: "assets/images/rice.png",
      name: "Rice",
      calories: 200,
    ),
    FoodItem(
      imageUrl: "assets/images/rice.png",
      name: "Rau",
      calories: 100,
    ),

    // Add more FoodItems here
  ];
  FoodItem? _selectedFoodItem;
  @override
  void initState() {
    super.initState();
    _infoBoxes.add(_buildInfoBox("Calories", 100, 0, "cal"));
    _infoBoxes.add(_buildInfoBox("Protein", 100, 1, "g"));
    _infoBoxes.add(_buildInfoBox("Fat", 19, 2, "cal"));
  }

  bool _expanded = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: 20,
          ),
          ProgressWidget(
              size: width * 7 / 10,
              value: 0.2,
              child: Column(
                mainAxisSize: MainAxisSize.min,
              )),
          SizedBox(
            height: 20,
          ),
          // _buildInfoBox("Calories", calo, "cal"),
          // _expanded ? _buildExpandedItems() : Container(),
          // SizedBox(
          //   height: 20,
          // ),
          // _buildInfoBox("Protein", protein, "g"),
          // _expanded ? _buildExpandedItems() : Container(),
          SizedBox(
            height: 20,
          ),
          Column(
            children: _infoBoxes
                .asMap()
                .entries
                .map((entry) => Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Column(
                        children: [
                          entry.value,
                          if (_expandedItemIndex == entry.key)
                            _buildExpandedItems(),
                        ],
                      ),
                    ))
                .toList(),
          ),
          // _buildInfoBox("Pat", fat, "cal"),

          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 20,
          ),
          _buildAddBox(),
        ]),
      ),
    );
  }

  Widget _buildAddBox() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color(0xffEFF0FF),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _selectedFoodItem = null;
              showDialog(
                context: context,
                builder: (context) {
                  return StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      String _title = '';

                      int _calories = 0;
                      return AlertDialog(
                        title: Text('Add new item'),
                        content: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                decoration:
                                    InputDecoration(labelText: 'Edit Name'),
                                onSaved: (value) {
                                  _title = value!;
                                },
                              ),
                              // Text('Calories: $_calories'),
                              DropdownButtonFormField<FoodItem>(
                                decoration:
                                    InputDecoration(labelText: 'Food List'),
                                items: _foodItems.map((FoodItem item) {
                                  return DropdownMenuItem<FoodItem>(
                                    value: item,
                                    child: Text(item.name),
                                  );
                                }).toList(),
                                onChanged: (FoodItem? newValue) {
                                  setState(() {
                                    _selectedFoodItem = newValue!;
                                    _calories =
                                        _selectedFoodItem!.calories as int;
                                  });
                                },
                              ),
                              _selectedFoodItem != null
                                  ? ListTile(
                                      leading: Image.asset(
                                          _selectedFoodItem!.imageUrl),
                                      title: Text(_selectedFoodItem!.name),
                                      subtitle: Text(
                                          '${_selectedFoodItem!.calories} cal'),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            icon: Icon(Icons.edit),
                                            onPressed: () {
                                              // Handle edit action
                                            },
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.delete),
                                            onPressed: () {
                                              // Handle delete action
                                            },
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Done'),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                final newFoodItem = FoodItem(
                                  imageUrl: "assets/images/rice.png",
                                  name: _title,
                                  calories: _calories,
                                );
                                setState(() {
                                  _infoBoxes.add(_buildInfoBox(
                                      _title, _calories, _boxIndex, "cal"));
                                  _boxIndex++;
                                });
                                Navigator.of(context).pop();
                              }
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              );
            },
          ),
          Text(
            'Add meal',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBox(String title, int value, int index,
      [String unit = 'cal']) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xffEFF0FF),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(
              _expanded || _expandedItemIndex == index ? 0 : 10),
          bottomRight: Radius.circular(
              _expanded || _expandedItemIndex == index ? 0 : 10),
        ),
      ),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(
          height: 40,
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "$title: $value",
                          style: TextStyle(
                            color: ColorPalette.primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: unit,
                          style: TextStyle(
                            color: ColorPalette.primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _expanded = !_expanded;
                    _expandedItemIndex =
                        _expandedItemIndex == index ? -1 : index;
                  });
                  print('Expanded state: $_expanded');
                },
                child: Image.asset(
                  "assets/images/arrow.png",
                  width: 50,
                  height: 50,
                ),
              ),
            ],
          ),
        ),
        if (_expandedItemIndex == index) _buildExpandedItems(),
      ]),
    );
  }

  Widget _buildExpandedItems() {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(_expanded ? 0 : 0),
        topRight: Radius.circular(_expanded ? 0 : 0),
      ),
      child: Column(
        children: _foodItems.map((foodItem) {
          return Container(
            color: Color(0xffEFF0FF),
            padding: EdgeInsets.only(top: 5),
            child: ListTile(
              leading: Image.asset(foodItem.imageUrl),
              title: Text(foodItem.name),
              subtitle: Text('${foodItem.calories} cal'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      // Handle edit action
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      // Handle delete action
                    },
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
