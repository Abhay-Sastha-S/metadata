// File: lib/main.dart
import 'package:flutter/material.dart';
import 'pages/landing_page.dart';

void main() {
  runApp(DoctorApp());
}

class DoctorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
  debugShowCheckedModeBanner: false,

      title: 'MetaData',
      theme: ThemeData(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.white,
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.black),
          bodyMedium: TextStyle(color: Colors.black),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, backgroundColor: Colors.black, // White text color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20), // 20 pixel border radius
            ),
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),
        inputDecorationTheme:InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),  // 20 pixel border radius for input fields
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
      ),
      home: LandingPage(),
    );
  }
}
