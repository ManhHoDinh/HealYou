import 'dart:math';

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

import 'package:intl/intl.dart';

class NutritionSreen extends StatefulWidget {
  const NutritionSreen({super.key});

  @override
  State<NutritionSreen> createState() => _DateTargetState();
}

Future<String> getNutrition(String query) async {
  final response = await http.get(
    Uri.parse('https://api.api-ninjas.com/v1/nutrition?query=$query'),
    headers: {
      'X-Api-Key': 'QY/91p56cj8LibzUgsqMvQ==0yIpYSjoUFZibn58',
    },
  );

  if (response.statusCode == 200) {
    print(response.body);
    return response.body;
  } else {
    throw Exception('Failed to load nutrition');
  }
}

class _DateTargetState extends State<NutritionSreen> {
  final List<Widget> _infoBoxes = [];
  final _formKey = GlobalKey<FormState>();

  String _title = '';
  final int _value = 0;
  final String _unit = '';
  String? _expandedItemIndex;
  User? currentUser = FirebaseAuth.instance.currentUser;
  double totalCalories = 0.0;
  double totalProtein = 0.0;
  double totalFat = 0.0;
  final List<FoodItem> _addedFoodItems = [];
  final Map<int, List<FoodItem>> _expandedFoodItemsMap = {};
  final List<FoodItem> _foodItems = [];
  @override
  late DateTime _lastFetchDate;
  List<Widget> infoBoxes = [];
  bool _isLoading = false;
  List<dynamic> _apiResponseData = [];
  String id = '';
  FoodItem? _selectedFoodItem;
  @override
  bool _expanded = false;
  var rng = Random(150);

