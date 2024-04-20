import 'dart:math';

import 'package:flutter/material.dart';

class TimeArc extends StatefulWidget {
  const TimeArc(
      {Key? key,
      required this.startTime,
      required this.endTime,
      this.color,
      this.width,
      this.height,
      this.padding})
      : super(key: key);
  final DateTime startTime;
  final DateTime endTime;
  final Color? color;
  final double? width;
  final double? height;
  final double? padding;
  @override
  _TimeArcState createState() => _TimeArcState();
}

class _TimeArcState extends State<TimeArc> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  late double startRad;
  late double sweepRad;
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    var startTime = widget.startTime.hour + widget.startTime.minute / 60;
    var endTime = widget.endTime.hour + widget.endTime.minute / 60;

    startRad = acos(-1) * (startTime / 6 - 0.5);
    var sweepHour =
        ((startTime - endTime).abs() - (startTime > endTime ? 12 : 0)).abs();
    sweepRad = sweepHour / 12 * 2 * pi;
    debugPrint(startRad.toString());
    debugPrint(sweepRad.toString());
    animation = Tween(begin: 0.0, end: sweepRad)
        .animate(CurvedAnimation(parent: controller, curve: Curves.linear))
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.height,
      height: widget.height,
      padding: EdgeInsets.all(widget.padding ?? 20.0),
      child: CustomPaint(
          size: Size(100, 100),
          painter: ArcPainter(
              widget.color ?? Color(0xff8624DD), startRad, sweepRad)),
    );
  }
}

class ArcPainter extends CustomPainter {
  Color color;
  double arc;
  double start;
  ArcPainter(this.color, this.start, this.arc);
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..strokeWidth = 2
      ..color = color
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;
    canvas.drawArc(
        Rect.fromLTWH(size.width / 8, size.height / 8, 3 * size.width / 4,
            3 * size.height / 4),
        start,
        arc,
        true,
        paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
