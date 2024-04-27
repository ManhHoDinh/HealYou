import 'package:flutter/material.dart';

import '../../../../core/constants/color_palatte.dart';

class SetItemWidget extends StatefulWidget {
  final String value;
  final VoidCallback addHandler;
  final VoidCallback removeHandler;
  final Widget title;
  const SetItemWidget(
      {super.key,
      required this.value,
      required this.addHandler,
      required this.title,
      required this.removeHandler});

  @override
  State<SetItemWidget> createState() => _SetItemWidgetState();
}

class _SetItemWidgetState extends State<SetItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: ColorPalette.lightRunColor,
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () async {
              widget.removeHandler();
            },
            icon: Icon(
              Icons.remove,
              color: Colors.white,
              size: 30,
            ),
            style: IconButton.styleFrom(
                backgroundColor: ColorPalette.mediumRunColor),
          ),
          Column(
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: Text(
                  widget.value.toString(),
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800),
                ),
              ),
              widget.title
            ],
          ),
          IconButton(
            onPressed: () async {
              widget.addHandler();
            },
            icon: Icon(
              Icons.add,
              size: 30,
              color: Colors.white,
            ),
            style: IconButton.styleFrom(
                backgroundColor: ColorPalette.mediumRunColor),
          ),
        ],
      ),
    );
  }
}
