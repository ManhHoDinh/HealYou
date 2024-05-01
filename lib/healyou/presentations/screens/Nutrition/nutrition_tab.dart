import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:healyou/healyou/core/constants/color_palatte.dart';
import 'package:healyou/healyou/core/models/nutrition/nutrition.dart';
import 'package:healyou/healyou/presentations/screens/Nutrition/history_nutrition.dart';
import 'package:healyou/healyou/presentations/screens/Nutrition/widgets/food_item.dart';
import 'package:healyou/healyou/presentations/screens/Nutrition/widgets/food_item.dart';
import 'package:healyou/healyou/presentations/screens/Nutrition/widgets/progress_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NutritionSreen extends StatefulWidget {
  const NutritionSreen({super.key});

  @override
  State<NutritionSreen> createState() => _DateTargetState();
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

class _DateTargetState extends State<NutritionSreen> {
  List<Widget> _infoBoxes = [];
  final _formKey = GlobalKey<FormState>();
  int _boxIndex = 0;
  String _title = '';
  int _value = 0;
  String _unit = '';
  int _expandedItemIndex = -1;
  User? currentUser = FirebaseAuth.instance.currentUser;
  double totalCalories = 0.0;
  double totalProtein = 0.0;
  double totalFat = 0.0;
  final List<FoodItem> _addedFoodItems = [];
  Map<int, List<FoodItem>> _expandedFoodItemsMap = {};
  final List<FoodItem> _foodItems = [];
  @override
  late DateTime _lastFetchDate;
  List<Widget> infoBoxes = [];

