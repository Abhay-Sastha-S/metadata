// File: lib/pages/view_patients_page.dart
import 'package:flutter/material.dart';
import 'patient_records_page.dart';

class ViewPatientsPage extends StatefulWidget {
  @override
  _ViewPatientsPageState createState() => _ViewPatientsPageState();
}

class _ViewPatientsPageState extends State<ViewPatientsPage> {
  final List<String> patients = [
    "Alice Johnson",
    "Abella Dinger",
    "Bob Brown",
    "Daniel Craig",
    "Emma Watson",
    "George Clooney",
    "Hannah Baker",
    "Jack Ryan",
    "John Doe",
    "John Jackson",
    "Jane Smith",
    "Laura Croft",
    "Mickey Mouse",
    "Nina Williams",
    "Oliver Queen",
    "Peter Parker",
    "Stephen Hawking",
    "Tony Stark",
    "Victor Hugo",
    "Zoe Saldana"
  ]; // Sample patient list

  List<String> filteredPatients = []; // List to hold filtered patients
  TextEditingController searchController = TextEditingController(); // Controller for the search field

  @override
  void initState() {
    super.initState();
    // Initialize the filtered list with all patients, sorted alphabetically
    filteredPatients = patients..sort();
  }

  void _filterPatients(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredPatients = patients..sort(); // Show all patients if the query is empty
      });
    } else {
      setState(() {
        filteredPatients = patients
            .where((patient) => patient.toLowerCase().contains(query.toLowerCase())) // Filter based on query
            .toList()
            ..sort(); // Sort the filtered list alphabetically
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Existing Patients",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        surfaceTintColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search bar
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
              onChanged: _filterPatients, // Call filter function on text change
            ),
            const SizedBox(height: 16),
            // Patient list
            Expanded(
              child: ListView.builder(
                itemCount: filteredPatients.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.white,
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ListTile(
                      title: Text(filteredPatients[index], style: TextStyle(color: Colors.black)),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PatientRecordsPage(patientName: filteredPatients[index]),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
