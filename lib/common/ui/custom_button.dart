import 'package:flutter/material.dart';

import '../../constant/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final VoidCallback onClick;
  final double width;
  final double height;
  final double cornerRadius;
  final Color textColor;
  final Color backgroundColor;
  final double fontSize;
  final bool isLoading;
  final Widget Function(BuildContext) content;

  const CustomButton({
    super.key,
    this.text,
    required this.onClick,
    this.width = 400,
    this.height = 55,
    this.cornerRadius = 8,
    this.textColor = AppColors.whiteColor, // Default text color
    this.backgroundColor = AppColors.blackColor, // Default background color
    this.fontSize = 16,
    this.isLoading = false,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(
          color: backgroundColor,
          strokeWidth: 2.0,
        ),
      );
    }

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onClick,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor, // Background color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(cornerRadius),
          ),
        ),
        child: text != null
            ? Text(
          text!,
          style: TextStyle(
            color: textColor,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        )
            : content(context), // Use the provided content if no text
      ),
    );
  }
}