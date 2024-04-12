import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:healyou/healyou/core/constants/color_palatte.dart';
import 'package:healyou/healyou/presentations/screens/Nutrition/widgets/food_item.dart';
import 'package:healyou/healyou/presentations/screens/Nutrition/widgets/food_item.dart';
import 'package:healyou/healyou/presentations/screens/Nutrition/widgets/progress_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Nutrition extends StatefulWidget {
  const Nutrition({super.key});

  @override
  State<Nutrition> createState() => _DateTargetState();
}

Future<String> getNutrition(String query) async {
  final response = await http.get(
    Uri.parse('https://api.api-ninjas.com/v1/nutrition?query=$query'),
    headers: {
      'X-Api-Key': 'lQS1ZgWLB4kX8yIl0uVK2g==8Rj1lVD7eL5NCFH1',
    },
  );

  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to load nutrition');
  }
}

class _DateTargetState extends State<Nutrition> {
  List<Widget> _infoBoxes = [];
  final _formKey = GlobalKey<FormState>();
  int _boxIndex = 0;
  String _title = '';
  int _value = 0;
  String _unit = '';
  int _expandedItemIndex = -1;

  double totalCalories = 0.0;
  double totalProtein = 0.0;
  double totalFat = 0.0;
  final List<FoodItem> _addedFoodItems = [];
  Map<int, List<FoodItem>> _expandedFoodItemsMap = {};
  final List<FoodItem> _foodItems = [];
  @override
  // void initState() {
  //   super.initState();
  //   _infoBoxes.add(_buildInfoBox("Calories", 100, 0, "cal"));
  //   _infoBoxes.add(_buildInfoBox("Protein", 100, 1, "g"));
  //   _infoBoxes.add(_buildInfoBox("Fat", 19, 2, "cal"));
  // }

  bool _isLoading = false;
  List<dynamic> _apiResponseData = [];

