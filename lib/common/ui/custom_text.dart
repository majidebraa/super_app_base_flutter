import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final double fontSize;
  final FontWeight fontWeight;
  final FontStyle fontStyle;
  final TextDecoration? textDecoration;
  final Color color;
  final EdgeInsetsGeometry padding;
  final TextAlign textAlign;
  final double? lineHeight;
  final int maxLines;
  final TextOverflow overflow;

  const CustomText({
    super.key,
    required this.text,
    this.style,
    this.fontSize = 14.0,
    this.fontWeight = FontWeight.normal,
    this.fontStyle = FontStyle.normal,
    this.textDecoration,
    this.color = Colors.black, // Default text color
    this.padding = EdgeInsets.zero,
    this.textAlign = TextAlign.center,
    this.lineHeight,
    this.maxLines = 10,
    this.overflow = TextOverflow.clip,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Text(
        text,
        style: style ??
            TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight,
              fontStyle: fontStyle,
              decoration: textDecoration,
              color: color,
              height: lineHeight,
            ),
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
      ),
    );
  }
}
