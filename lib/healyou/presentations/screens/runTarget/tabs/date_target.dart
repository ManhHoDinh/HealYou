import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:healyou/healyou/core/constants/color_palatte.dart';
import 'package:healyou/healyou/presentations/screens/runTarget/widgets/progress_widget.dart';

import '../widgets/line_chart_widget.dart';

class DateTarget extends StatefulWidget {
  const DateTarget({super.key});

  @override
  State<DateTarget> createState() => _DateTargetState();
}

class _DateTargetState extends State<DateTarget> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double calo = 100;
    double distance = 1000;
    double time = 19;
    double stepTarget = 8000;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(children: [
        SizedBox(
          height: 40,
        ),
        ProgressWidget(
            size: width * 7 / 10,
            value: 0.2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.directions_run,
                  color: ColorPalette.mainRunColor,
                  size: 70,
                ),
                Text('2000',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 50)),
                Text('Today', style: TextStyle(fontSize: 18)),
                Text('Target: ${stepTarget}', style: TextStyle(fontSize: 18))
              ],
            )),
        SizedBox(
          height: 40,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ProgressWidget(
                    size: width * 1 / 7,
                    value: 0.2,
                    child: Icon(Icons.local_fire_department,
                        color: ColorPalette.mainRunColor)),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    '${calo} Kcal',
                    style: TextStyle(fontSize: 16),
                  ),
                )
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ProgressWidget(
                    size: width * 1 / 7,
                    value: 0.3,
                    child: Icon(
                      Icons.arrow_forward,
                      color: ColorPalette.mainRunColor,
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    '${distance} km',
                    style: TextStyle(fontSize: 16),
                  ),
                )
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ProgressWidget(
                    size: width * 1 / 7,
                    value: 0.2,
                    child: Icon(
                      Icons.schedule,
                      color: ColorPalette.mainRunColor,
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    '${time} minutes',
                    style: TextStyle(fontSize: 16),
                  ),
                )
              ],
            )
          ],
        ),
        LineChartWidget(
          target: stepTarget,
        )
      ]),
    );
  }
}