  FoodItem? _selectedFoodItem;
  @override
  bool _expanded = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    totalCalories =
        _foodItems.fold(0.0, (sum, item) => sum + double.parse(item.calories));
    totalProtein =
        _foodItems.fold(0.0, (sum, item) => sum + double.parse(item.protein));
    totalFat =
        _foodItems.fold(0.0, (sum, item) => sum + double.parse(item.fat));
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: 20,
          ),

          ProgressWidget(
              percent: 0.2,
              size: width * 7 / 10,
              calories: totalCalories / 100,
              protein: totalProtein,
              fat: totalFat,
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
                            _buildExpandedItems(entry.key),
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
    final TextEditingController _controller = TextEditingController();
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
                                  setState(() {
                                    _title = value!;
                                  });
                                },
                              ),
                              // Text('Calories: $_calories'),
                              // DropdownButtonFormField<FoodItem>(
                              //   decoration:
                              //       InputDecoration(labelText: 'Food List'),
                              //   items: _foodItems.map((FoodItem item) {
                              //     return DropdownMenuItem<FoodItem>(
                              //       value: item,
                              //       child: Text(item.name),
                              //     );
                              //   }).toList(),
                              //   onChanged: (FoodItem? newValue) {
                              //     setState(() {
                              //       _selectedFoodItem = newValue!;
                              //       _calories =
                              //           _selectedFoodItem!.calories as int;
                              //     });
                              //   },
                              // ),
                              TextField(
                                controller: _controller,
                                decoration: InputDecoration(
                                  labelText: 'Search',
                                ),
                                onSubmitted: (value) {
                                  setState(() {
                                    _controller.text = value;
                                  });
                                },
                              ),
                              FutureBuilder<String>(
                                future: getNutrition(_controller.text),
                                builder: (BuildContext context,
                                    AsyncSnapshot<String> snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return CircularProgressIndicator();
                                  } else {
                                    if (snapshot.hasError)
                                      return Text('Error: ${snapshot.error}');
                                    else {
                                      if (snapshot.hasData &&
                                          snapshot.data != null) {
                                        _apiResponseData =
                                            jsonDecode(snapshot.data!);
                                        final data = jsonDecode(snapshot.data!);
                                        if (data.isNotEmpty) {
                                          return ListTile(
                                            leading: Image.asset(
                                                'assets/images/rice.png'),
                                            title: Text(' ${data[0]['name']}'),
                                            subtitle: Text(
                                                ' ${data[0]['calories']} cal'),
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
                                          );
                                        } else {
                                          return Text('No data');
                                        }
                                      } else {
                                        return Text('No data');
                                      }
                                    }
                                  }
                                },
                              ),
                              // _selectedFoodItem != null
                              //     ? ListTile(
                              //         leading: Image.asset(
                              //             _selectedFoodItem!.imageUrl),
                              //         title: Text(_selectedFoodItem!.name),
                              //         subtitle: Text(
                              //             '${_selectedFoodItem!.calories} cal'),
                              //         trailing: Row(
                              //           mainAxisSize: MainAxisSize.min,
                              //           children: [
                              //             IconButton(
                              //               icon: Icon(Icons.edit),
                              //               onPressed: () {
                              //                 // Handle edit action
                              //               },
                              //             ),
                              //             IconButton(
                              //               icon: Icon(Icons.delete),
                              //               onPressed: () {
                              //                 // Handle delete action
                              //               },
                              //             ),
                              //           ],
                              //         ),
                              //       )
                              // : Container(),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Done'),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                setState(() {
                                  _isLoading = true;
                                });
                                getNutrition(_controller.text).then((data) {
                                  if (data != null) {
                                    final apiResponseData = jsonDecode(data);
                                    final newFoodItem = FoodItem(
                                      imageUrl: "assets/images/rice.png",
                                      name: _apiResponseData[0]['name'] ??
                                          'Unknown',
                                      calories:
                                          (_apiResponseData[0]['calories'] ?? 0)
                                              .toString(),
                                      protein: (_apiResponseData[0]
                                                  ['protein_g'] ??
                                              0)
                                          .toString(),
                                      fat: (_apiResponseData[0]
                                                  ['fat_total_g'] ??
                                              0)
                                          .toString(),
                                    );
                                    setState(() {
                                      _foodItems.add(newFoodItem);
                                      _isLoading = false;
                                    });

                                    // setState(() {
                                    //   _addedFoodItems.add(newFoodItem);
                                    //   _isLoading = false;
                                    //   // _infoBoxes.add(_buildInfoBox("Calories", 100, 0, "cal"));
                                    //   _infoBoxes.add(_buildInfoBox(
                                    //       _title,
                                    //       _apiResponseData[0]['calories'],
                                    //       _boxIndex,
                                    //       "cal"));
                                    //   _boxIndex++;
                                    // });
                                    _handleAddFoodItem(newFoodItem);
                                    Navigator.of(context).pop();
                                  }
                                });
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

  void _handleAddFoodItem(FoodItem foodItem) {
    setState(() {
      _addedFoodItems.add(foodItem);
      _expandedFoodItemsMap[_boxIndex] = [foodItem];
      _infoBoxes.add(_buildInfoBox(
          _title, double.parse(foodItem.calories), _boxIndex, "cal"));
      _boxIndex++;
    });
  }

  Widget _buildInfoBox(String title, double value, int index,
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
        if (_expandedItemIndex == index) _buildExpandedItems(index),
      ]),
    );
  }

  void _handleDeleteFoodItem(int index, FoodItem foodItem) {
    setState(() {
      _addedFoodItems.remove(foodItem);
      _expandedFoodItemsMap[index]?.remove(foodItem);
      if (_expandedFoodItemsMap[index]?.isEmpty ?? false) {
        _infoBoxes.removeAt(index);
        _expandedItemIndex = -1;
      }
    });
  }

  void _handleEditFoodItem(int index, FoodItem foodItem) {
    String _editedName = foodItem.name;
    String _editedCalories = foodItem.calories;
    String _editedProtein = foodItem.protein;
    String _editedFat = foodItem.fat;
    final TextEditingController _controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text('Edit item'),
              content: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        initialValue: _editedName,
                        decoration: InputDecoration(labelText: 'Edit Name'),
                        onChanged: (value) {
                          setState(() {
                            _editedName = value;
                          });
                        },
                      ),
                      TextFormField(
                        initialValue: _editedCalories,
                        decoration: InputDecoration(labelText: 'Calories'),
                        onChanged: (value) {
                          setState(() {
                            _editedCalories = value;
                          });
                        },
                      ),
                      TextFormField(
                        initialValue: _editedProtein,
                        decoration: InputDecoration(labelText: 'Protein'),
                        onChanged: (value) {
                          setState(() {
                            _editedProtein = value;
                          });
                        },
                      ),
                      TextFormField(
                        initialValue: _editedFat,
                        decoration: InputDecoration(labelText: 'Fat'),
                        onChanged: (value) {
                          setState(() {
                            _editedFat = value;
                          });
                        },
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          labelText: 'Search',
                        ),
                        onSubmitted: (value) {
                          setState(() {
                            _controller.text = value;
                          });
                        },
                      ),
                      FutureBuilder<String>(
                        future: getNutrition(_controller.text),
                        builder: (BuildContext context,
                            AsyncSnapshot<String> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else {
                            if (snapshot.hasError)
                              return Text('Error: ${snapshot.error}');
                            else {
                              if (snapshot.hasData && snapshot.data != null) {
                                _apiResponseData = jsonDecode(snapshot.data!);
                                final data = jsonDecode(snapshot.data!);
                                return ListTile(
                                  leading:
                                      Image.asset('assets/images/rice.png'),
                                  title: Text(' ${data[0]['name']}'),
                                  subtitle: Text(' ${data[0]['calories']} cal'),
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
                                );
                              } else {
                                return Text('No data');
                              }
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Save'),
                  onPressed: () {
                    final editedFoodItem = FoodItem(
                      imageUrl: foodItem.imageUrl,
                      name: _editedName,
                      calories: _editedCalories,
                      protein: _editedProtein,
                      fat: _editedFat,
                    );

                    setState(() {
                      _addedFoodItems.removeAt(index);
                      _addedFoodItems.insert(index, editedFoodItem);
                    });
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    // Đóng dialog khi bấm Cancel
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildExpandedItems(int index) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(_expanded ? 0 : 0),
        topRight: Radius.circular(_expanded ? 0 : 0),
      ),
      child: Column(
        children: (_expandedFoodItemsMap[index] ?? []).map((foodItem) {
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
                      _handleEditFoodItem(index, foodItem);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _handleDeleteFoodItem(index, foodItem);
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
