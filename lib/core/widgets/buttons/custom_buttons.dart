import 'package:first_project/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButtons extends StatelessWidget {
  const CustomButtons({
    super.key,
    this.width,
    this.height,
    this.color,
    this.borderRadius,
    this.fontSize,
    this.textColors,
    required this.text,
    required this.onTap,
  });
  final double? width;
  final double? height;
  final Color? color;
  final double? borderRadius;
  final Color? textColors;
  final double? fontSize;
  final String text;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Center(
        child: Container(
          width: width ?? 200,
          height: height ?? 40,
          decoration: BoxDecoration(
            color: color ?? AppColors.primary,
            borderRadius: BorderRadius.circular(borderRadius ?? 50),
          ),
          child: Center(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: fontSize ?? 16,
                fontWeight: FontWeight.bold,
                color: textColors ?? Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
