import 'package:flutter/material.dart';
import '../../constant/app_colors.dart';

class CustomOutlinedTextField extends StatefulWidget {
  final String value;
  final ValueChanged<String> onValueChange;
  final String label;
  final bool isPassword;
  final double cornerRadius;
  final bool singleLine;
  final bool readOnly;
  final TextStyle textStyle;
  final TextInputType keyboardType;
  final String placeholder;
  final bool showClearIcon;

  const CustomOutlinedTextField({
    super.key,
    required this.value,
    required this.onValueChange,
    required this.label,
    this.isPassword = false,
    this.cornerRadius = 8.0,
    this.singleLine = true,
    this.readOnly = false,
    this.textStyle = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: AppColors.blackColor,
      // You can adjust textAlign by wrapping TextField in Align widget
    ),
    this.keyboardType = TextInputType.text,
    this.placeholder = "",
    this.showClearIcon = false,
  });

  @override
  CustomOutlinedTextFieldState createState() => CustomOutlinedTextFieldState();
}

class CustomOutlinedTextFieldState extends State<CustomOutlinedTextField> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: TextEditingController(text: widget.value),
      onChanged: widget.onValueChange,
      obscureText: widget.isPassword && !_isPasswordVisible,
      readOnly: widget.readOnly,
      keyboardType: widget.keyboardType,
      style: widget.textStyle,
      decoration: InputDecoration(
        labelText: widget.label.isNotEmpty ? widget.label : null,
        hintText: widget.placeholder.isNotEmpty ? widget.placeholder : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.cornerRadius),
          borderSide: BorderSide(color: Colors.grey),
        ),
        suffixIcon: _buildSuffixIcon(),
      ),
      maxLines: widget.singleLine ? 1 : null, // Allow multiple lines if not single line
    );
  }

  Widget? _buildSuffixIcon() {
    if (widget.isPassword) {
      return IconButton(
        icon: Icon(
          _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
        ),
        onPressed: () {
          setState(() {
            _isPasswordVisible = !_isPasswordVisible;
          });
        },
      );
    } else if (widget.showClearIcon) {
      return IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          widget.onValueChange(''); // Clear the text field
        },
      );
    }
    return null; // No suffix icon if not password or clear icon
  }
}