  Future<void> fetchData() async {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('nutrition')
        .where('time', isGreaterThanOrEqualTo: today)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      querySnapshot.docs.forEach((document) {
        var data = document.data();
        String name = (data as Map<String, dynamic>)['name'] ?? 'default';
        double calories = double.parse(data['calories']);
        String id = document.id;
        Widget infoBox = _buildInfoBox(name, calories, id);

        // Add the infoBox to the list
        infoBoxes.add(infoBox);
      });

      // Call setState to update the UI
      setState(() {});
    } else {
      print('No data found');
    }
  }

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
          SizedBox(
            height: 20,
          ),
          _buildHistory(),
        ]),
      ),
    );
  }

  Widget _buildHistory() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color(0xffEFF0FF),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          ElevatedButton(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(Icons.add),
                Text('History Meal',
                    style: TextStyle(
                      fontSize: 20,
                    )),
              ],
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HistoryNutrition()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAddBox() {
    List<FoodItem> _selectedFoodItems = [];
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
          ElevatedButton(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(Icons.add),
                Text('Add Meal',
                    style: TextStyle(
                      fontSize: 20,
                    )),
              ],
            ),
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
                                                  icon: Icon(Icons.add),
                                                  onPressed: () {
                                                    Fluttertoast.showToast(
                                                        msg: "Thêm thành công",
                                                        toastLength:
                                                            Toast.LENGTH_SHORT,
                                                        gravity:
                                                            ToastGravity.BOTTOM,
                                                        timeInSecForIosWeb: 1,
                                                        backgroundColor:
                                                            Colors.green,
                                                        textColor: Colors.white,
                                                        fontSize: 16.0);

                                                    final newFoodItem =
                                                        FoodItem(
                                                      imageUrl:
                                                          "assets/images/rice.png",
                                                      name: _apiResponseData[0]
                                                              ['name'] ??
                                                          'Unknown',
                                                      calories: (_apiResponseData[
                                                                      0][
                                                                  'calories'] ??
                                                              0)
                                                          .toString(),
                                                      protein: (_apiResponseData[
                                                                      0][
                                                                  'protein_g'] ??
                                                              0)
                                                          .toString(),
                                                      fat: (_apiResponseData[0][
                                                                  'fat_total_g'] ??
                                                              0)
                                                          .toString(),
                                                    );

                                                    setState(() {
                                                      _selectedFoodItems
                                                          .add(newFoodItem);
                                                    });
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
                                    setState(() {
                                      _isLoading = false;
                                      _foodItems.addAll(_selectedFoodItems);
                                      _handleAddFoodItem(_selectedFoodItems);
                                      _expandedItemIndex = _boxIndex + 1;
                                      uploadDataToFirebase(_title,
                                          _selectedFoodItems, currentUser!.uid);
                                      _selectedFoodItems.clear();
                                    });
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
        ],
      ),
    );
  }

  void uploadDataToFirebase(
      String name, List<FoodItem> foodItems, String userId) {
    final CollectionReference collection =
        FirebaseFirestore.instance.collection('nutrition');

    // Create a list to hold the food items
    List<Map<String, dynamic>> foodItemsList = [];

    // Add each food item to the list
    foodItems.forEach((foodItem) {
      foodItemsList.add({
        'meal': foodItem.name,
        'calories': foodItem.calories,
        'protein': foodItem.protein,
        'fat': foodItem.fat,
      });
    });

    // Upload the data to Firebase
    try {
      collection.add({
        'name': name,
        'foodItems': foodItemsList,
        'userId': userId,
        'time': Timestamp.now(),
      });
    } catch (e) {
      print('Error uploading data: $e');

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error uploading data. Please try again later.'),
      ));
    }
  }

  void _handleAddFoodItem(List<FoodItem> foodItems) {
    setState(() {
      for (var foodItem in foodItems) {
        _addedFoodItems.add(foodItem);
        _expandedFoodItemsMap[_boxIndex] = [foodItem];
        double totalCalories = double.parse(foodItem.calories);
        _infoBoxes.add(
            _buildInfoBox(_title, totalCalories, _boxIndex.toString(), "cal"));
        _boxIndex++;
        _expandedItemIndex = _boxIndex - 1;
      }
    });
  }

  Future<List<Nutrition>> fetchDataFromFirebase(String userId) async {
    final CollectionReference collection =
        FirebaseFirestore.instance.collection('nutrition');
    final QuerySnapshot querySnapshot =
        await collection.where('userId', isEqualTo: userId).get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.map((doc) {
        return Nutrition(
          id: doc.id,
          meal: doc['meal'],
          calories: doc['calories'],
          protein: doc['protein'],
          fat: doc['fat'],
          time: doc['time'],
        );
      }).toList();
    } else {
      return [];
    }
  }

  Widget _buildInfoBox(String name, double calories, String id,
      [String unit = 'cal']) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xffEFF0FF),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
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
                            text: "$name: $calories",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: unit,
                            style: TextStyle(
                              color: Colors.black,
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
                      _expandedItemIndex = (_expandedItemIndex == int.parse(id)
                          ? -1
                          : int.parse(id))!;
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
          if (_expandedItemIndex == int.parse(id))
            _buildExpandedItems(int.parse(id)),
        ],
      ),
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
    String _editedName = _title;
    List<FoodItem> _selectedFoodItems = [];
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
                        onSaved: (value) {
                          setState(() {
                            _title = value!;
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
                                if (data.isNotEmpty) {
                                  return ListTile(
                                    leading:
                                        Image.asset('assets/images/rice.png'),
                                    title: Text(' ${data[0]['name']}'),
                                    subtitle:
                                        Text(' ${data[0]['calories']} cal'),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.add),
                                          onPressed: () {
                                            Fluttertoast.showToast(
                                                msg: "Thêm thành công",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.green,
                                                textColor: Colors.white,
                                                fontSize: 16.0);

                                            final newFoodItem = FoodItem(
                                              imageUrl:
                                                  "assets/images/rice.png",
                                              name: _apiResponseData[0]
                                                      ['name'] ??
                                                  'Unknown',
                                              calories: (_apiResponseData[0]
                                                          ['calories'] ??
                                                      0)
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
                                              _selectedFoodItems
                                                  .add(newFoodItem);
                                            });
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
                    ],
                  ),
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
                          setState(() {
                            _isLoading = false;
                            _foodItems.addAll(_selectedFoodItems);
                            _handleAddFoodItem(_selectedFoodItems);
                            _expandedItemIndex = _boxIndex + 1;
                            _selectedFoodItems.clear();
                          });
                          FirebaseFirestore.instance
                              .collection('nutrition')
                              .doc(foodItem.name)
                              .update({
                            'name': _editedName,
                            // Add other fields you want to update here
                          }).then((_) {
                            print('Update successful');
                          }).catchError((error) {
                            print('Update failed: $error');
                          });
                          Navigator.of(context).pop();
                        }
                      });
                    }
                  },
                ),
                TextButton(
                  child: Text('Cancel'),
                  onPressed: () {},
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
