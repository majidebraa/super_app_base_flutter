import 'package:flutter/material.dart';
import '../constant/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final VoidCallback? onClick; // Nullable to disable button
  final double width;
  final double height;
  final double cornerRadius;
  final Color textColor;
  final Color backgroundColor;
  final double fontSize;
  final bool isLoading;
  final bool isEnabled; // New property

  const CustomButton({
    super.key,
    this.text,
    required this.onClick,
    this.width = 400,
    this.height = 55,
    this.cornerRadius = 8,
    this.textColor = AppColors.whiteColor,
    this.backgroundColor = AppColors.blackColor,
    this.fontSize = 18,
    this.isLoading = false,
    this.isEnabled = true, // Default: enabled
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

    return Opacity(
      opacity: isEnabled ? 1.0 : 0.9, // Reduce opacity when disabled
      child: SizedBox(
        width: width,
        height: height,
        child: ElevatedButton(
          onPressed: isEnabled ? onClick : null, // Disable button when isEnabled is false
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(cornerRadius),
            ),
          ),
          child: Text(
            text ?? '',
            style: TextStyle(
              color: textColor,
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
