import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../../core/constants/color_palatte.dart';

class ProgressWidget extends StatefulWidget {
  final double percent;
  final double? size;
  final Widget child;
  final double calories;
  final double protein;
  final double fat;

  const ProgressWidget({
    Key? key,
    this.size,
    required this.calories,
    required this.protein,
    required this.fat,
    required this.child,
    required double percent,
  })  : percent = calories + protein + fat,
        super(key: key);
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
                center: Text("100%"),
                progressColor: Color.fromARGB(255, 241, 77, 7),
                percent: widget.protein / widget.percent,
              ),
              CircularPercentIndicator(
                radius: 60.0,
                lineWidth: 5.0,
                backgroundColor: Color(0xffEBECFF),
                progressColor: Color.fromARGB(255, 54, 105, 137),
                percent: widget.calories / widget.percent,
              ),
              CircularPercentIndicator(
                radius: 50.0,
                lineWidth: 5.0,
                backgroundColor: Color(0xffEBECFF),
                progressColor: Color.fromARGB(255, 91, 8, 112),
                percent: widget.fat / widget.percent,
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
                  Text("Protein: ${widget.protein}"),
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
                  Text("Calories: ${widget.calories}"),
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
                  Text("Fat: ${widget.fat}"),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
