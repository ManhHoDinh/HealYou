import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../core/constants/color_palatte.dart';
import '../../../core/constants/dimension_constants.dart';
import '../../../core/models/food_detect/food_detect.dart';
import 'package:http/http.dart' as http;

import '../../../core/models/food_nutrition/food_nutrition.dart';
import '../../widgets/button_widget.dart';
import 'dart:convert'; // Import for jsonDecode

class AddFoodToMealScreen extends StatefulWidget {
  final FoodDetect? foodDetect;

  AddFoodToMealScreen({super.key, required this.foodDetect});

  @override
  State<AddFoodToMealScreen> createState() => _AddFoodToMealScreenState();
}

class _AddFoodToMealScreenState extends State<AddFoodToMealScreen> {
  List<FoodNutrition> foodNutrition = [];
  List<FoodNutrition> addedFood = [];

  Future<String> getNutrition(String query) async {
    final response = await http.get(
      Uri.parse('https://api.api-ninjas.com/v1/nutrition?query=$query'),
      headers: {
        'X-Api-Key': 'QY/91p56cj8LibzUgsqMvQ==0yIpYSjoUFZibn58',
      },
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return '[]'; // Default value for error case
    }
  }

  @override
  void initState() {
    super.initState();
    getFoodNutrition();
  }

  void getFoodNutrition() {
    widget.foodDetect?.items.forEach((element) async {
      final data = jsonDecode(
          await getNutrition(element.food!.first.foodInfo.displayName));

      // Use null-aware operator
      if (element.food != null && element.food!.isNotEmpty) {
        setState(() {
          FoodNutrition food = FoodNutrition(
              name: element.food!.first.foodInfo.displayName,
              quality: element.food!.first.quantity.toString(),
              calories: rng.nextInt(250).toString());
          foodNutrition.add(food);
          addedFood.add(food);
        });
      }
    });
  }

  String selectMeal = 'new';
  var rng = Random(0);

