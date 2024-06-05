import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healyou/healyou/presentations/screens/Home/navigation_home.dart';
import 'package:healyou/healyou/presentations/widgets/loading.dart';
import 'package:healyou/healyou/presentations/widgets/loading_provider.dart';
import 'package:provider/provider.dart';

class ResetPasswordScreen extends StatefulWidget {
  static const String routeName = 'login_screen';
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  String? passError;
  String? emailError;
  var error = "";
  bool showPass = false;
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
                      'Forget your password?',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Row(
                  // Row to align left text
                  children: <Widget>[
                    Text(
                      'Fill the email so we can send you an reset code',
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
                                  sendResetEmail();
                                } finally {
                                  Provider.of<LoadingProvider>(context,
                                          listen: false)
                                      .hideLoading();
                                }
                              },
                              child: const Text(
                                "Send reset email",
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

  Future<void> sendResetEmail() async {
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: emailController.text);
  }
}
