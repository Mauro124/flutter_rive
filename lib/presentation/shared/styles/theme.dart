import 'package:flutter/material.dart';

import 'color_styles.dart';
import 'text_styles.dart';

const kPaddingApp = EdgeInsets.all(12.0);
const kPaddingAppHorizontal = EdgeInsets.symmetric(horizontal: 16.0);
const kRadiusCorner = 12.0;

final ThemeData lightTheme = ThemeData(
  fontFamily: 'Roboto',
  colorScheme: ColorScheme.fromSwatch().copyWith(
    brightness: Brightness.light,
    primary: kCoralColor,
    secondary: kBlueColor,
    background: kWhiteColor,
  ),
  textTheme: TextTheme(
    displayLarge: kHeadline1,
    displayMedium: kHeadline2,
    displaySmall: kHeadline3,
    headlineMedium: kHeadline4,
    headlineSmall: kHeadline5,
    titleLarge: kHeadline6,
    titleMedium: kSubtitle1,
    titleSmall: kSubtitle2,
    bodyLarge: kBodyText1,
    bodyMedium: kBodyText2,
    labelLarge: kButton,
    bodySmall: kCaption,
    labelSmall: kOverline,
  ),
  bottomAppBarTheme: const BottomAppBarTheme(color: kDarkBlueColor),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      padding: MaterialStateProperty.all(const EdgeInsets.all(16)),
      shadowColor: MaterialStateProperty.all(kBlackColor),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kRadiusCorner),
        ),
      ),
      foregroundColor: MaterialStateProperty.all(kWhiteColor),
      textStyle: MaterialStateProperty.all(kButton),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kRadiusCorner),
      ),
      side: const BorderSide(color: kGreenColor, width: 1),
      textStyle: kButton,
    ),
  ),
  cardTheme: CardTheme(
    color: kBlackColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(kRadiusCorner),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: kWhiteColor, width: 1),
      gapPadding: 16,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: kWhiteColor, width: 1),
      gapPadding: 16,
    ),
    fillColor: const Color.fromRGBO(0, 22, 22, 0),
    filled: true,
    labelStyle: const TextStyle(
      color: kWhiteColor,
    ),
  ),
  scaffoldBackgroundColor: kDarkBlueColor,
  appBarTheme: const AppBarTheme(
    backgroundColor: kDarkBlueColor,
    elevation: 0,
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
  snackBarTheme: const SnackBarThemeData(
    backgroundColor: kGreenColor,
    contentTextStyle: TextStyle(
      color: kWhiteColor,
    ),
  ),
);
