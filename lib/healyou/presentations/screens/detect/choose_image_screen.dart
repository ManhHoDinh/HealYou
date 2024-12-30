import 'package:flutter/material.dart';
import 'package:healyou/healyou/presentations/screens/detect/detect_screen.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/constants/color_palatte.dart';
import '../../../core/constants/dimension_constants.dart';
import '../../../core/helper/assets_helper.dart';
import '../../../core/helper/image_helper.dart';
import '../../../core/helper/text_styles.dart';

class ChooseImageScreen extends StatefulWidget {
  const ChooseImageScreen({super.key});
  static const String routeName = 'ChooseImage_screen';

  @override
  State<ChooseImageScreen> createState() => _ChooseImageCreenState();
}

class _ChooseImageCreenState extends State<ChooseImageScreen> {
  void onPickImageSelected(String source) async {
    ImageSource imageSource;
    if (source == 'Camera') {
      imageSource = ImageSource.camera;
    } else {
      imageSource = ImageSource.gallery;
    }
    try {
      final ImagePicker picker = ImagePicker();
      // Pick an image
      final file = await picker.pickImage(source: imageSource);
      if (file == null) {
        throw Exception('File is not available');
      }
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetectScreen(
            path: file.path,
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Detect food',
            style: TextStyles.h3.bold.copyWith(color: Colors.white),
          ),
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
          toolbarHeight: 100,
          backgroundColor: ColorPalette.primaryColor,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              InkWell(
                borderRadius: kDefaultBorderRadius,
                onTap: () async {
                  onPickImageSelected('Gallery');
                },
                splashColor: Colors.blueAccent,
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: kDefaultBorderRadius,
                      border: Border.all(color: Colors.black)),
                  padding:
                      const EdgeInsets.symmetric(vertical: kDefaultPadding),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(right: 30, left: 30),
                        child: ImageHelper.loadFromAsset(AssetHelper.gallery,
                            height: 30, width: 30),
                      ),
                      Text(
                        "Select image from gallery",
                        style: TextStyles.h5.copyWith(
                            color: ColorPalette.blackText,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                borderRadius: kDefaultBorderRadius,
                onTap: () async {
                  onPickImageSelected("Camera");
                },
                splashColor: Colors.blueAccent,
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: kDefaultBorderRadius,
                      border: Border.all(color: Colors.black)),
                  padding:
                      const EdgeInsets.symmetric(vertical: kDefaultPadding),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(right: 30, left: 30),
                        child: ImageHelper.loadFromAsset(AssetHelper.camera,
                            height: 30, width: 30),
                      ),
                      Text(
                        "Scan image from camera",
                        style: TextStyles.h5.copyWith(
                            color: ColorPalette.blackText,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
