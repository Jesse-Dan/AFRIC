import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config/color_config.dart';

class ThemeConfig {
  static final _baseTextTheme = TextTheme();

  static const double radius = 1.0;
  static final roundedShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(radius),
  );

  static final lightTheme = ThemeData(
    useMaterial3: false,
    brightness: Brightness.light,

    colorScheme: ColorScheme.fromSeed(
      seedColor: ColorConfig.primaryBlack,
      brightness: Brightness.light,
      primary: ColorConfig.primaryBlack,
      onPrimary: ColorConfig.textLight,
      secondary: ColorConfig.accentGray,
      onSecondary: ColorConfig.textLight,
      surface: ColorConfig.surfaceLight,
      background: ColorConfig.backgroundLight,
      onSurface: ColorConfig.textDark,
      onBackground: ColorConfig.textDark,
      error: Colors.red,
    ),

    scaffoldBackgroundColor: ColorConfig.backgroundLight,

    appBarTheme: AppBarTheme(
      backgroundColor: ColorConfig.backgroundLight,
      foregroundColor: ColorConfig.primaryBlack,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: GoogleFonts.monomakh(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: ColorConfig.primaryBlack,
      ),
      iconTheme: IconThemeData(color: ColorConfig.primaryBlack),
    ),

    cardTheme: CardThemeData(
      color: Colors.white,
      margin: const EdgeInsets.all(12),
      elevation: 1,
      shape: roundedShape,
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(radius)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: BorderSide(color: ColorConfig.borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: BorderSide(color: ColorConfig.primaryBlack, width: 1.6),
      ),
      labelStyle: TextStyle(color: ColorConfig.textSecondary),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: ColorConfig.primaryBlack,
        foregroundColor: ColorConfig.textLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        textStyle: GoogleFonts.monomakh(fontWeight: FontWeight.bold),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        elevation: 0,
        foregroundColor: ColorConfig.primaryBlack,
        backgroundColor: ColorConfig.backgroundLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
          side: BorderSide(color: ColorConfig.primaryBlack, width: 2),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        textStyle: GoogleFonts.monomakh(fontWeight: FontWeight.bold),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: ColorConfig.primaryBlack,
        textStyle: GoogleFonts.monomakh(fontWeight: FontWeight.w500),
      ),
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: ColorConfig.primaryBlack,
      unselectedItemColor: ColorConfig.textSecondary,
      elevation: 3,
      type: BottomNavigationBarType.fixed,
    ),

    chipTheme: ChipThemeData(
      backgroundColor: ColorConfig.surfaceLight,
      selectedColor: ColorConfig.primaryBlack,
      labelStyle: TextStyle(color: ColorConfig.textDark),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      secondaryLabelStyle: TextStyle(color: ColorConfig.textLight),
    ),

    dividerColor: ColorConfig.dividerColor,

    textTheme: GoogleFonts.monomakhTextTheme(_baseTextTheme).apply(
      bodyColor: ColorConfig.textDark,
      displayColor: ColorConfig.textDark,
    ),
  );

  static final darkTheme = ThemeData(
    useMaterial3: false,
    brightness: Brightness.dark,

    colorScheme: ColorScheme.dark(
      primary: ColorConfig.textLight,
      onPrimary: ColorConfig.textDark,
      secondary: ColorConfig.accentGray,
      onSecondary: ColorConfig.textLight,
      surface: ColorConfig.surfaceDark,
      background: ColorConfig.backgroundDark,
      onSurface: ColorConfig.textLight,
      onBackground: ColorConfig.textLight,
      error: const Color(0xFFFF5252),
    ),

    scaffoldBackgroundColor: ColorConfig.backgroundDark,
    canvasColor: ColorConfig.backgroundDark,

    appBarTheme: AppBarTheme(
      backgroundColor: ColorConfig.backgroundDark,
      foregroundColor: ColorConfig.textLight,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: GoogleFonts.monomakh(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: ColorConfig.textLight,
      ),
      iconTheme: IconThemeData(color: ColorConfig.textLight),
    ),

    cardTheme: CardThemeData(
      color: ColorConfig.surfaceDark,
      margin: const EdgeInsets.all(12),
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.5),
      shape: roundedShape,
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ColorConfig.surfaceDark,
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(40.0)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(40.0),
        borderSide: BorderSide(color: ColorConfig.borderColorDark),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(40.0),
        borderSide: BorderSide(color: ColorConfig.textLight, width: 1.6),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(40.0),
        borderSide: const BorderSide(color: Color(0xFFFF5252)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(40.0),
        borderSide: const BorderSide(color: Color(0xFFFF5252), width: 1.6),
      ),
      labelStyle: TextStyle(color: ColorConfig.textLight.withOpacity(.6)),
      hintStyle: TextStyle(color: ColorConfig.textLight.withOpacity(.4)),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: ColorConfig.textLight,
        foregroundColor: ColorConfig.textDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        textStyle: GoogleFonts.monomakh(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        elevation: 0,
        foregroundColor: ColorConfig.textLight,
        backgroundColor: ColorConfig.surfaceDark,
        side: BorderSide(color: ColorConfig.textLight, width: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        textStyle: GoogleFonts.monomakh(fontWeight: FontWeight.bold),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: ColorConfig.textLight,
        textStyle: GoogleFonts.monomakh(fontWeight: FontWeight.w500),
      ),
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: ColorConfig.textLight,
      foregroundColor: ColorConfig.textDark,
      elevation: 6,
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: ColorConfig.surfaceDark,
      selectedItemColor: ColorConfig.textLight,
      unselectedItemColor: ColorConfig.textSecondary,
      elevation: 8,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: GoogleFonts.monomakh(
        fontWeight: FontWeight.w600,
        fontSize: 12,
      ),
      unselectedLabelStyle: GoogleFonts.monomakh(
        fontWeight: FontWeight.w400,
        fontSize: 11,
      ),
    ),

    chipTheme: ChipThemeData(
      backgroundColor: ColorConfig.accentGray.withOpacity(.3),
      selectedColor: ColorConfig.textLight,
      labelStyle: TextStyle(color: ColorConfig.textLight),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      secondaryLabelStyle: TextStyle(color: ColorConfig.textDark),
      brightness: Brightness.dark,
    ),

    dividerColor: ColorConfig.borderColorDark,
    dividerTheme: DividerThemeData(color: ColorConfig.borderColorDark),

    iconTheme: IconThemeData(color: ColorConfig.textLight, size: 24),

    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: ColorConfig.textLight,
      linearTrackColor: ColorConfig.textLight.withOpacity(.2),
      circularTrackColor: ColorConfig.textLight.withOpacity(.2),
    ),

    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return ColorConfig.textLight;
        }
        return ColorConfig.textSecondary;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return ColorConfig.textLight.withOpacity(.5);
        }
        return ColorConfig.textSecondary.withOpacity(.3);
      }),
    ),

    sliderTheme: SliderThemeData(
      activeTrackColor: ColorConfig.textLight,
      inactiveTrackColor: ColorConfig.accentGray,
      thumbColor: ColorConfig.textLight,
      overlayColor: ColorConfig.textLight.withOpacity(.2),
    ),

    dialogTheme: DialogThemeData(
      backgroundColor: ColorConfig.surfaceDark,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 8,
      titleTextStyle: GoogleFonts.monomakh(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: ColorConfig.textLight,
      ),
      contentTextStyle: GoogleFonts.monomakh(
        fontSize: 14,
        color: ColorConfig.textLight.withOpacity(.8),
      ),
    ),

    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: ColorConfig.surfaceDark,
      modalBackgroundColor: ColorConfig.surfaceDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      elevation: 8,
    ),

    snackBarTheme: SnackBarThemeData(
      backgroundColor: ColorConfig.surfaceDark,
      contentTextStyle: GoogleFonts.monomakh(
        color: ColorConfig.textLight,
        fontSize: 14,
      ),
      actionTextColor: ColorConfig.textLight,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),

    textTheme: GoogleFonts.monomakhTextTheme(_baseTextTheme).apply(
      bodyColor: ColorConfig.textLight,
      displayColor: ColorConfig.textLight,
      decorationColor: ColorConfig.textLight,
    ),
    primaryTextTheme: GoogleFonts.monomakhTextTheme(_baseTextTheme).apply(
      bodyColor: ColorConfig.textLight,
      displayColor: ColorConfig.textLight,
    ),
  );
}
