import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:healyou/healyou/presentations/screens/Home/bottom_navigation_home.dart';
import 'package:healyou/healyou/presentations/screens/runTarget/run_target_screen.dart';
import 'package:healyou/healyou/presentations/screens/setTarget/set_target_screen.dart';

import '../../../../app_theme.dart';
import '../../../../custom_drawer/drawer_user_controller.dart';
import '../../../../custom_drawer/home_drawer.dart';
import '../../../../feedback_screen.dart';
import '../../../../help_screen.dart';
import '../../../../home_screen.dart';
import '../../../../invite_friend_screen.dart';
import '../../../core/helper/AuthFunctions.dart';
import '../account/login_screen.dart';

class NavigationHome extends StatefulWidget {
  const NavigationHome({super.key});
  static final String routeName = 'navigation_screen';

  @override
  State<NavigationHome> createState() => _NavigationHomeState();
}

class _NavigationHomeState extends State<NavigationHome> {
  Widget? screenView;
  DrawerIndex? drawerIndex;

  @override
  void initState() {
    drawerIndex = DrawerIndex.HOME;
    screenView = BottomHomeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppTheme.white,
        child: SafeArea(
          top: false,
          bottom: false,
          child: Scaffold(
            backgroundColor: AppTheme.nearlyWhite,
            body: DrawerUserController(
              screenIndex: drawerIndex,
              drawerWidth: MediaQuery.of(context).size.width * 0.75,
              onDrawerCall: (DrawerIndex drawerIndexdata) {
                changeIndex(drawerIndexdata);
                //callback from drawer for replace screen as user need with passing DrawerIndex(Enum index)
              },
              screenView: screenView,
              //we replace screen view as we need on navigate starting screens like MyHomePage, HelpScreen, FeedbackScreen, etc...
            ),
          ),
        ),
      ),
    );
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      switch (drawerIndex) {
        case DrawerIndex.HOME:
          setState(() {
            screenView =  BottomHomeScreen();
          });
          break;
        case DrawerIndex.Help:
          setState(() {
            screenView = HelpScreen();
          });
          break;
        case DrawerIndex.FeedBack:
          setState(() {
            screenView = FeedbackScreen();
          });
          break;
        case DrawerIndex.Invite:
          setState(() {
            screenView = InviteFriend();
          });
          break; 
        case DrawerIndex.SetTarget:
          setState(() {
            screenView = SetTargetScreen();
          });
          break; 
        default:
          
          break;
      }
    }
  }
}
