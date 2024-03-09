import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unicrush/presentation/configs/configs.dart';

class ThemeController extends GetxController {
  late ThemeData _themeData;

  ThemeData get themeData => _themeData;

  @override
  void onInit() {
    _themeData = _buildTheme();
    super.onInit();
  }

  ThemeData _buildTheme() {
    return ThemeData(
      fontFamily: ksFontFamily,
      appBarTheme: appBarTheme(),
      useMaterial3: true,
      scaffoldBackgroundColor: kPrimary,
      textTheme: textTheme().apply(
        bodyColor: kBlack,
        displayColor: kBlack,
      ),
      textSelectionTheme: textSelectionTheme(),
      colorScheme: colorScheme(),
      iconTheme: iconTheme(),
      highlightColor: kTransparent,
      focusColor: kPrimary,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      inputDecorationTheme: inputDecorationTheme(),
    );
  }

  AppBarTheme appBarTheme() {
    return AppBarTheme(
      backgroundColor: kTransparent,
      elevation: s0,
      titleTextStyle: TextStyle(
        fontSize: s26, // Adjust as needed
        fontWeight: FontWeight.w700,
      ),
      foregroundColor: kBlack,
      toolbarHeight: s100,
    );
  }

  InputDecorationTheme inputDecorationTheme() {
    return const InputDecorationTheme(
      filled: true,
      fillColor: kTransparent,
      alignLabelWithHint: true,
    );
  }

  TextTheme textTheme() {
    return TextTheme(
      headline1: headlineLarge,
      headline2: headlineMedium,
      headline3: headlineSmall,
      headline4: titleLarge,
      headline5: titleMedium,
      headline6: titleSmall,
      subtitle1: labelLarge,
      bodyText1: bodyLarge,
      bodyText2: bodyMedium,
      caption: bodySmall,
    );
  }

  TextStyle get headlineLarge => const TextStyle(
        fontSize: s96,
        fontWeight: FontWeight.w600,
      );
  TextStyle get headlineMedium => const TextStyle(
        fontSize: s70,
        fontWeight: FontWeight.w600,
      );
  TextStyle get headlineSmall => const TextStyle(
        fontSize: s60,
        fontWeight: FontWeight.w700,
      );
  TextStyle get titleLarge => const TextStyle(
        fontSize: s42,
        fontWeight: FontWeight.w700,
      );
  TextStyle get titleMedium => const TextStyle(
        fontSize: s38,
        fontWeight: FontWeight.w700,
      );
  TextStyle get titleSmall => const TextStyle(
        fontSize: s32,
        fontWeight: FontWeight.w700,
      );
  TextStyle get labelLarge => const TextStyle(
        fontSize: s26,
        fontWeight: FontWeight.w700,
      );
  TextStyle get bodyLarge => const TextStyle(
        fontSize: s18,
        fontWeight: FontWeight.w500,
      );
  TextStyle get bodyMedium => const TextStyle(
        fontSize: s14,
        fontWeight: FontWeight.w500,
      );
  TextStyle get bodySmall => const TextStyle(
        fontSize: s12,
        fontWeight: FontWeight.w500,
      );

  TextSelectionThemeData textSelectionTheme() {
    return TextSelectionThemeData(
      cursorColor: kSecondary,
      selectionColor: kSecondary,
      selectionHandleColor: kSecondary,
    );
  }

  IconThemeData iconTheme() {
    return const IconThemeData(
      color: kBlack,
    );
  }

  ColorScheme colorScheme() {
    return ColorScheme(
      brightness: Brightness.light,
      primary: kPrimary,
      onPrimary: kPrimary,
      secondary: kSecondary,
      onSecondary: kSecondary,
      error: kRed,
      onError: kRed100,
      background: kWhite,
      onBackground: kWhite,
      surface: kGrey100,
      onSurface: kGrey100,
    );
  }
}