  @override
  Widget build(BuildContext context) {
    totalCalories =
        _foodItems.fold(0.0, (sum, item) => sum + 0);
    totalProtein =
        _foodItems.fold(0.0, (sum, item) => sum + 0);
    totalFat =
        _foodItems.fold(0.0, (sum, item) => sum + double.parse(item.fat));
    String userId = FirebaseAuth.instance.currentUser!.uid;
    double width = MediaQuery.of(context).size.width;
    DateTime now = DateTime.now();
    DateTime startOfDay = DateTime(now.year, now.month, now.day);
    DateTime endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('nutrition')
          .where('userId', isEqualTo: userId)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        List<Widget> infoBoxes = [];
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          print('Error: ${snapshot.error}');
          return Text("Something went wrong");
        }
        List<QueryDocumentSnapshot> documents =
            snapshot.data!.docs.where((document) {
          DateTime time = document['time'].toDate();
          return time.isAfter(startOfDay) && time.isBefore(endOfDay);
        }).toList();

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
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot document = documents[index];
                    Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;
                    List<Map<String, dynamic>> foodItems =
                        List<Map<String, dynamic>>.from(data['foodItems']);
                    double calo = 0;
                    for (var element in foodItems) {
                      calo += rng.nextInt(100) + 200;
                    }
                    return Column(
                      children: [
                        _buildInfoBox(
                          data['name'],
                          calo,
                          document.id,
                          'cal',
                        ),
                        SizedBox(height: 20),
                      ],
                    );
                  }),
              SizedBox(
                height: 20,
              ),
              _buildAddBox(),
              SizedBox(
                height: 20,
              ),
              _buildHistory(),
            ])));
      },
    );
  }

  double _calculateTotalFromFirestore(
      List<QueryDocumentSnapshot> documents, String fieldName) {
    double total = 0.0;
    for (var document in documents) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      List<dynamic> foodItems = data['foodItems'];
      for (var foodItem in foodItems) {
        total += double.parse(foodItem[fieldName]);
      }
    }
    return total;
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
              children: const <Widget>[
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
    List<FoodItem> selectedFoodItems = [];
    final TextEditingController controller = TextEditingController();
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
              children: const <Widget>[
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
                        content: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.height * 0.4,
                          child: Form(
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
                                  controller: controller,
                                  decoration: InputDecoration(
                                    labelText: 'Search',
                                  ),
                                  onSubmitted: (value) {
                                    setState(() {
                                      controller.text = value;
                                    });
                                  },
                                ),
                                FutureBuilder<String>(
                                  future: getNutrition(controller.text),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<String> snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularProgressIndicator();
                                    } else {
                                      if (snapshot.hasError) {
                                        return Text('Error: ${snapshot.error}');
                                      } else {
                                        if (snapshot.hasData &&
                                            snapshot.data != null) {
                                          _apiResponseData =
                                              jsonDecode(snapshot.data!);
                                          final data =
                                              jsonDecode(snapshot.data!);
                                          if (data.isNotEmpty) {
                                            return ListTile(
                                              leading: Image.asset(
                                                  'assets/images/rice.png'),
                                              title:
                                                  Text(' ${data[0]['name']}'),
                                              subtitle: Text(
                                                  ' ${rng.nextInt(200) + 200 } cal'),
                                              trailing: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  IconButton(
                                                    icon: Icon(Icons.add),
                                                    onPressed: () {
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              "Add Successfully",
                                                          toastLength: Toast
                                                              .LENGTH_SHORT,
                                                          gravity: ToastGravity
                                                              .BOTTOM,
                                                          timeInSecForIosWeb: 1,
                                                          backgroundColor:
                                                              Colors.green,
                                                          textColor:
                                                              Colors.white,
                                                          fontSize: 16.0);

                                                      final newFoodItem =
                                                          FoodItem(
                                                        imageUrl:
                                                            "assets/images/rice.png",
                                                        name:
                                                            _apiResponseData[0]
                                                                    ['name'] ??
                                                                'Unknown',
                                                        calories:
                                                            (rng.nextInt(200) +
                                                                    200)
                                                                .toString(),
                                                        protein: (_apiResponseData[
                                                                        0][
                                                                    'protein_g'] ??
                                                                0)
                                                            .toString(),
                                                        fat: (_apiResponseData[
                                                                        0][
                                                                    'fat_total_g'] ??
                                                                0)
                                                            .toString(),
                                                      );

                                                      setState(() {
                                                        selectedFoodItems
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
                                            return Text('');
                                          }
                                        } else {
                                          return Text('');
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
                                getNutrition(controller.text).then((data) {
                                  if (data != null) {
                                    setState(() {
                                      _isLoading = false;
                                      _foodItems.addAll(selectedFoodItems);
                                      _handleAddFoodItem(
                                          selectedFoodItems, id);
                                      _expandedItemIndex = (id);
                                      uploadDataToFirebase(_title,
                                          selectedFoodItems, currentUser!.uid);
                                      selectedFoodItems.clear();
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

    List<Map<String, dynamic>> foodItemsList = [];

    for (var foodItem in foodItems) {
      foodItemsList.add({
        'meal': foodItem.name,
        'calories': foodItem.calories,
        'protein': foodItem.protein,
        'fat': foodItem.fat,
      });
    }

    DocumentReference docRef = collection.doc();
    try {
      docRef.set({
        'id': docRef.id,
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

  void _handleAddFoodItem(List<FoodItem> foodItems, String id) {
    setState(() {
      for (var foodItem in foodItems) {
        _addedFoodItems.add(foodItem);
        double totalCalories = double.parse(foodItem.calories);
        _infoBoxes.add(_buildInfoBox(_title, totalCalories, id, "cal"));
        _expandedItemIndex = id;
      }
    });
  }

  Widget _buildInfoBox(String name, double calories, String id,
      [String unit = ' cal']) {
    String userId = FirebaseAuth.instance.currentUser!.uid;
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
                            text: "$name: $calories $unit",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
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
                      _expandedItemIndex = _expanded ? id : null;
                    });
                  },
                  child: Transform.translate(
                    offset: Offset(0, -10),
                    child: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _handleDeleteFoodItem(id);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleDeleteFoodItem(String id) async {
    await FirebaseFirestore.instance.collection('nutrition').doc(id).delete();
    setState(() {
      if (_expandedFoodItemsMap[id]?.isEmpty ?? false) {
        _infoBoxes.removeAt(int.parse(id));
        _expandedItemIndex = (-1) as String?;
      }
    });
  }
}