  @override
  Widget build(BuildContext context) {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    TextEditingController mealNameController = TextEditingController();
    DateTime now = DateTime.now();
    DateTime startOfDay = DateTime(now.year, now.month, now.day);
    DateTime endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);
    void uploadDataToFirebase(String name, List<FoodNutrition> foodItems,
        String userId, bool isNewMeal) {
      final CollectionReference collection =
          FirebaseFirestore.instance.collection('nutrition');

      List<Map<String, dynamic>> foodItemsList = [];

      foodItems.forEach((foodItem) {
        foodItemsList.add({
          'meal': foodItem.name,
          'calories': foodItem.calories,
        });
      });

      if (isNewMeal) {
        DocumentReference docRef = collection.doc();
        try {
          docRef.set({
            'id': docRef.id,
            'name': name,
            'foodItems': foodItemsList.toList(),
            'userId': userId,
            'time': Timestamp.now(),
          });
          Fluttertoast.showToast(msg: 'Add success');
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        } catch (e) {
          // Handle error
        }
      } else {
        collection
            .where('userId', isEqualTo: userId)
            .where('name', isEqualTo: selectMeal)
            .get()
            .then((snapshot) {
          if (snapshot.docs.isNotEmpty) {
            // Assuming 'name' is unique and there's only one match, we update the first document found.
            snapshot.docs
                .where((document) {
                  DateTime time = document['time'].toDate();
                  return time.isAfter(startOfDay) && time.isBefore(endOfDay);
                })
                .first
                .reference
                .update({
                  'foodItems': FieldValue.arrayUnion(foodItemsList),
                });
            Fluttertoast.showToast(msg: 'Add success');
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          } else {
            // Handle no document found error
            Fluttertoast.showToast(msg: 'Error not found meal to add food');
          }
        });
      }
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Food to Meal'),
          centerTitle: true,
        ),
        body: foodNutrition.isEmpty
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: <Widget>[
                  Expanded(
                      child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          "Choose meal to add food",
                          style: TextStyle(fontSize: 20),
                        ),
                        StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('nutrition')
                                .where('userId', isEqualTo: userId)
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                print('Error: ${snapshot.error}');
                                return Text("Something went wrong");
                              }
                              // Get the start and end of day DateTime objects
                              return ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: snapshot.data!.docs
                                      .where((document) {
                                        DateTime time =
                                            document['time'].toDate();
                                        return time.isAfter(startOfDay) &&
                                            time.isBefore(endOfDay);
                                      })
                                      .toList()
                                      .length,
                                  itemBuilder: (context, index) {
                                    DocumentSnapshot document =
                                        snapshot.data!.docs.where((document) {
                                      DateTime time = document['time'].toDate();
                                      return time.isAfter(startOfDay) &&
                                          time.isBefore(endOfDay);
                                    }).toList()[index];
                                    Map<String, dynamic> data =
                                        document.data() as Map<String, dynamic>;
                                    List<Map<String, dynamic>> foodItems =
                                        List<Map<String, dynamic>>.from(
                                            data['foodItems']);
                                    double calo = 0;
                                    foodItems.forEach((element) {
                                      calo += rng.nextInt(250) + 200;
                                    });
                                    return Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 50),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: RadioListTile(
                                        title: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                data['name'],
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                  calo.toString() + ' cal'),
                                            ),
                                          ],
                                        ),
                                        value: data['name'],
                                        groupValue: selectMeal,
                                        onChanged: (value) {
                                          setState(() {
                                            selectMeal = value ?? '';
                                          });
                                        },
                                      ),
                                    );
                                  });
                            }),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 50),
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: RadioListTile(
                            title: Text(
                              'Add New Meal',
                            ),
                            value: 'new',
                            groupValue: selectMeal,
                            onChanged: (value) {
                              setState(() {
                                selectMeal = value ?? '';
                              });
                            },
                          ),
                        ),
                        selectMeal == 'new'
                            ? Container(
                                margin: EdgeInsets.symmetric(horizontal: 50),
                                child: TextField(
                                  controller: mealNameController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    hintText: 'Enter meal name',
                                  ),
                                ),
                              )
                            : Container(),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 50, vertical: 20),
                          alignment: Alignment.center,
                          child: Text(
                            selectMeal == 'new'
                                ? 'Add Food To Meal'
                                : 'Add Food To $selectMeal',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        GridView.count(
                            padding:
                                const EdgeInsets.only(bottom: kMediumPadding),
                            crossAxisCount: 1,
                            mainAxisSpacing: 15,
                            childAspectRatio: 8,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap:
                                true, // Use shrinkWrap instead of wrapping in Expanded
                            children: foodNutrition
                                .map((e) => Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          color: ColorPalette.grayText),
                                    ),
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 50),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 9,
                                          child: Text(e.name ?? ''),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: Text(e.quality != null
                                              ? e.quality! + "g"
                                              : ''),
                                        ),
                                        Expanded(
                                            flex: 5,
                                            child: Text(e.calories != null
                                                ? '${e.calories!}cal'
                                                : '')),
                                        Expanded(
                                          flex: 3,
                                          child: IconButton(
                                              icon: addedFood.contains(e)
                                                  ? Icon(Icons.remove)
                                                  : Icon(Icons.add),
                                              onPressed: () {
                                                setState(() {
                                                  if (addedFood.contains(e)) {
                                                    addedFood.remove(e);
                                                  } else {
                                                    addedFood.add(e);
                                                  }
                                                });
                                              }),
                                        ),
                                      ],
                                    )))
                                .toList()),
                        Text(
                            'Total Calories: ${addedFood.map((e) => double.parse(e.calories!)).reduce((value, element) => value + element)}'),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 50),
                            margin: EdgeInsets.only(bottom: 20),
                            alignment: Alignment.bottomCenter,
                            child: ButtonWidget(
                                label: "Confirm",
                                color: ColorPalette.primaryColor,
                                textColor: Colors.white,
                                onTap: () {
                                  if (selectMeal == 'new') {
                                    if (mealNameController.text.isNotEmpty) {
                                      uploadDataToFirebase(
                                          mealNameController.text,
                                          addedFood,
                                          userId,
                                          true);
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: 'Please enter meal name');
                                    }
                                  } else {
                                    uploadDataToFirebase(
                                        selectMeal, addedFood, userId, false);
                                  } // The onTap should probably do something else
                                  // like confirm the meal addition and do some business logic.
                                }))
                      ],
                    ),
                  )),
                ],
              ));
  }
}
