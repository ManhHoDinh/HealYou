import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healyou/healyou/core/models/dish/dish.dart';
import 'package:healyou/healyou/presentations/screens/recommendedDishes/widgets/indicator_widget.dart';

class IngredientChart extends StatefulWidget {
  final Dish dish;
  const IngredientChart({super.key, required this.dish});

  @override
  State<IngredientChart> createState() => _IngredientChartState();
}

class _IngredientChartState extends State<IngredientChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: PieChart(
            PieChartData(
              pieTouchData: PieTouchData(
                touchCallback: (FlTouchEvent event, pieTouchResponse) {
                  setState(() {
                    if (!event.isInterestedForInteractions ||
                        pieTouchResponse == null ||
                        pieTouchResponse.touchedSection == null) {
                      touchedIndex = -1;
                      return;
                    }
                    touchedIndex =
                        pieTouchResponse.touchedSection!.touchedSectionIndex;
                  });
                },
              ),
              borderData: FlBorderData(
                show: false,
              ),
              sectionsSpace: 0,
              centerSpaceRadius: 40,
              sections: showingSections(),
            ),
          ),
        ),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: <Widget>[
            Indicator(
              color: Color(0xff5470C6),
              text: 'Calories',
              isSquare: true,
            ),
            Indicator(
              color: Color(0xff91CC75),
              text: 'Fat',
              isSquare: true,
            ),
            Indicator(
              color: Color(0xffFAC858),
              text: 'Saturated fat',
              isSquare: true,
            ),
            Indicator(
              color: Color(0xffEE6666),
              text: 'Cholesterol',
              isSquare: true,
            ),
            Indicator(
              color: Color(0xff73C0DE),
              text: 'Sodium',
              isSquare: true,
            ),
            Indicator(
              color: Color(0xff3BA272),
              text: 'Carbohydrate',
              isSquare: true,
            ),
            Indicator(
              color: Color(0xffFC8452),
              text: 'Fiber',
              isSquare: true,
            ),
            Indicator(
              color: Color(0xff9A60B4),
              text: 'Sugar',
              isSquare: true,
            ),
            Indicator(
              color: Color(0xffEA7CCC),
              text: 'Protein',
              isSquare: true,
            ),
          ],
        ),
      ],
    );
  }

  List<PieChartSectionData> showingSections() {
    Map<String, dynamic> dishJson = widget.dish.toJson();
    double total = 0;
    for (var key in dishJson.keys) {
      if (dishJson[key] is double) {
        print(key);
        total += dishJson[key];
      }
    }
    print(total);
    return List.generate(9, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Color(0xff5470C6),
            value: widget.dish.Calories / total,
            radius: radius,
            showTitle: false,
          );
        case 1:
          return PieChartSectionData(
              color: Color(0xff91CC75),
              value: widget.dish.FatContent / total,
              radius: radius,
              showTitle: false);
        case 2:
          return PieChartSectionData(
              color: Color(0xffFAC858),
              value: widget.dish.SaturatedFatContent / total,
              radius: radius,
              showTitle: false);
        case 3:
          return PieChartSectionData(
            showTitle: false,
            color: Color(0xffEE6666),
            value: widget.dish.CholesterolContent / total,
            radius: radius,
          );
        case 4:
          return PieChartSectionData(
            color: Color(0xff73C0DE),
            showTitle: false,
            value: widget.dish.SodiumContent / total,
            radius: radius,
          );
        case 5:
          return PieChartSectionData(
            showTitle: false,
            color: Color(0xff3BA272),
            value: widget.dish.CarbohydrateContent / total,
            radius: radius,
          );
        case 6:
          return PieChartSectionData(
            showTitle: false,
            color: Color(0xffFC8452),
            value: widget.dish.FiberContent / total,
            radius: radius,
          );
        case 7:
          return PieChartSectionData(
            showTitle: false,
            color: Color(0xff9A60B4),
            value: widget.dish.SugarContent / total,
            radius: radius,
          );
        case 8:
          return PieChartSectionData(
            showTitle: false,
            color: Color(0xffEA7CCC),
            value: widget.dish.ProteinContent / total,
            radius: radius,
          );
        default:
          throw Error();
      }
    });
  }
}
