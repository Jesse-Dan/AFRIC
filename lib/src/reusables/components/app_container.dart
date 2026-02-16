import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../config/color_config.dart';

class AppContainer extends StatelessWidget {
  final Widget child;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final bool dottedBorder;
  final Color? dottedBorderColor;
  final double dottedBorderStrokeWidth;
  final List<double> dottedBorderDashPattern;

  const AppContainer({
    super.key,
    required this.child,
    this.color,
    this.padding,
    this.borderRadius,
    this.dottedBorder = false,
    this.dottedBorderColor,
    this.dottedBorderStrokeWidth = 1.5,
    this.dottedBorderDashPattern = const [6, 4],
  });

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? BorderRadius.circular(24);

    final content = Container(
      decoration: BoxDecoration(
        color: color ?? ColorConfig.textLight,
        borderRadius: radius,
      ),
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: child,
    );

    if (!dottedBorder) {
      return content;
    }

    return DottedBorder(
      options: RoundedRectDottedBorderOptions(
        color: dottedBorderColor ?? Colors.grey,
        strokeWidth: dottedBorderStrokeWidth,
        dashPattern: dottedBorderDashPattern,
        radius: Radius.circular(radius.topLeft.x),
      ),
      child: content,
    );
  }
}
