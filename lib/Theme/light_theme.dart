import 'package:flutter/material.dart';
import 'package:yaseen/Theme/colors.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    background: MyColors.backgroundLight,
    primary: MyColors.mainColor,
    outline: Colors.white,
  ),
);
