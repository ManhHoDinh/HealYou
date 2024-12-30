import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:healyou/healyou/core/models/food_detect/food_detect.dart';
import 'package:healyou/healyou/presentations/screens/Nutrition/widgets/food_item.dart';
import 'package:healyou/healyou/presentations/screens/detect/AddFoodTOMealScreen.dart';
import 'dart:ui' as ui;

import '../../../core/constants/color_palatte.dart';
import '../../../core/constants/dimension_constants.dart';
import '../../../core/helper/text_styles.dart';
import '../../widgets/button_widget.dart';
import 'package:http_parser/http_parser.dart';
import 'dart:math' as math;
import 'package:http/http.dart' as http;

class DetectScreen extends StatefulWidget {
  const DetectScreen({super.key, this.path = ""});
  final String path;

  @override
  State<DetectScreen> createState() => _DetectScreenState();
}

class _DetectScreenState extends State<DetectScreen> {
  FoodDetect? foodDetect;
  //late GarbageModel garbageModel;
  late ui.Image
      uiImage; // Use the ui package Image to hold the data for CustomPainter.
  Size? imageSize; // To hold the actual size of the image.

  @override
  void initState() {
    super.initState();
    loadImage(); // Function defined below.
  }

  Future<void> loadImage() async {
    uiImage = await loadImageFromPath(widget.path);
    imageSize = Size(uiImage.width.toDouble(), uiImage.height.toDouble());
    importImageToAPI(widget.path);
  }

  Future<ui.Image> loadImageFromPath(String imagePath) async {
    Uint8List imageBytes = await File(imagePath).readAsBytes();
    Completer<ui.Image> completer = Completer();
    ui.decodeImageFromList(imageBytes, (ui.Image img) {
      return completer.complete(img);
    });
    return completer.future;
  }

  Future<void> importImageToAPI(String imagePath) async {
    try {
      final Dio dio = Dio();

      // Prepare multipart request body
      FormData formData = FormData();
      formData.files.add(MapEntry(
        'image',
        await MultipartFile.fromFile(
          imagePath,
          filename: imagePath.split(Platform.pathSeparator).last,
          contentType: MediaType.parse('image/jpeg'),
        ),
      ));

      final response = await dio.post(
        'https://vision.foodvisor.io/api/1.0/en/analysis/',
        data: formData,
        options: Options(
          headers: {
            "Authorization": "Api-Key B5QiyPuB.D8q5sz5QrUnVYxwybgBMlQgS45Ahzokl"
          },
        ),
      );

      // Handle successful response
      if (response.statusCode == 200) {
        print('Response: ${response.data}');
        setState(() {
          foodDetect = FoodDetect.fromJson(response.data);
        });
      } else {
        print('Error: ${response.statusCode}');
      }
    } on DioError catch (e) {
      print('Error posting image: ${e.message}');
    }
  }

  Future<String> getNutrition(String query) async {
    final response = await http.get(
      Uri.parse('https://api.api-ninjas.com/v1/nutrition?query=$query'),
      headers: {
        'X-Api-Key': 'lQS1ZgWLB4kX8yIl0uVK2g==8Rj1lVD7eL5NCFH1',
      },
    );

    if (response.statusCode == 200) {
      print(response.body);
      return response.body;
    } else {
      return '[]'; // Default value for error case
    }
  }
  var rng = Random();

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
      body: foodDetect != null
          ? Column(
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
                      children: [
                        Center(
                          child: Container(
                            // Replace this with your image or background widget
                            alignment: Alignment.center,
                            width: 350,
                            height: 200,
                            child: Image.file(
                              File(widget.path),
                              width: 350,
                              height: 200,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: CustomPaint(
                            size: Size(350, 200),
                            painter: BoundingBoxPainter(
                              items: foodDetect!.items,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: GridView.count(
                      padding: const EdgeInsets.only(bottom: kMediumPadding),
                      crossAxisCount: 1,
                      mainAxisSpacing: 15,
                      childAspectRatio: 8,
                      children: foodDetect!.items
                          .map((e) => Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border:
                                    Border.all(color: ColorPalette.grayText),
                              ),
                              margin: EdgeInsets.symmetric(horizontal: 50),
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: FutureBuilder<String>(
                                  future: getNutrition(
                                      e.food!.first.foodInfo.displayName),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<String> snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    } else {
                                      if (snapshot.hasError) {
                                        return Text('Error: ${snapshot.error}');
                                      } else {
                                        if (snapshot.hasData &&
                                            snapshot.data != null) {
                                          final data =
                                              jsonDecode(snapshot.data!);
                                          if (data.isNotEmpty) {
                                            return Row(
                                              children: [
                                                Expanded(
                                                  flex: 10,
                                                  child: Text(e.food!.first
                                                      .foodInfo.displayName),
                                                ),
                                                Expanded(
                                                  flex: 5,
                                                  child: Text("${e
                                                          .food!.first.quantity}g"),
                                                ),
                                                Expanded(
                                                    flex: 5,
                                                    child: Text(
                                                        '${(rng.nextInt(250) + 200).toString()} cal'))
                                              ],
                                            );
                                          }
                                        }
                                      }
                                    }
                                    return Text('No data');
                                  })))
                          .toList()),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                    margin: EdgeInsets.only(bottom: 20),
                    child: ButtonWidget(
                        label: "Confirm",
                        color: ColorPalette.primaryColor,
                        textColor: Colors.white,
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return AddFoodToMealScreen(
                              foodDetect: foodDetect,
                            );
                          }));
                        }))
              ],
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

class BoundingBoxPainter extends CustomPainter {
  final List<Item> items;
  BoundingBoxPainter({required this.items});
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    for (var item in items) {
      // Assuming each position value (x, y, width, height) is a percentage of the image size
      Color color = Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
          .withOpacity(1.0);
      paint.color = color;
      double left = item.position!.x * size.width;
      double top = item.position!.y * size.height;
      double right = (item.position!.x + item.position!.width) * size.width;
      double bottom = (item.position!.y + item.position!.height) * size.height;
      print(size);
      canvas.drawRect(Rect.fromLTRB(left, top, right, bottom), paint);

      // Prepare the text for drawing
      // final textSpan = TextSpan(
      //   text: item.food!.first.foodInfo.displayName, // The name to draw
      //   style: TextStyle(
      //     color: color,
      //   ),
      // );
      // final textPainter = TextPainter(
      //   text: textSpan,
      //   textAlign: TextAlign.center,
      //   textDirection: TextDirection.ltr,
      // );

      // // Layout the textPainter based on the given width (constraints)
      // textPainter.layout(
      //   minWidth: 0,
      //   maxWidth: size.width,
      // );

      // // Calculate the position to start drawing the text
      // // It centers the text in the bounding box
      // final xCenter = left + (right - left) / 2 - textPainter.width / 2;
      // final yCenter = top + (bottom - top) / 2 - textPainter.height / 2;

      // // Draw the text
      // textPainter.paint(canvas, Offset(xCenter, yCenter));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
