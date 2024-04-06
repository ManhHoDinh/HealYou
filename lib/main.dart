import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:healyou/healyou/core/helper/AuthFunctions.dart';
import 'package:healyou/healyou/core/models/firebase/target_request.dart';
import 'package:healyou/healyou/main.dart';
import 'package:healyou/healyou/presentations/routes/app_router.dart';
import 'package:healyou/healyou/presentations/screens/Home/home_screen.dart';
import 'package:healyou/healyou/presentations/screens/account/login_screen.dart';
import 'package:healyou/healyou/presentations/screens/account/onboarding_screen.dart';
import 'package:healyou/healyou/presentations/widgets/loading.dart';
import 'package:healyou/healyou/presentations/widgets/loading_provider.dart';
import 'package:get/get.dart';
import 'package:healyou/healyou/presentations/routes/app_router.dart';
import 'package:healyou/healyou/presentations/screens/otherTarget/other_target_screen.dart';
import 'package:healyou/healyou/presentations/screens/runTarget/run_target_screen.dart';
import 'package:healyou/healyou/presentations/screens/setTarget/set_target_screen.dart';
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
import 'package:awesome_notifications/awesome_notifications.dart';
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
  WidgetsFlutterBinding.ensureInitialized();
  await FireBaseDataBase.initializeDB();
  AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
            channelKey: 'heal_you',
            channelName: "Heal You",
            channelDescription: 'haha')
      ],
      debug: true);
  await TargetRequest.autoAddRunTarget();
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
      ),
      // home: SplashScreen(),
      initialRoute: Routes.runTarget,

      getPages: [
        GetPage(name: Routes.runTarget, page: () => RuntargetScreen()),
        GetPage(name: Routes.setTarget, page: () => SetTargetScreen()),
        GetPage(name: Routes.otherTarget, page: () => OtherTargetScreen()),
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
