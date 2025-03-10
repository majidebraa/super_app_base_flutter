import 'package:flutter/material.dart';
import '../constant/app_colors.dart';

class CustomHorizontalDivider extends StatelessWidget {
  final double height;
  final double thickness;
  final double indent;
  final double endIndent;
  final Color color;

  const CustomHorizontalDivider({
    super.key,
    this.height = 24,
    this.thickness = 2,
    this.indent = 20,
    this.endIndent = 20,
    this.color = AppColors.greyLightColor,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: height,
      thickness: thickness,
      indent: indent,
      endIndent: endIndent,
      color: color,
    );
  }
}
