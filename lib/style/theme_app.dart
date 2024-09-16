import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoapp/style/app_colors.dart';

class ThemeApp {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primeryColor,
      elevation: 0,
      iconTheme: IconThemeData(
        color: AppColors.whiteColor,
      ),
    ),
    textTheme: TextTheme(
      titleLarge: GoogleFonts.cairo(
        color: AppColors.whiteColor,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: GoogleFonts.cairo(
        color: AppColors.blackColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: GoogleFonts.cairo(
        color: AppColors.whiteColor,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: GoogleFonts.cairo(
        color: AppColors.blackColor,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: GoogleFonts.cairo(
        color: AppColors.primeryColor,
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
      bodySmall: GoogleFonts.cairo(
        color: AppColors.blackColor,
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
    ),
    iconTheme: const IconThemeData(
      color: AppColors.whiteColor,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primeryColor,
        iconSize: 20,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(32),
          ),
          side: BorderSide(
            color: AppColors.whiteColor,
            width: 4,
          ),
        )),
    bottomAppBarTheme: const BottomAppBarTheme(
      color: AppColors.whiteColor,
      shape: CircularNotchedRectangle(),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        iconColor: WidgetStateProperty.all(AppColors.whiteColor),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      )
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        minimumSize: WidgetStateProperty.all(const Size(100, 48)),
        backgroundColor: WidgetStateProperty.all(AppColors.primeryColor),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      )
    ),
  );
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.backgroundDarkColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primeryColor,
      elevation: 0,
      iconTheme: IconThemeData(
        color: AppColors.whiteColor,
      ),
    ),
    textTheme: TextTheme(
      titleLarge: GoogleFonts.cairo(
        color: AppColors.whiteColor,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: GoogleFonts.cairo(
        color: AppColors.whiteColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: GoogleFonts.cairo(
        color: AppColors.whiteColor,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: GoogleFonts.cairo(
        color: AppColors.whiteColor,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: GoogleFonts.cairo(
        color: AppColors.primeryColor,
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
      bodySmall: GoogleFonts.cairo(
        color: AppColors.whiteColor,
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
    ),
    iconTheme: const IconThemeData(
      color: AppColors.whiteColor,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primeryColor,
        iconSize: 20,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(32),
          ),
          side: BorderSide(
            color: AppColors.whiteColor,
            width: 4,
          ),
        )),
    bottomAppBarTheme: const BottomAppBarTheme(
      color: AppColors.cardDarkColor,
      shape: CircularNotchedRectangle(),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        iconColor: WidgetStateProperty.all(AppColors.whiteColor),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      )
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        minimumSize: WidgetStateProperty.all(const Size(100, 48)),
        backgroundColor: WidgetStateProperty.all(AppColors.primeryColor),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      )
    ),
  );
}