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
                            size: Size(
                                350, 200),
                            painter: BoundingBoxPainter(
                              positions: foodDetect!.items.isEmpty
                                  ? []
                                  : foodDetect!.items
                                      .map((e) => e.position!)
                                      .toList(),
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
  final List<Position> positions;
  BoundingBoxPainter({required this.positions});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    for (var position in positions) {
      // Assuming each position value (x, y, width, height) is a percentage of the image size
      double left = position.x * size.width;
      double top = position.y * size.height;
      double right = (position.x + position.width) * size.width;
      double bottom = (position.y + position.height) * size.height;
      print(size);
      canvas.drawRect(Rect.fromLTRB(left, top, right, bottom), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
