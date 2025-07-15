import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.label,
    this.borderRadius,
    this.obscureText,
    this.prefixIcon,
    this.keyboardType,
    this.controller,
    this.validator,
    this.maxLength,
    this.onChanged,
  });
  final String label;
  final double? borderRadius;
  final bool? obscureText;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final int? maxLength;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool haidPassword = false;
  @override
  void initState() {
    super.initState();
    haidPassword = widget.obscureText ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChanged,
      maxLength: widget.maxLength,
      validator: widget.validator,
      controller: widget.controller,
      keyboardType: widget.keyboardType ?? TextInputType.text,
      obscureText: haidPassword,
      decoration: InputDecoration(
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.obscureText == true
              ? GestureDetector(
                  onTap: () {
                    haidPassword = !haidPassword;
                    setState(() {});
                  },
                  child: Icon(haidPassword ? Icons.visibility_off : Icons.remove_red_eye))
              : null,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          label: Text(widget.label),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 50),
          )),
    );
  }
}
