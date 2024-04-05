import 'dart:io';
import 'package:get/get.dart';
import 'package:healyou/healyou/presentations/routes/app_router.dart';
import 'package:healyou/healyou/presentations/screens/Nutrition/nutrition_screen.dart';
import 'package:healyou/healyou/presentations/screens/map/run_map_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:healyou/healyou/core/helper/AuthFunctions.dart';
import 'package:healyou/healyou/main.dart';
import 'package:healyou/healyou/presentations/routes/app_router.dart';
import 'package:healyou/healyou/presentations/screens/Home/home_screen.dart';
import 'package:healyou/healyou/presentations/screens/account/login_screen.dart';
import 'package:healyou/healyou/presentations/screens/account/onboarding_screen.dart';
import 'package:healyou/healyou/presentations/widgets/loading.dart';
import 'package:healyou/healyou/presentations/widgets/loading_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:healyou/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healyou/healyou/core/helper/local_storage_helper.dart';
import 'package:healyou/healyou/presentations/screens/splash/splash_screen.dart';
import 'package:provider/provider.dart';
import 'navigation_home_screen.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'healyou/core/models/firebase/firebase_request.dart';

import 'healyou/core/models/firebase/firebase_request.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// ...

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //add
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await LocalStorageHelper.initLocalStorageHelper();

  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((_) => runApp(ChangeNotifierProvider(
      create: (context) => LoadingProvider(),
      builder: (context, child) => MyApp())));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness:
          !kIsWeb && Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    return GetMaterialApp(
      title: 'Flutter UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: AppTheme.textTheme,
          platform: TargetPlatform.iOS,
          fontFamily: 'Sen'),
      routes: routes,
      // home: healyouApp()
      initialRoute: Routes.map,

      getPages: [
        GetPage(name: Routes.map, page: () => Nutrition()),
      ],
    );
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
