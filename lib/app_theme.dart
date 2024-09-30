import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Apptheme {
  ThemeData appLightTheme(BuildContext context) {
    final ss = MediaQuery.of(context).size;
    if (Platform.isAndroid) {
      // final height = ss.height*.05;
    }
    return ThemeData(
        scaffoldBackgroundColor: Colors.grey.shade100,
        appBarTheme: AppBarTheme(backgroundColor: Colors.grey.shade100),
        brightness: Brightness.light,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.cyan,
          elevation: 10,
          enableFeedback: true,
          selectedIconTheme: const IconThemeData(color: Colors.white),
          unselectedIconTheme: const IconThemeData(color: Colors.white),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          selectedLabelStyle:
          GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          unselectedLabelStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
        ),
        tabBarTheme: TabBarTheme(
          dividerColor: Colors.grey.shade200,
          labelColor: Colors.cyan,
          labelStyle:
              const TextStyle(fontFamily: 'Popin', fontWeight: FontWeight.bold),
          indicatorColor: Colors.cyan,
          overlayColor: WidgetStateProperty.all(Colors.transparent),
        ),
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
                overlayColor: Colors.deepOrange,
                backgroundColor: Colors.cyan,
                iconColor: Colors.grey.shade200,
                foregroundColor: Colors.grey.shade100,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                minimumSize: Platform.isAndroid
                    ? Size(ss.width * .1, ss.height * .05)
                    : Size(ss.width * .1, ss.height * .1),
                textStyle: const TextStyle(fontWeight: FontWeight.bold))));
  }

  ThemeData appDarkTheme(BuildContext context) {
    final ss = MediaQuery.of(context).size;
    return ThemeData(
        scaffoldBackgroundColor: Colors.grey.shade800,
        appBarTheme: AppBarTheme(backgroundColor: Colors.grey.shade800),
        brightness: Brightness.dark,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.grey.shade800,
          elevation: 10,
          enableFeedback: true,
          selectedIconTheme: const IconThemeData(color: Colors.green),
          unselectedIconTheme: IconThemeData(color: Colors.grey.shade100),
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.white,
          selectedLabelStyle: const TextStyle(color: Colors.red),
          unselectedLabelStyle: const TextStyle(color: Colors.white),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
        ),
        tabBarTheme: TabBarTheme(
          dividerColor: Colors.grey.shade700,
          labelColor: Colors.green,
          indicatorColor: Colors.green,
          overlayColor: WidgetStateProperty.all(Colors.transparent),
        ),
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
                overlayColor: Colors.white,
                backgroundColor: Colors.green,
                iconColor: Colors.grey.shade100,
                foregroundColor: Colors.grey.shade100,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                minimumSize: Platform.isAndroid
                    ? Size(ss.width * .1, ss.height * .05)
                    : Size(ss.width * .1, ss.height * .1),
                textStyle: const TextStyle(fontWeight: FontWeight.bold))));
  }
}
