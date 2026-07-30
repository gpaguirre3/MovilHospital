import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static TextStyle titleLarge(BuildContext context) {
    return GoogleFonts.plusJakartaSans(
      fontSize: 28,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.5,
    );
  }

  static TextStyle titleMedium(BuildContext context) {
    return GoogleFonts.plusJakartaSans(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.3,
    );
  }

  static TextStyle bodyLarge(BuildContext context) {
    return GoogleFonts.plusJakartaSans(
      fontSize: 16,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle bodyMedium(BuildContext context) {
    return GoogleFonts.plusJakartaSans(
      fontSize: 14,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle buttonText(BuildContext context) {
    return GoogleFonts.plusJakartaSans(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.2,
    );
  }

  static TextStyle caption(BuildContext context) {
    return GoogleFonts.plusJakartaSans(
      fontSize: 12,
      fontWeight: FontWeight.w500,
    );
  }
}
