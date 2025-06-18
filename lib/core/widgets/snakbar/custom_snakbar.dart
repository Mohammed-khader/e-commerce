import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSnackbar {
  static void show(BuildContext context, String message, {Color? color}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: GoogleFonts.poppins(),
        ),
        backgroundColor: color ?? Colors.red,
      ),
    );
  }
}
