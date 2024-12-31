import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:msf/core/utills/colorconfig.dart';

ThemeData getTheme(bool isDark) {
  return isDark
      ? ThemeData.light().copyWith(
          colorScheme: const ColorScheme.light(
            primary: Colors.blueAccent,
            secondary: Colors.yellowAccent,
            onSecondary: secondryColor,
            tertiary: Colors.blueGrey,
            surface: Colors.blue,
          ),
          scaffoldBackgroundColor: bgColorW,
          drawerTheme: const DrawerThemeData(
            backgroundColor: bgDrawer,
          ),
          canvasColor: Colors.white,
          primaryColor: Colors.white,
          textTheme: GoogleFonts.poppinsTextTheme(
              ThemeData.light().textTheme.apply(bodyColor: Colors.black)),
        )
      : ThemeData.dark().copyWith(
          colorScheme: const ColorScheme.dark(
            primary: Colors.blueAccent,
            secondary: Colors.yellowAccent,
            tertiary: Colors.blueGrey,
            onSecondary: secondryColor,
            surface: Colors.blue,
          ),
          scaffoldBackgroundColor: const Color.fromARGB(255, 31, 30, 45),
          drawerTheme: const DrawerThemeData(
            backgroundColor: secondryColor,
          ),
          canvasColor: const Color(0xFF2A2D3E),
          primaryColor: Colors.white,
          textTheme: GoogleFonts.poppinsTextTheme(
              ThemeData.dark().textTheme.apply(bodyColor: Colors.white)),
        );
}
