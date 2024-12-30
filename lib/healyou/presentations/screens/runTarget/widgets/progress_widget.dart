import 'package:flutter/material.dart';

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
    return Stack(
      alignment: Alignment.center,
      children: [
        Align(
          alignment: Alignment.center,
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
                color: Color(0xffF5F6FF),
                borderRadius: BorderRadius.circular(1000)),
            child: CircularProgressIndicator(
              backgroundColor: Color(0xffEBECFF),
              color: ColorPalette.mainRunColor,
              value: widget.value,
              strokeWidth: widget.size != null ? widget.size! * 1 / 10 : 6,
              strokeCap: StrokeCap.round,
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: widget.child,
        )
      ],
    );
  }
}
