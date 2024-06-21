import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healyou/healyou/presentations/screens/detect/choose_image_screen.dart';

class AppBarWidget extends StatefulWidget {
  AppBarWidget({super.key, required this.title});
  String title;
  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, right: 8),
                child: Container(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius:
                          BorderRadius.circular(AppBar().preferredSize.height),
                      child: Icon(
                        Icons.photo_camera,
                        color: Colors.black,
                      ),
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(ChooseImageScreen.routeName);
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(left: 5.0, top: 5.0),
                  child: IconButton(
                    onPressed: () => FirebaseAuth.instance.signOut(),
                    icon: Icon(Icons.exit_to_app),
                  ))
            ],
          ),
        ],
      ),
    );
  }
}