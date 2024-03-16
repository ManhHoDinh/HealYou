import 'package:flutter/material.dart';
import 'package:healyou/healyou/core/constants/color_palatte.dart';
import 'package:healyou/healyou/core/helper/image_helper.dart';

import '../../../core/helper/assets_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static final String routeName = 'splash_screen';

  @override
  State<SplashScreen> createState() => _SplashCreenState();
}

class _SplashCreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Splash Screen"),
        backgroundColor: Colors.white,
        
      ),
        backgroundColor: Colors.white,
        body: Center(
          child: Text("Splash Screen")
        ));
  }
}
