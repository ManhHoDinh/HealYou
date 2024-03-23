import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:healyou/healyou/presentations/screens/account/login_screen.dart';
import 'package:healyou/healyou/presentations/screens/account/signup_screen.dart';

class OnboardingScreen extends StatefulWidget {
  static const String routeName = 'onboarding_screen';

  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser =
      await GoogleSignIn().signIn().catchError((error) {
    debugPrint(error.toString());
  });
  debugPrint(googleUser.toString());
  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;
  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );
  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Welcome to",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 40),
            ),
            const Text(
              "HealYou",
              style: TextStyle(
                  fontSize: 30, fontFamily: 'MVBoli', color: Color(0xff198fb4)),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 10.0, left: 60.0, right: 60.0),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {},
                    child: OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                              width: 2.0, color: Color(0xffececec)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RichText(
                                text: const TextSpan(
                                    text: "Sign in with ",
                                    style: TextStyle(color: Colors.black),
                                    children: <TextSpan>[
                                  TextSpan(
                                    text: "HealYou ",
                                    style: TextStyle(
                                        fontFamily: 'MVBoli',
                                        color: Color(0xff198fb4)),
                                  ),
                                  TextSpan(text: "account")
                                ])),
                          ],
                        )),
                  ),
                  InkWell(
                      child: OutlinedButton(
                          onPressed: () async {
                            await signInWithGoogle();
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                                width: 2.0, color: Color(0xffececec)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: SvgPicture.asset(
                                      'assets/images/google.svg')),
                              const Text(
                                " Sign in with Google",
                                style: TextStyle(color: Colors.black),
                              )
                            ],
                          ))),
                  const Text(
                    "or",
                    style: TextStyle(color: Colors.grey),
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed('signup_screen');
                      },
                      child: const Text(
                        "Create new account",
                        style: TextStyle(
                            fontSize: 17,
                            decoration: TextDecoration.underline,
                            decorationColor: Color(0xfff8753d),
                            color: Color(0xfff8753d)),
                      ))
                ],
              ),
            )
          ],
        )));
  }
}
