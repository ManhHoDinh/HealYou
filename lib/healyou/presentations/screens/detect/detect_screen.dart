import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import '../../../core/constants/color_palatte.dart';
import '../../../core/constants/dimension_constants.dart';
import '../../../core/helper/text_styles.dart';
import '../../../core/models/firebase/firebase_request.dart';
import '../../widgets/button_widget.dart';

class DetectScreen extends StatefulWidget {
  const DetectScreen({super.key, this.path = ""});
  final String path;

  @override
  State<DetectScreen> createState() => _DetectScreenState();
}

class _DetectScreenState extends State<DetectScreen> {
  List<Rect> _boundingBoxes = []; // List to store bounding box data
  //late GarbageModel garbageModel;
  @override
  void initState() {
    super.initState();
    postImageToAPI(widget.path); // Call API to fetch bounding boxes on load
  }

  Future<void> postImageToAPI(String imagePath) async {
    final Dio dio = Dio();
    final imageBytes = await File(imagePath).readAsBytes();

    // Prepare multipart request body
    final formData = FormData.fromMap({
      'image': MultipartFile.fromBytes(imageBytes, filename: 'image.jpg'),
    });

    try {
      /*
      final response = await dio.post(
        'https://your-api.com/upload-image',
        data: formData,
      );

      // Handle successful response
      if (response.statusCode == 200) {
        print(response.data); // Example: print the response data
      } else {
        print('Error: ${response.statusCode}');
      }*/
    } on DioError catch (e) {
      print('Error posting image: ${e.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Food Detected Result',
          style: TextStyles.h3.bold.copyWith(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        toolbarHeight: 100,
        backgroundColor: ColorPalette.primaryColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /* SizedBox(
            height: 30,
          ),
          Text(
            'Food Detected Result',
            style: TextStyles.h3.bold.copyWith(color: ColorPalette.blackText),
          ),*/
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Stack(
                // Use Stack to overlay bounding boxes on image
                children: [
                  Center(child: Image.file(File(widget.path))),
                  Center(
                    child: CustomPaint(
                      // Use CustomPaint to draw bounding boxes
                      size: MediaQuery.of(context).size,
                      painter: BoundingBoxPainter(_boundingBoxes),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 50,
            /*  child: StreamBuilder<List<GarbageModel>>(
                stream: FireBaseDataBase.readGarbages(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Something went wrong! ${snapshot.error}'),
                    );
                  } else if (snapshot.hasData) {
                    return GridView.count(
                        padding: const EdgeInsets.only(bottom: kMediumPadding),
                        crossAxisCount: 1,
                        mainAxisSpacing: 15,
                        childAspectRatio: 8,
                        children: snapshot.data!
                            .where((element) {
                              if (element.name == "Chai") {
                                garbageModel = element;
                                return true;
                              }
                              return false;
                            })
                            .map((e) => Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color: ColorPalette.grayText),
                                  ),
                                  margin: EdgeInsets.symmetric(horizontal: 50),
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Row(
                                    children: [
                                      Text(e.name),
                                      Expanded(child: Container()),
                                      Text(e.price.toString() + "/Kg")
                                    ],
                                  ),
                                ))
                            .toList());
                  } else
                    return Container();
                }),
          */
          ),
          SizedBox(
            height: 20,
          ),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              margin: EdgeInsets.only(bottom: 20),
              child: ButtonWidget(
                  label: "Xác nhận",
                  color: ColorPalette.primaryColor,
                  textColor: Colors.white,
                  onTap: () {
                    /* Navigator.push(context, MaterialPageRoute(builder: (context) {
                     return TransactionScreen(
                        garbageItem: garbageModel,
                      );
                    }));*/
                  }))
        ],
      ),
    );
  }
}

class BoundingBoxPainter extends CustomPainter {
  final List<Rect> boundingBoxes; // List to store bounding box data

  const BoundingBoxPainter(this.boundingBoxes); // Pass in boundingBoxes

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    for (final box in boundingBoxes) {
      canvas.drawRect(box, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => ListEquality()
      .equals((oldDelegate as BoundingBoxPainter).boundingBoxes, boundingBoxes);
}
