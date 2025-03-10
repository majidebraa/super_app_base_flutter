import 'package:flutter/material.dart';

class CustomOutlinedTextField extends StatefulWidget {
  final TextEditingController? controller;
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
  final InputDecoration? decoration;
  final TextDirection textDirection;
  final TextAlign textAlign;
  final double width;
  final double height;
  final TextInputAction? textInputAction; // NEW: Controls keyboard action
  final FocusNode? focusNode; // NEW: Manages focus
  final ValueChanged<String>? onSubmitted; // NEW: Handles done/next button

  const CustomOutlinedTextField({
    super.key,
    this.controller,
    required this.onValueChange,
    required this.label,
    this.isPassword = false,
    this.cornerRadius = 8.0,
    this.singleLine = true,
    this.readOnly = false,
    this.textStyle = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: Colors.black,
    ),
    this.keyboardType = TextInputType.text,
    this.placeholder = "",
    this.showClearIcon = false,
    this.decoration,
    this.textDirection = TextDirection.rtl,
    this.textAlign = TextAlign.right,
    this.width = 400,
    this.height = 55,
    this.textInputAction,
    this.focusNode,
    this.onSubmitted,
  });

  @override
  CustomOutlinedTextFieldState createState() => CustomOutlinedTextFieldState();
}

class CustomOutlinedTextFieldState extends State<CustomOutlinedTextField> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _isPasswordVisible = false;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _controller.text = widget.controller?.text ?? '';
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void didUpdateWidget(covariant CustomOutlinedTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller == null && _controller.text != widget.controller?.text) {
      _controller.text = widget.controller?.text ?? '';
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        obscureText: widget.isPassword && !_isPasswordVisible,
        readOnly: widget.readOnly,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction, // NEW: Set keyboard action
        onSubmitted: widget.onSubmitted, // NEW: Handle button press
        style: widget.textStyle,
        textDirection: widget.textDirection,
        textAlign: widget.textAlign,
        decoration: _buildDecoration(),
        maxLines: widget.singleLine ? 1 : null,
        onChanged: widget.onValueChange,
      ),
    );
  }

  InputDecoration _buildDecoration() {
    return InputDecoration(
      hintText: !_isFocused && _controller.text.isEmpty
          ? (widget.placeholder.isNotEmpty ? widget.placeholder : widget.label)
          : null,
      labelText: _isFocused || _controller.text.isNotEmpty ? widget.label : null,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(widget.cornerRadius),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      suffixIcon: _buildSuffixIcon(),
    );
  }

  Widget? _buildSuffixIcon() {
    if (widget.isPassword) {
      return IconButton(
        icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
        onPressed: () {
          setState(() {
            _isPasswordVisible = !_isPasswordVisible;
          });
        },
      );
    } else if (widget.showClearIcon) {
      return IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          _controller.clear();
          widget.onValueChange('');
        },
      );
    }
    return null;
  }
}

