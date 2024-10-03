// File: lib/pages/patient_records_page.dart
import 'package:flutter/material.dart';
import 'package:metadata/pages/duration_page.dart';
import 'package:metadata/pages/new_record_page.dart';

class PatientRecordsPage extends StatefulWidget {
  final String patientName;

  PatientRecordsPage({required this.patientName});

  @override
  _PatientRecordsPageState createState() => _PatientRecordsPageState();
}

class _PatientRecordsPageState extends State<PatientRecordsPage> {
  // Sample data for demonstration purposes
  final int age = 30; // Patient's age
  final String sex = "Male"; // Patient's sex

  // The selected muscles map
  final Map<String, List<String>> selectedMuscles = {
    'Right Hand': ['Biceps', 'Forearm'],
    'Left Hand': [],
    'Right Leg': ['Quadriceps'],
    'Left Leg': ['Hamstring'],
  };

  List<Map<String, dynamic>> pastSessions = [
    {
      'date': '15-09-2023',
      'details': 'Session focused on strength training.',
    },
    {
      'date': '17-09-2023',
      'details': 'Cardio and endurance training session.',
    },
    {
      'date': '01-01-2024',
      'details': 'Recovery session with stretching exercises.',
    },
  ];

  bool isAscending = true; // Track sorting order

  void _sortSessions() {
    setState(() {
      if (isAscending) {
        pastSessions.sort((a, b) => DateTime.parse(b['date'].split('-').reversed.join('-')).compareTo(DateTime.parse(a['date'].split('-').reversed.join('-'))));
      } else {
        pastSessions.sort((a, b) => DateTime.parse(a['date'].split('-').reversed.join('-')).compareTo(DateTime.parse(b['date'].split('-').reversed.join('-'))));
      }
      isAscending = !isAscending; // Toggle sorting order
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get the width of the screen
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Past Records"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Patient Info Card
            Container(
              width: screenWidth,
              child: Card(
                color: Colors.white,
                elevation: 4,
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Full Name
                      Row(
                        children: [
                          const Text(
                            'Full Name: ',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.patientName,
                            style: const TextStyle(fontSize: 22),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Display Age and Sex on the same line
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'Age: ',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '$age',
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(width: 30),
                          const Text(
                            'Sex: ',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            sex,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      
                      // Targeted Muscles Table
const Text('Targeted Muscles:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
const SizedBox(height: 8),
Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20), // Rounded corners
    //border: Border.all(color: Colors.black, width: 2), // Border around the container
  ),
  child: Table(
    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
    children: [
      TableRow(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)), // Rounded edges for left cell
            ),
            padding: const EdgeInsets.all(8.0),
            child: const Text('Left Hand', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20)), // Rounded edges for right cell
            ),
            padding: const EdgeInsets.all(8.0),
            child: const Text('Right Hand', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      TableRow(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(8.0),
            child: Text(selectedMuscles['Left Hand']!.isEmpty ? "None" : selectedMuscles['Left Hand']!.join(', ')),
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(8.0),
            child: Text(selectedMuscles['Right Hand']!.isEmpty ? "None" : selectedMuscles['Right Hand']!.join(', ')),
          ),
        ],
      ),
      TableRow(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20)), // Rounded edge for left cell
            ),
            padding: const EdgeInsets.all(8.0),
            child: const Text('Left Leg', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(20)), // Rounded edge for right cell
            ),
            padding: const EdgeInsets.all(8.0),
            child: const Text('Right Leg', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),  
        ],
      ),
      TableRow(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(8.0),
            child: Text(selectedMuscles['Left Leg']!.isEmpty ? "None" : selectedMuscles['Left Leg']!.join(', ')),
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(8.0),
            child: Text(selectedMuscles['Right Leg']!.isEmpty ? "None" : selectedMuscles['Right Leg']!.join(', ')),
          ),
        ],
      ),
    ],
  ),
),

                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Previous Sessions Label with Sort Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Previous Sessions',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    const Text(
                      'Sort: ',
                      style: TextStyle(fontSize: 16, color: Colors.grey), // Faint text
                    ),
                    IconButton(
                      icon: Icon(isAscending ? Icons.arrow_upward : Icons.arrow_downward),
                      onPressed: _sortSessions, // Call the sort function when pressed
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),

            // ExpansionTile for Past Sessions
            Expanded(
              child: ListView.builder(
                itemCount: pastSessions.length,
                itemBuilder: (context, index) {
                  final session = pastSessions[index];
                  return Card(
                    color: Colors.white,
                    elevation: 2,
                    margin: const EdgeInsets.only(bottom: 16),
                    child: ExpansionTile(
                      title: Text('${session['date']}', style: const TextStyle(fontWeight: FontWeight.bold)),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(session['details']),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // Floating Action Button for adding new records
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to Add New Record Page (replace with your navigation logic)
          Navigator.push(context, MaterialPageRoute(builder: (context) => DurationSelectionPage()));
        },
        child: const Icon(Icons.add),
        tooltip: 'Add New Record',
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        foregroundColor: Colors.white,
      ),
    );
  }
}
