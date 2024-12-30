import 'dart:math';

import 'package:flutter/material.dart';
import 'package:healyou/healyou/core/models/sleep/sleep.dart';

class TimeArc extends StatefulWidget {
  const TimeArc(
      {Key? key, this.width, this.height, this.padding, required this.sleep})
      : super(key: key);
  final Sleep sleep;
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
    var startTime =
        widget.sleep.startTime.hour + widget.sleep.startTime.minute / 60;
    var endTime = widget.sleep.endTime.hour + widget.sleep.endTime.minute / 60;

    startRad = acos(-1) * (startTime / 6 - 0.5);
    var sweepHour =
        ((startTime - endTime).abs() - (startTime > endTime ? 12 : 0)).abs();
    sweepRad = sweepHour / 12 * 2 * pi;
    if (widget.sleep.startTime.day < widget.sleep.endTime.day) {
      sweepRad = 2 * 3.1415 - sweepRad;
    }

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
      child: Stack(
        children: [
          Center(
            child: CustomPaint(
                size: Size(100, 100),
                painter: ArcPainter(Colors.grey, startRad, sweepRad)),
          ),
          buildTimeOutArc(),
          ...buildTimeArc()
        ],
      ),
    );
  }

  List<Widget> buildTimeArc() {
    final result = <Widget>[];
    for (var i = 0; i < widget.sleep.sleepTime.length; i += 2) {
      var startTime = widget.sleep.sleepTime[i].hour +
          widget.sleep.sleepTime[i].minute / 60;
      var endTime = widget.sleep.sleepTime[i + 1].hour +
          widget.sleep.sleepTime[i + 1].minute / 60;

      var startradTemp = acos(-1) * (startTime / 6 - 0.5);
      var sweepHour =
          ((startTime - endTime).abs() - (startTime > endTime ? 12 : 0)).abs();
      var sweepradTemp = sweepHour / 12 * 2 * pi;
      if (widget.sleep.sleepTime[i].day < widget.sleep.sleepTime[i + 1].day) {
        sweepradTemp = 2 * 3.1415 - sweepradTemp;
      }
      result.add(
        Center(
          child: CustomPaint(
              size: Size(100, 100),
              painter: ArcPainter(widget.sleep.color ?? Colors.green.shade300,
                  startradTemp, sweepradTemp)),
        ),
      );
    }
    return result;
  }

  buildTimeOutArc() {
    var startTime =
        widget.sleep.startTime.hour + widget.sleep.startTime.minute / 60;
    var endTime = DateTime.now().hour + DateTime.now().minute / 60;

    var startradTemp = acos(-1) * (startTime / 6 - 0.5);
    var sweepHour =
        ((startTime - endTime).abs() - (startTime > endTime ? 12 : 0)).abs();
    var sweepradTemp = sweepHour / 12 * 2 * pi;
    if (widget.sleep.startTime.day < DateTime.now().day) {
      sweepradTemp = 2 * 3.1415 - sweepradTemp;
    }
    return Center(
      child: CustomPaint(
          size: Size(100, 100),
          painter:
              ArcPainter(Colors.red.shade200, startradTemp, sweepradTemp)),
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
