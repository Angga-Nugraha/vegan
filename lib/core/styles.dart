import 'package:flutter/material.dart';

const Color primaryColor = Color(0XFF41BA4D);
const Color secondaryColor = Color(0XFF2A966F);
const Color processColor = Color(0XFFF4C01E);
const Color backgroundColor = Color(0XFFFFFFFF);
const Color blackSwanColor = Color(0xFF0F0E0E);

const Color kRichBlack = Color(0xFF000814);
const Color kOxfordBlue = Color(0xFF001D3D);
const Color kPrussianBlue = Color(0xFF003566);
const Color kMikadoYellow = Color(0xFFffc300);
const Color kDavysGrey = Color(0xFF4B5358);
const Color kGrey = Color(0xFF222121);

const darkColorScheme = ColorScheme(
  primary: kGrey,
  primaryContainer: kGrey,
  secondary: kPrussianBlue,
  secondaryContainer: kPrussianBlue,
  surface: kRichBlack,
  background: kRichBlack,
  error: Colors.red,
  onPrimary: Colors.white,
  onSecondary: Colors.white,
  onSurface: Colors.white,
  onBackground: Colors.white,
  onError: Colors.white,
  brightness: Brightness.dark,
);
const lightColorScheme = ColorScheme(
  primary: primaryColor,
  primaryContainer: primaryColor,
  secondary: secondaryColor,
  secondaryContainer: secondaryColor,
  surface: backgroundColor,
  background: backgroundColor,
  error: Colors.red,
  onPrimary: kRichBlack,
  onSecondary: Colors.white,
  onSurface: Colors.grey,
  onBackground: Colors.grey,
  onError: Colors.grey,
  brightness: Brightness.light,
);

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: lightColorScheme,
  listTileTheme: const ListTileThemeData(
    iconColor: primaryColor,
    tileColor: backgroundColor,
    titleTextStyle: TextStyle(
        fontFamily: 'PTSerif',
        fontSize: 14,
        color: primaryColor,
        fontWeight: FontWeight.bold),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: primaryColor,
      foregroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      disabledBackgroundColor: Colors.grey.shade300,
    ),
  ),
  checkboxTheme: const CheckboxThemeData(
    checkColor: MaterialStatePropertyAll(Colors.white),
  ),
  iconTheme: const IconThemeData(color: secondaryColor),
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: const EdgeInsets.only(bottom: 15),
    hintStyle: const TextStyle(fontSize: 12, color: kDavysGrey),
    prefixIconColor: MaterialStateColor.resolveWith((states) =>
        states.contains(MaterialState.focused) ? kRichBlack : kDavysGrey),
    suffixIconColor: MaterialStateColor.resolveWith((states) =>
        states.contains(MaterialState.focused) ? kRichBlack : kDavysGrey),
    labelStyle: const TextStyle(color: kDavysGrey, fontSize: 12),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
        fontFamily: 'PTSerif',
        fontSize: 32,
        color: backgroundColor,
        fontWeight: FontWeight.bold),
    displayMedium: TextStyle(
        fontFamily: 'PTSerif',
        fontSize: 25,
        color: backgroundColor,
        fontWeight: FontWeight.bold),
    displaySmall: TextStyle(
        fontFamily: 'PTSerif',
        fontSize: 18,
        color: backgroundColor,
        fontWeight: FontWeight.bold),
    titleMedium: TextStyle(
        fontFamily: 'PTSerif',
        fontSize: 20,
        color: primaryColor,
        fontWeight: FontWeight.bold),
    titleSmall: TextStyle(
        fontFamily: 'PTSerif',
        fontSize: 14,
        color: primaryColor,
        fontWeight: FontWeight.bold),
    bodyLarge:
        TextStyle(fontFamily: 'PTSerif', fontSize: 14, color: blackSwanColor),
    bodyMedium:
        TextStyle(fontFamily: 'PTSerif', fontSize: 12, color: blackSwanColor),
    bodySmall:
        TextStyle(fontFamily: 'PTSerif', fontSize: 10, color: blackSwanColor),
  ),
);
ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: darkColorScheme,
  iconTheme: const IconThemeData(color: backgroundColor),
  inputDecorationTheme: const InputDecorationTheme(
    contentPadding: EdgeInsets.only(bottom: 15),
    hintStyle: TextStyle(fontSize: 12, color: kDavysGrey),
    labelStyle: TextStyle(color: Colors.white, fontSize: 12),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: primaryColor,
      foregroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      // disabledBackgroundColor: Colors.grey.shade300,
    ),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
        fontFamily: 'PTSerif',
        fontSize: 32,
        color: backgroundColor,
        fontWeight: FontWeight.bold),
    displayMedium: TextStyle(
        fontFamily: 'PTSerif',
        fontSize: 25,
        color: backgroundColor,
        fontWeight: FontWeight.bold),
    displaySmall: TextStyle(
        fontFamily: 'PTSerif',
        fontSize: 18,
        color: backgroundColor,
        fontWeight: FontWeight.bold),
    titleMedium: TextStyle(
        fontFamily: 'PTSerif',
        fontSize: 20,
        color: backgroundColor,
        fontWeight: FontWeight.bold),
    titleSmall: TextStyle(
        fontFamily: 'PTSerif',
        fontSize: 14,
        color: backgroundColor,
        fontWeight: FontWeight.bold),
    bodyLarge:
        TextStyle(fontFamily: 'PTSerif', fontSize: 14, color: backgroundColor),
    bodyMedium:
        TextStyle(fontFamily: 'PTSerif', fontSize: 12, color: backgroundColor),
    bodySmall:
        TextStyle(fontFamily: 'PTSerif', fontSize: 10, color: backgroundColor),
  ),
);
