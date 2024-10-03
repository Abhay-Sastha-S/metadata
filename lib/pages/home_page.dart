// File: lib/pages/home_page.dart
import 'package:flutter/material.dart';
import 'add_patient_page.dart';
import 'view_patients_page.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _showButtons = false;
  bool _showText = true; // Control when to show the text

  @override
  void initState() {
    super.initState();
    // Delay showing the buttons after a set duration (matching the typing effect duration)
    Future.delayed(const Duration(seconds: 4), () {
      setState(() {
        _showText = false; // Hide text after typing animation finishes
        _showButtons = true; // Show buttons
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main content
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Show the text during the typing animation phase
                if (_showText)
                  AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'Welcome,\nDr Abhay Sastha',
                        textStyle: const TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                        ),
                        speed: const Duration(milliseconds: 100), // Typing speed
                        cursor: '|', // Typing cursor
                      ),
                    ],
                    totalRepeatCount: 1,
                    isRepeatingAnimation: false,
                  ),
                const SizedBox(height: 40),
                // Show buttons after the typing animation finishes
                if (_showButtons) ...[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddPatientPage()),
                      );
                    },
                    child: const Text("Add New Patient"),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ViewPatientsPage()),
                      );
                    },
                    child: const Text("View Existing Patients"),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
