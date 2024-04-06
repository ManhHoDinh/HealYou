import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../../core/constants/color_palatte.dart';

class ProgressWidget extends StatefulWidget {
  final double? size;
  final double value;
  final Widget child;
  const ProgressWidget(
      {super.key, this.size, required this.value, required this.child});

  @override
  State<ProgressWidget> createState() => _ProgressWidgetState();
}

class _ProgressWidgetState extends State<ProgressWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      height: 200,
      decoration: BoxDecoration(
        color: Color(0xffF5F6FF),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              CircularPercentIndicator(
                radius: 70.0,
                lineWidth: 5.0,
                backgroundColor: Color(0xffEBECFF),
                center: new Text("100%"),
                progressColor: Color.fromARGB(255, 241, 77, 7),
                percent: widget.value,
              ),
              CircularPercentIndicator(
                radius: 60.0,
                lineWidth: 5.0,
                backgroundColor: Color(0xffEBECFF),
                progressColor: Color.fromARGB(255, 54, 105, 137),
                percent: widget.value * 0.75,
              ),
              CircularPercentIndicator(
                radius: 50.0,
                lineWidth: 5.0,
                backgroundColor: Color(0xffEBECFF),
                progressColor: Color.fromARGB(255, 91, 8, 112),
                percent: widget.value * 0.5,
              ),
              Align(
                alignment: Alignment.center,
                child: widget.child,
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 70),
              Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 241, 77, 7),
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 5),
                  Text("Protein: ${widget.value}"),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 54, 105, 137),
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 5),
                  Text("Carb: ${widget.value * 0.75}"),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 91, 8, 112),
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 5),
                  Text("Fat: ${widget.value * 0.5}"),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
