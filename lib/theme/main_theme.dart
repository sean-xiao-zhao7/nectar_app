import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Theme for the entire app
///
/// Define the "yellow" colours used.
/// Fonts are Lora and Inter.
/// Drawer has its own colours.
ThemeData initTheme(Brightness brightness) {
  final baseTheme = ThemeData(brightness: brightness);

  // define static colors for the entire app
  const nectarLightYellow = Color.fromARGB(255, 255, 209, 72);
  const nectarDarkYellow = Color.fromARGB(255, 169, 127, 0);
  const nectarDarkerYellow = Color.fromARGB(255, 95, 68, 0);
  const nectarWhite = Colors.white;
  const nectarRed = Colors.red;

  return baseTheme.copyWith(
    scaffoldBackgroundColor: nectarLightYellow,
    colorScheme: ColorScheme(
      primary: nectarLightYellow,
      onPrimary: nectarWhite,
      secondary: nectarDarkYellow,
      onSecondary: nectarWhite,
      tertiary: nectarDarkerYellow,
      onTertiary: nectarWhite,
      error: nectarRed,
      onError: nectarWhite,
      surface: nectarLightYellow,
      onSurface: nectarDarkerYellow,
      brightness: Brightness.light,
    ),
    appBarTheme: AppBarTheme(
      iconTheme: const IconThemeData(color: nectarDarkYellow),
      backgroundColor: nectarWhite,
      titleTextStyle: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: nectarDarkYellow,
      ),
    ),
    textTheme: GoogleFonts.interTextTheme().copyWith(
      headlineLarge: GoogleFonts.lora(),
      headlineMedium: GoogleFonts.lora(),
      headlineSmall: GoogleFonts.lora(),
    ),
    drawerTheme: const DrawerThemeData(),
  );
}
