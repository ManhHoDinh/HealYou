import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healyou/healyou/presentations/screens/account/signup_success_screen.dart';
import 'package:healyou/healyou/presentations/widgets/loading.dart';
import 'package:healyou/healyou/presentations/widgets/loading_provider.dart';
import 'package:healyou/healyou/presentations/widgets/shake.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = 'signup_screen';
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var passErrorText = '';
  var emailErrorText = '';
  var signInError = '';
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passController.dispose();
    super.dispose();
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
          body: Center(
              child: Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Row(
                  // Row to align left text
                  children: [
                    Text(
                      'Create Account',
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
                      'Fill the detail to create account',
                      style: TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        hintText: 'Your name',
                      ),
                    ),
                    TextField(
                      controller: emailController,
                      onChanged: (text) {
                        handleChangeEmail(text);
                      },
                      decoration: const InputDecoration(
                        hintText: 'Email',
                      ),
                    ),
                    ShakeError(
                      controller: shakeTextField,
                      child: TextField(
                        controller: passController,
                        onChanged: (text) {
                          handleChangePass(text);
                        },
                        decoration: const InputDecoration(
                          hintText: 'Password',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        (passErrorText.isEmpty && passController.text.isNotEmpty
                            ? const Text(
                                "Your password is valid",
                                style: TextStyle(
                                    color: Colors.green, fontSize: 10),
                              )
                            : Text(
                                passErrorText,
                                style: const TextStyle(
                                    color: Colors.red, fontSize: 10),
                              )),
                      ],
                    ),
                    Row(
                      children: [
                        (emailErrorText.isEmpty &&
                                emailController.text.isNotEmpty
                            ? const Text(
                                "Your email is valid",
                                style: TextStyle(
                                    color: Colors.green, fontSize: 10),
                              )
                            : Text(
                                emailErrorText,
                                style: const TextStyle(
                                    color: Colors.red, fontSize: 10),
                              )),
                      ],
                    ),
                    Row(
                      children: [
                        (signInError.isNotEmpty
                            ? Text(
                                signInError,
                                style: const TextStyle(
                                    color: Colors.green, fontSize: 10),
                              )
                            : const SizedBox.shrink()),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                          constraints: const BoxConstraints.expand(height: 60),
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
                                  final credential =
                                      await _handleSignup(); // var credential = await _handleSignup();
                                  if (credential != null) {
                                    Navigator.of(context).pushReplacementNamed(
                                        'signup_success_screen');
                                  }
                                } finally {
                                  Provider.of<LoadingProvider>(context,
                                          listen: false)
                                      .hideLoading();
                                }
                              },
                              child: const Text(
                                "Sign up",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ))),
                    ),
                  ],
                )
              ],
            ),
          ))),
    );
  }

  Future<UserCredential?> _handleSignup() async {
    final db = FirebaseFirestore.instance;
    if (emailErrorText.isNotEmpty || passErrorText.isNotEmpty) return null;
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passController.text,
      );
      // Create a new user with a first and last name
      final user = <String, dynamic>{"name": nameController.text};

// Add a new document with a user's ID
      final result = await db
          .collection("user")
          .doc(credential.user?.uid)
          .set(user)
          .then((value) => credential)
          .catchError((error) {
        debugPrint(error.toString());
        return null;
      });
      return result;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        setState(() {
          signInError = 'The password provided is too weak.';
        });
      } else if (e.code == 'email-already-in-use') {
        setState(() {
          signInError = 'The account already exists for that email.';
        });
      }
    } catch (e) {
      print(e);
    }
  }

  void handleChangePass(String text) {
    if (text.length < 5) {
      setState(() {
        passErrorText = 'The password must have at least 5 characters';
      });
    } else {
      setState(() {
        passErrorText = '';
      });
    }
  }

  void handleChangeEmail(String text) {
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(text)) {
      setState(() {
        emailErrorText = 'The email is not valid';
      });
    } else {
      setState(() {
        emailErrorText = '';
      });
    }
  }

  shakeTextField(AnimationController p1) {}
}
