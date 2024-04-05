import 'package:flutter/material.dart';
import 'package:healyou/healyou/presentations/screens/Home/home_screen.dart';
import 'package:healyou/healyou/presentations/screens/Home/navigation_home.dart';
import 'package:healyou/healyou/presentations/screens/account/login_screen.dart';
import 'package:healyou/healyou/presentations/screens/account/onboarding_screen.dart';
import 'package:healyou/healyou/presentations/screens/account/signup_screen.dart';
import 'package:healyou/healyou/presentations/screens/account/signup_success_screen.dart';
import 'package:healyou/healyou/presentations/screens/information/gender.dart';
import 'package:healyou/healyou/presentations/screens/splash/splash_screen.dart';

final Map<String, WidgetBuilder> routes = {
  HomeScreen.routeName: (context) => HomeScreen(),
  OnboardingScreen.routeName: (context) => OnboardingScreen(),
  LoginScreen.routeName: (context) => LoginScreen(),
  SignupScreen.routeName: (context) => SignupScreen(),
  SignupSuccessScreen.routeName: (context) => SignupSuccessScreen(),
  SplashScreen.routeName: (context) => SplashScreen(),
  NavigationHome.routeName  : (context) => NavigationHome(),
  GenderSelectorScreen.routeName: (context) => GenderSelectorScreen(),
};
