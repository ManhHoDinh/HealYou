import 'package:flutter/material.dart';
import 'package:healyou/healyou/presentations/screens/Home/home_screen.dart';
import 'package:healyou/healyou/presentations/screens/Home/navigation_home.dart';
import 'package:healyou/healyou/presentations/screens/account/login_screen.dart';
import 'package:healyou/healyou/presentations/screens/account/onboarding_screen.dart';
import 'package:healyou/healyou/presentations/screens/account/signup_screen.dart';
import 'package:healyou/healyou/presentations/screens/account/signup_success_screen.dart';
import 'package:healyou/healyou/presentations/screens/detect/choose_image_screen.dart';
import 'package:healyou/healyou/presentations/screens/information/age.dart';
import 'package:healyou/healyou/presentations/screens/information/confirm.dart';
import 'package:healyou/healyou/presentations/screens/information/gender.dart';
import 'package:healyou/healyou/presentations/screens/information/hight.dart';
import 'package:healyou/healyou/presentations/screens/information/weight.dart';
import 'package:healyou/healyou/presentations/screens/map/run_map_screen.dart';
import 'package:healyou/healyou/presentations/screens/run/track/run_track.dart';
import 'package:healyou/healyou/presentations/screens/splash/splash_screen.dart';

final Map<String, WidgetBuilder> routes = {
  HomeScreen.routeName: (context) => HomeScreen(),
  OnboardingScreen.routeName: (context) => OnboardingScreen(),
  LoginScreen.routeName: (context) => LoginScreen(),
  SignupScreen.routeName: (context) => SignupScreen(),
  SignupSuccessScreen.routeName: (context) => SignupSuccessScreen(),
  SplashScreen.routeName: (context) => SplashScreen(),
  NavigationHome.routeName: (context) => NavigationHome(),
  GenderSelectorScreen.routeName: (context) => GenderSelectorScreen(),
  AgeSelectorScreen.routeName: (context) => AgeSelectorScreen(),
  HightSelectorScreen.routeName: (context) => HightSelectorScreen(),
  WeightSelectorScreen.routeName: (context) => WeightSelectorScreen(),
  ReviewInformationScreen.routeName: (context) => ReviewInformationScreen(),
  RunMap.routeName: (context) => RunMap(),
  ChooseImageScreen.routeName: (context) => ChooseImageScreen(),
  RunTrackScreen.routeName: (context) => RunTrackScreen(),
};

class Routes {
  static String runTarget = '/runTarget';
  static String setTarget = '/setTarget';
  static String otherTarget = '/otherTarget';
  static String map = '/map';
}
