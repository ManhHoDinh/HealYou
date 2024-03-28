import 'package:flutter/material.dart';

class LoadingOverlay extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final Color backgroundColor; // Optional: Customize overlay color
  final double opacity; // Optional: Customize overlay opacity

  const LoadingOverlay({
    Key? key,
    required this.child,
    this.isLoading = false,
    this.backgroundColor = Colors.black26,
    this.opacity = 0.5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading) ...[
          // Only show loading elements when isLoading is true
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              color: backgroundColor.withOpacity(opacity),
            ),
          ),
          Center(
            child: CircularProgressIndicator(), // Customize the indicator here
          ),
        ],
      ],
    );
  }
}
