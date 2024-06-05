import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healyou/healyou/core/helper/AuthFunctions.dart';
import 'package:healyou/healyou/core/helper/text_styles.dart';

class ValidationScreen extends StatefulWidget {
  const ValidationScreen({Key? key}) : super(key: key);
  static const routeName = "/validation";

  @override
  _ValidationScreenState createState() => _ValidationScreenState();
}

class _ValidationScreenState extends State<ValidationScreen> {
  bool sented = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Validation'),
      ),
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Validation your account", style: TextStyles.h2),
          Text(
            "Please check your mailbox for verification mail.",
            style: TextStyles.inforRoomDetail,
          ),
          if (!sented)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: InkWell(
                onTap: () => resentEmail(),
                child: Text.rich(TextSpan(
                    text: 'Click here',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        decorationColor: Colors.blue,
                        decoration: TextDecoration.underline),
                    children: const <InlineSpan>[
                      TextSpan(
                          text:
                              ' if you cannot find the email or the email is due.',
                          style: TextStyles.inforRoomDetail)
                    ])),
              ),
            ),
        ],
      )),
    );
  }

  Future<void> resentEmail() async {
    var acs = ActionCodeSettings(
        // URL you want to redirect back to. The domain (www.example.com) for this
        // URL must be whitelisted in the Firebase Console.
        url:
            'https://healu-20551.firebaseapp.com?id=${AuthServices.CurrentUser!.id}&t=${Timestamp.fromDate(DateTime.now())}',
        // This must be true
        handleCodeInApp: true,
        androidPackageName: 'com.android.healu',
        // installIfNotAvailable
        androidInstallApp: true,
        // minimumVersion
        androidMinimumVersion: '12');
    await FirebaseAuth.instance
        .sendSignInLinkToEmail(
            email: AuthServices.CurrentUser!.email, actionCodeSettings: acs)
        .catchError((onError) {
      debugPrint('Error sending email verification $onError');
      setState(() {
        sented = false;
      });
    }).then((value) {
      debugPrint('Successfully sent email verification');
      setState(() {
        sented = true;
      });
    });
  }
}
