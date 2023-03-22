import 'package:flutter/material.dart';
import 'package:yafta/theme/colors.dart';

final baseTheme = ThemeData(useMaterial3: true);

final lightTheme = baseTheme.copyWith(colorScheme: lightColorScheme);

final darkTheme = baseTheme.copyWith(colorScheme: darkColorScheme);
