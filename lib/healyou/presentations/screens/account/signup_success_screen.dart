import 'package:flutter/material.dart';

class SignupSuccessScreen extends StatefulWidget {
  static const String routeName = 'signup_success_screen';

  const SignupSuccessScreen({Key? key}) : super(key: key);

  @override
  _SignupSuccessScreenState createState() => _SignupSuccessScreenState();
}

class _SignupSuccessScreenState extends State<SignupSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Title'),
      ),
      body: Semantics(
        child: Center(
          child: Text("Đăng kí thành công"),
        ),
      ),
    );
  }
}
