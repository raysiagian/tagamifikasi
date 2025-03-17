import 'package:flutter/material.dart';

class LocalColor{
  // transparan
  static const int _transparent = 0x00000000;
  static const MaterialColor transparent = MaterialColor(
    _transparent, 
      <int, Color>{
      500: Color(LocalColor._transparent),
    },
  );

  // Warna Primer Biru
  static const int _primary = 0xFF3861FB;
    static const MaterialColor primary = MaterialColor(
    _primary, 
      <int, Color>{
      500: Color(LocalColor._primary),
    },
  );

  static const int _hover = 0xFF1E4EF8;
    static const MaterialColor hover = MaterialColor(
    _hover, 
      <int, Color>{
      500: Color(LocalColor._hover),
    },
  );
  
  static const int _focused = 0xFF1A46E6;
    static const MaterialColor focused = MaterialColor(
    _focused, 
      <int, Color>{
      500: Color(LocalColor._focused),
    },
  );

    static const int _active = 0xFF153BCC;
    static const MaterialColor active = MaterialColor(
    _active, 
      <int, Color>{
      500: Color(LocalColor._active),
    },
  );

    static const int _disabled = 0xFFA3B5FD;
    static const MaterialColor disabled = MaterialColor(
    _disabled, 
      <int, Color>{
      500: Color(LocalColor._disabled),
    },
  );
  
}