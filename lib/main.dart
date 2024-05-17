import 'dart:io';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:healyou/dio.dart';
import 'package:healyou/healyou/core/models/firebase/target_request.dart';
import 'package:healyou/healyou/healYouMain.dart';
import 'package:healyou/healyou/presentations/routes/app_router.dart';
import 'package:healyou/healyou/presentations/screens/Home/navigation_home.dart';
import 'package:healyou/healyou/presentations/screens/information/gender.dart';
import 'package:healyou/healyou/presentations/screens/recommendedDishes/recommended_dishes_screen.dart';
import 'package:healyou/healyou/presentations/screens/runTarget/run_target_screen.dart';
import 'package:healyou/healyou/presentations/screens/setTarget/set_target_screen.dart';
import 'package:healyou/healyou/presentations/widgets/loading_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:healyou/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healyou/healyou/core/helper/local_storage_helper.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:healyou/healyou/core/controller/notify_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';

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
  NotifyController.initializeNotification();

  // if (FirebaseAuth.instance.currentUser != null) {
  //   await TargetRequest.autoAddRunTarget();
  // }

  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((_) => runApp(ChangeNotifierProvider(
      create: (context) => LoadingProvider(),
      builder: (context, child) => MyApp())));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // Only after at least the action method is set, the notification events are delivered
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: NotifyController.onActionReceivedMethod,
        onNotificationCreatedMethod:
            NotifyController.onNotificationCreatedMethod,
        onNotificationDisplayedMethod:
            NotifyController.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod:
            NotifyController.onDismissActionReceivedMethod);

    super.initState();
  }

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
      navigatorKey: MyApp.navigatorKey,
      title: 'Flutter UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: AppTheme.textTheme,
        platform: TargetPlatform.iOS,
      ),
      routes: routes,
      initialBinding: MyBindings(),
      //initialRoute: Routes.recommendedDishes,
      getPages: [
        GetPage(
            name: Routes.genderSelector, page: () => GenderSelectorScreen()),
        GetPage(name: Routes.runTarget, page: () => RuntargetScreen()),
        GetPage(name: Routes.setTarget, page: () => SetTargetScreen()),
        GetPage(name: Routes.navigationHome, page: () => NavigationHome()),
        GetPage(
            name: Routes.recommendedDishes,
            page: () => RecommendedDishesScreen()),
      ],
       home: healyouApp()
    );
  }
}
// class MyApp extends StatelessWidget {
//   static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//       statusBarColor: Colors.transparent,
//       statusBarIconBrightness: Brightness.dark,
//       statusBarBrightness:
//           !kIsWeb && Platform.isAndroid ? Brightness.dark : Brightness.light,
//       systemNavigationBarColor: Colors.white,
//       systemNavigationBarDividerColor: Colors.transparent,
//       systemNavigationBarIconBrightness: Brightness.dark,
//     ));

//     return GetMaterialApp(
//         title: 'Flutter UI',
//         debugShowCheckedModeBanner: false,
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//           textTheme: AppTheme.textTheme,
//           platform: TargetPlatform.iOS,
//         ),
//         routes: routes,
//         // initialRoute: Routes.setTarget,
//         getPages: [
//           GetPage(
//               name: Routes.genderSelector, page: () => GenderSelectorScreen()),
//           GetPage(name: Routes.runTarget, page: () => RuntargetScreen()),
//           GetPage(name: Routes.setTarget, page: () => SetTargetScreen()),
//           GetPage(name: Routes.navigationHome, page: () => NavigationHome()),
//         ],
//         home: healyouApp());
//   }
// }

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
