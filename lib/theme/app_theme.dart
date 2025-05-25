import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFFE53935);

  static ThemeData get lightTheme => ThemeData(
        primaryColor: primaryColor,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: primaryColor,
          secondary: Colors.black,
        ),
        textTheme: GoogleFonts.montserratTextTheme(),
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            textStyle: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
          ),
        ),
      );

  static ThemeData get darkTheme => ThemeData.dark().copyWith(
        primaryColor: primaryColor,
        colorScheme: ColorScheme.dark(
          primary: primaryColor,
          secondary: Colors.white,
        ),
        textTheme: GoogleFonts.montserratTextTheme(ThemeData.dark().textTheme),
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            textStyle: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
          ),
        ),
      );
}