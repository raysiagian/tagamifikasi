import 'package:flutter/material.dart';

class RegulerTextStyle {
  static TextTheme textTheme = const TextTheme(
    // reguler
    // font reguler disini
    
    // figma: M-Reguler Display
    displaySmall: TextStyle(
      fontFamily: 'OpenSans',
      fontSize: 36,
      fontWeight: FontWeight.w400,
      letterSpacing: -1.5,
    ),

    // figma: M-Reguler Heading H1
    titleLarge: TextStyle(
      fontFamily: 'OpenSans',
      fontSize: 24,
      fontWeight: FontWeight.w400,
      letterSpacing: -1.5,
    ),

    // figma: M-Reguler Heading H2
    titleMedium: TextStyle(
      fontFamily: 'OpenSans',
      fontSize: 22,
      fontWeight: FontWeight.w400,
      letterSpacing: -1.5,
    ),

    // figma: M-Reguler Heading H3
    titleSmall: TextStyle(
      fontFamily: 'OpenSans',
      fontSize: 20,
      fontWeight: FontWeight.w400,
      letterSpacing: -1.5,
    ),

    // figma: M-Reguler Headline
    headlineMedium: TextStyle(
      fontFamily: 'OpenSans',
      fontSize: 17,
      fontWeight: FontWeight.w400,
      letterSpacing: -1.5,
    ),

    // figma: M-Reguler Body Large
    bodyLarge: TextStyle(
      fontFamily: 'OpenSans',
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: -1.5,
    ),

    // figma: M-Reguler Body Small
    bodySmall: TextStyle(
      fontFamily: 'OpenSans',
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: -1.5,
    ),

    // figma: M-Reguler caption
    labelLarge: TextStyle(
      fontFamily: 'OpenSans',
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: -1.5,
    ),
    
  );
}