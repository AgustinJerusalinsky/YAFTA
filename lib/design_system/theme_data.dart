import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yafta/design_system/colors.dart';

final baseTheme =
    ThemeData(useMaterial3: true, textTheme: GoogleFonts.interTextTheme());

final lightTheme = baseTheme.copyWith(colorScheme: lightColorScheme);

final darkTheme = baseTheme.copyWith(colorScheme: darkColorScheme);
