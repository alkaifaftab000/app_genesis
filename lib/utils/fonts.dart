import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class AppTextStyles {
  static TextStyle heading({Color? color}) {
    return GoogleFonts.roboto(
      color: color ?? Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 28,
    );
  }

  static TextStyle body({Color? color}) {
    return GoogleFonts.poppins(
      color: color ?? Colors.white,
      fontSize: 16,
    );
  }

  static TextStyle other({Color? color}) {
    return GoogleFonts.poppins(
      color: color ?? Colors.white,
      fontSize: 12,
    );
  }
}