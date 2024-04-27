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
                // TextField(
                //   onChanged: (value) {
                //     setState(() {
                //       searchValue = value;
                //     });
                //   },
                //   controller: searchController,
                //   style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                //   decoration: InputDecoration(
                //       filled: true,
                //       hintStyle: TextStyle(color: Color(0xffFFFFFF)),
                //       fillColor: Color(0xff656565),
                //       border: OutlineInputBorder(
                //           borderSide: BorderSide.none,
                //           borderRadius: BorderRadius.circular(20)),
                //       hintText: 'Search album...',
                //       prefixIconColor: Color(0xffffffff),
                //       prefixIcon: Icon(Icons.search)),
                // ),
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
                // StreamBuilder<List<Album>>(
                //     stream: AlbumRequest.search(searchValue),
                //     builder: ((context, snapshot) {
                //       if (snapshot.connectionState == ConnectionState.waiting) {
                //         // While waiting for data, show a loading indicator
                //         return CircularProgressIndicator();
                //       } else if (snapshot.hasError) {
                //         // If there's an error with the stream, display an error message
                //         return Text('Error: ${snapshot.error}');
                //       } else {
                //         return GridView.builder(
                //             shrinkWrap: true,
                //             itemCount: snapshot.data!.length,
                //             gridDelegate:
                //                 const SliverGridDelegateWithFixedCrossAxisCount(
                //                     crossAxisCount: 3,
                //                     crossAxisSpacing: 10,
                //                     mainAxisSpacing: 10,
                //                     childAspectRatio: 0.8),
                //             itemBuilder: ((context, index) {
                //               return AlbumItem(
                //                 album: snapshot.data![index],
                //               );
                //             }));
                //       }
                //     })),
                Spacer(),
                Container(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    onPressed: () async {
                      // Album? result = await Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) =>
                      //         ModifyAlbum(), // Your existing Album if you're editing
                      //   ),
                      // );

                      // if (result != null) {
                      //   // Navigator.of(context).push(MaterialPageRoute(
                      //   //     builder: (context) => AlbumDetailScreen(album: result)));
                      // }
                    },
                    child: Text(
                      "+",
                      style: TextStyle(fontSize: 28),
                    ),
                  ),
                ),
                SizedBox(
                  height: 80,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
