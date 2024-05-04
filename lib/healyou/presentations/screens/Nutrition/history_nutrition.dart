import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healyou/healyou/core/constants/color_palatte.dart';
import 'package:healyou/healyou/core/helper/text_styles.dart';
import 'package:healyou/healyou/core/helper/assets_helper.dart';
import 'package:healyou/healyou/core/models/nutrition/nutrition.dart';
import 'package:healyou/healyou/core/models/user/user.dart';
import 'package:healyou/healyou/presentations/screens/Nutrition/widgets/history_item.dart';

class HistoryNutrition extends StatefulWidget {
  const HistoryNutrition({super.key, this.animationController});
  final AnimationController? animationController;

  @override
  State<HistoryNutrition> createState() => _AllAlbumScreenState();
}

class _AllAlbumScreenState extends State<HistoryNutrition>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  TextEditingController searchController = TextEditingController();
  String searchValue = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: Gradients.defaultGradientBackground),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              'History Nutrition',
            ),
            centerTitle: true,
          ),
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('nutrition')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return GridView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 0.8),
                        itemBuilder: (context, index) {
                          DocumentSnapshot doc = snapshot.data!.docs[index];
                          Nutrition nutrition = Nutrition.fromJson(
                              doc.data() as Map<String, dynamic>);
                          return Stack(
                            children: [
                              HistoryItem(nutrition: nutrition),
                              Positioned(
                                top: 0,
                                left: 0,
                                right: 40,
                                child: Image.asset('assets/images/rice.png'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
