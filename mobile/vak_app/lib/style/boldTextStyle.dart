import 'package:flutter/material.dart';

class BoldTextStyle {
  static TextTheme textTheme = const TextTheme(
    
    // figma: M-Bold  Display
    displaySmall: TextStyle(
      fontFamily: 'OpenSans',
      fontSize: 36,
      fontWeight: FontWeight.w700,
      letterSpacing: -1.5,
    ),

    // figma: M-Bold Heading H1
    titleLarge: TextStyle(
       fontFamily: 'OpenSans',
      fontSize: 24,
      fontWeight: FontWeight.w700,
      letterSpacing: -1.5,
    ),

    // figma: M-Bold Heading H2
    titleMedium: TextStyle(
      fontFamily: 'OpenSans',
      fontSize: 22,
      fontWeight: FontWeight.w700,
      letterSpacing: -1.5,
    ),

    // figma: M-Bold Heading H3
    titleSmall: TextStyle(
      fontFamily: 'OpenSans',
      fontSize: 20,
      fontWeight: FontWeight.w700,
      letterSpacing: -1.5,
    ),

    // figma: M-Bold Headline
    headlineMedium: TextStyle(
      fontFamily: 'OpenSans',
      fontSize: 17,
      fontWeight: FontWeight.w700,
      letterSpacing: -1.5,
    ),

    // figma: M-Bold Body Large
    bodyLarge: TextStyle(
      fontFamily: 'OpenSans',
      fontSize: 16,
      fontWeight: FontWeight.w700,
      letterSpacing: -1.5,
    ),

    // figma: M-Reguler Body Large
    bodySmall: TextStyle(
      fontFamily: 'OpenSans',
      fontSize: 14,
      fontWeight: FontWeight.w700,
      letterSpacing: -1.5,
    ),

    // figma: M-Reguler caption
    labelLarge: TextStyle(
      fontFamily: 'OpenSans',
      fontSize: 12,
      fontWeight: FontWeight.w700,
      letterSpacing: -1.5,
    ),
    
  );
}