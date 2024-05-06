import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:healyou/healyou/core/models/food_detect/food_detect.dart';
import 'dart:ui' as ui;

import '../../../core/constants/color_palatte.dart';
import '../../../core/constants/dimension_constants.dart';
import '../../../core/helper/text_styles.dart';
import '../../widgets/button_widget.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image/image.dart' as img;
import 'dart:math' as math;

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
            "Authorization": "Api-Key KNefxQtB.nXMvfNugyLD3yvEtgrvJiNdNyMiYY1ZS"
          },
        ),
      );

      // Handle successful response
      if (response.statusCode == 200) {
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
