import 'package:flutter/material.dart';

class RunResult extends StatefulWidget {
  const RunResult({Key? key}) : super(key: key);

  @override
  _RunResultState createState() => _RunResultState();
}

class _RunResultState extends State<RunResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Title'),
      ),
      body: Container(),
    );
  }
}
