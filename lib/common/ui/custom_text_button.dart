import 'package:flutter/material.dart';
import '../constant/app_colors.dart';


class CustomTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onClick;
  final Color textColor;
  final double fontSize;

  const CustomTextButton({
    super.key,
    required this.text,
    required this.onClick,
    this.textColor = AppColors.greyColor, // Default text color
    this.fontSize = 14,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onClick,
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: fontSize,
        ),
      ),
    );
  }
}