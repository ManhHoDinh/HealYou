import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healyou/healyou/presentations/screens/Home/navigation_home.dart';
import 'package:healyou/healyou/presentations/widgets/loading.dart';
import 'package:healyou/healyou/presentations/widgets/loading_provider.dart';
import 'package:healyou/navigation_home_screen.dart';
import 'package:provider/provider.dart';

import '../information/gender.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login_screen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? passError;
  String? emailError;
  var error = "";
  late TextEditingController emailController;
  late TextEditingController passController;
  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: Provider.of<LoadingProvider>(context).isLoading,
      child: Scaffold(
          appBar: AppBar(
            actions: [
              TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Need help?",
                    style: TextStyle(color: Colors.grey),
                  ))
            ],
            backgroundColor: Colors.white,
          ),
          backgroundColor: Colors.white,
          body: Semantics(
            child: Center(
                child: Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Row(
                    // Row to align left text
                    children: [
                      Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Row(
                    // Row to align left text
                    children: <Widget>[
                      Text(
                        'Fill the detail to sign in account',
                        style: TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextField(
                        controller: emailController,
                        onChanged: _handleInputEmail,
                        decoration: InputDecoration(
                            hintText: 'Email',
                            prefixIcon: const Icon(Icons.mail_outline),
                            errorText: emailError),
                      ),
                      TextField(
                        controller: passController,
                        onChanged: handleChangePass,
                        decoration: InputDecoration(
                            hintText: 'Password',
                            prefixIcon: const Icon(Icons.key),
                            errorText: passError),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      error.isNotEmpty
                          ? Row(
                              children: [
                                Text(error,
                                    style: const TextStyle(
                                        color: Colors.red, fontSize: 10))
                              ],
                            )
                          : const SizedBox.shrink(),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                            constraints:
                                const BoxConstraints.expand(height: 60),
                            decoration: const BoxDecoration(
                                color: Color(0xff198fb4),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: TextButton(
                                onPressed: () async {
                                  Provider.of<LoadingProvider>(context,
                                          listen: false)
                                      .showLoading();
                                  try {
                                    // Perform your asynchronous operation here
                                    final credential = await _handleSignin();
                                    if (credential != null) {
                                      Navigator.pushNamed(context,
                                          NavigationHome.routeName);
                                    }
                                  } finally {
                                    Provider.of<LoadingProvider>(context,
                                            listen: false)
                                        .hideLoading();
                                  }
                                },
                                child: const Text(
                                  "Sign in",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ))),
                      ),
                      TextButton(
                          onPressed: () async {},
                          child: const Text(
                            "Forgot password?",
                            style: TextStyle(color: Color(0xfff8753d)),
                          ))
                    ],
                  )
                ],
              ),
            )),
          )),
    );
  }

  _handleSignin() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passController.text);
      return credential;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.code);
      if (e.code == 'channel-error') {
        setState(() {
          error = 'Please fill in all field';
        });
      } else if (e.code == 'user-not-found') {
        setState(() {
          error = 'No user found for that email.';
        });
      } else if (e.code == 'invalid-credential') {
        setState(() {
          error = 'Wrong email or password provided.';
        });
      }
      return null;
    }
  }

  void _handleInputEmail(String value) {
    debugPrint(emailController.text.toString());
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      setState(() {
        emailError = 'The email is not valid';
      });
    } else {
      setState(() {
        emailError = null;
      });
    }
  }

  void handleChangePass(String value) {
    if (value.length < 5) {
      setState(() {
        passError = 'The password must have at least 5 characters';
      });
    } else {
      setState(() {
        passError = null;
      });
    }
  }
}
