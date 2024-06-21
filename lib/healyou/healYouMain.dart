import 'package:alarm/alarm.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:healyou/healyou/core/models/user/user.dart';
import 'package:healyou/healyou/presentations/routes/app_router.dart';
import 'package:healyou/healyou/presentations/screens/Home/navigation_home.dart';
import 'package:healyou/healyou/presentations/screens/account/onboarding_screen.dart';
import 'package:healyou/healyou/presentations/screens/information/age.dart';
import 'package:healyou/healyou/presentations/screens/information/gender.dart';
import 'package:healyou/healyou/presentations/screens/splash/splash_screen.dart';
import 'package:healyou/healyou/presentations/screens/account/validation/validation_screen.dart';
import 'core/constants/color_palatte.dart';
import 'core/helper/AuthFunctions.dart';

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
    return MaterialApp(
      title: 'HealYou',
      theme: ThemeData(
          primaryColor: ColorPalette.primaryColor,
          scaffoldBackgroundColor: ColorPalette.backgroundColor,
          fontFamily: 'Sen'),
      home: AuthenticationWrapper(),
      routes: routes,
      debugShowCheckedModeBanner: false,
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
    Alarm.init();

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
                        if (!AuthServices.CurrentUser!.verified) {
                          return ValidationScreen();
                        }
                        debugPrint("Hello "+AuthServices.CurrentUser.toString());
                        if (AuthServices.CurrentUser!.gender == "" ||
                            AuthServices.CurrentUser!.age == 0 || AuthServices.CurrentUser!.height == 0 || AuthServices.CurrentUser!.weight == 0
                      || AuthServices.CurrentUser!.targetWeight == 0 
                            ) {
                          return GenderSelectorScreen();
                        }
                        return NavigationHome();
                      }
                    },
                  );
                } else {
                  return OnboardingScreen();
                }
              }
            },
          );
  }
}
