import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:healyou/healyou/presentations/routes/app_router.dart';
import 'package:healyou/healyou/presentations/screens/Home/home_screen.dart';
import 'package:healyou/healyou/presentations/screens/account/login_screen.dart';
import 'package:healyou/healyou/presentations/screens/splash/splash_screen.dart';
import 'core/constants/color_palatte.dart';
import 'core/helper/AuthFunctions.dart';
import 'core/helper/local_storage_helper.dart';
import 'core/models/firebase/firebase_request.dart';

class healyouApp extends StatefulWidget {
  const healyouApp({super.key});

  @override
  State<healyouApp> createState() => _healyouAppState();
}

class _healyouAppState extends State<healyouApp> {
  var auth = FirebaseAuth.instance;
  bool isLogin = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'HealYou',
      theme: ThemeData(
          primaryColor: ColorPalette.primaryColor,
          scaffoldBackgroundColor: ColorPalette.backgroundColor,
          fontFamily: 'Sen'),
      home: AuthenticationWrapper(),
      routes: routes,
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.setTarget,
    );
  }
}

class AuthenticationWrapper extends StatefulWidget {
  @override
  _AuthenticationWrapperState createState() => _AuthenticationWrapperState();
}

class _AuthenticationWrapperState extends State<AuthenticationWrapper> {
  bool _showSplash = true;

  @override
  void initState() {
    super.initState();
    // Wait for 5 seconds and then hide the splash screen
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _showSplash = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _showSplash
        ? SplashScreen()
        : StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SplashScreen();
              } else {
                if (snapshot.hasData) {
                  return FutureBuilder(
                    future: AuthServices.UpdateCurrentUser(),
                    builder:
                        (BuildContext context, AsyncSnapshot<void> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // Show a loading indicator if necessary
                        return SplashScreen();
                      } else {
                        // If the update is complete, navigate to the MainScreen
                        return HomeScreen();
                      }
                    },
                  );
                } else {
                  return LoginScreen();
                }
              }
            },
          );
  }
}
