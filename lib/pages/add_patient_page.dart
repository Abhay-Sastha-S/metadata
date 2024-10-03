import 'package:flutter/material.dart';
import 'patient_records_page.dart';

class AddPatientPage extends StatefulWidget {
  @override
  _AddPatientPageState createState() => _AddPatientPageState();
}

class _AddPatientPageState extends State<AddPatientPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController(text: '0'); // Default age set to 0
  String gender = ''; // Store the selected gender

  // Store selected muscles for each body part
  Map<String, List<String>> selectedMuscles = {
    'Right Hand': [],
    'Left Hand': [],
    'Right Leg': [],
    'Left Leg': [],
  };

  int _currentStep = 0; // Track the current step

  // Total number of steps (Name, Age, Gender, Muscles)
  final int _totalSteps = 4;

  void _nextStep() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        if (_currentStep < _totalSteps - 1) {
          _currentStep++;
        } else {
          // If the final step is reached, submit the form
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PatientRecordsPage(patientName: nameController.text),
            ),
          );
        }
      });
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  }

  // Increment age
  void _incrementAge() {
    int currentAge = int.tryParse(ageController.text) ?? 0;
    setState(() {
      ageController.text = (currentAge + 1).toString();
    });
  }

  // Decrement age
  void _decrementAge() {
    int currentAge = int.tryParse(ageController.text) ?? 0;
    if (currentAge > 0) {
      setState(() {
        ageController.text = (currentAge - 1).toString();
      });
    }
  }

  // List of possible muscles in each body part
  final Map<String, List<String>> muscleGroups = {
    'Right Hand': ['Biceps', 'Triceps', 'Forearm Muscles'],
    'Left Hand': ['Biceps', 'Triceps', 'Forearm Muscles'],
    'Right Leg': ['Quadriceps', 'Hamstrings', 'Calf Muscles'],
    'Left Leg': ['Quadriceps', 'Hamstrings', 'Calf Muscles'],
  };

  // Interactive body part selection
  Widget _buildBodyPartSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select a body part to target specific muscles',
          style: TextStyle(fontSize: 12.0, color: Colors.grey),
        ),
        const SizedBox(height: 16),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: muscleGroups.keys.map((bodyPart) {
            return ElevatedButton(
              onPressed: () {
                _showMuscleSelectionDialog(bodyPart);
              },
              child: Text(bodyPart),
            );
          }).toList(),
        ),
      ],
    );
  }

  // Dialog to select muscles in a specific body part
  void _showMuscleSelectionDialog(String bodyPart) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Select muscles in $bodyPart'),
          content: StatefulBuilder(
            builder: (context, setDialogState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: muscleGroups[bodyPart]!.map((muscle) {
                  return CheckboxListTile(
                    checkColor: const Color.fromARGB(255, 255, 255, 255),
                    activeColor: Colors.black,
                    title: Text(muscle),
                    value: selectedMuscles[bodyPart]!.contains(muscle),
                    onChanged: (bool? isChecked) {
                      setDialogState(() {
                        if (isChecked == true) {
                          selectedMuscles[bodyPart]!.add(muscle);
                        } else {
                          selectedMuscles[bodyPart]!.remove(muscle);
                        }
                      });
                    },
                  );
                }).toList(),
              );
            },
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Done'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFormFields() {
    switch (_currentStep) {
      case 0:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Please enter full name',
              style: TextStyle(fontSize: 12.0, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
              validator: (value) => value!.isEmpty ? 'Please enter a name' : null,
            ),
          ],
        );
      case 1:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter appropriate age',
              style: TextStyle(fontSize: 12.0, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Decrease button
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: _decrementAge,
                ),
                // Age input field (allows manual input and buttons adjustment)
                Container(
                  width: 50,
                  child: TextFormField(
                    key: const ValueKey('age'),
                    textAlign: TextAlign.center,
                    controller: ageController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      // Ensure the value entered manually is valid
                      if (int.tryParse(value) == null || value.isEmpty) {
                        ageController.text = '0'; // Set to 0 if invalid
                      }
                    },
                    validator: (value) {
                      int? ageValue = int.tryParse(value!);
                      if (ageValue == null || ageValue < 0) {
                        return 'Please enter a valid age';
                      }
                      return null;
                    },
                  ),
                ),
                // Increase button
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _incrementAge,
                ),
              ],
            ),
          ],
        );
      case 2:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select biologically assigned sex',
              style: TextStyle(fontSize: 12.0, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Column(
              children: [
                ListTile(
                  title: const Text('Male'),
                  leading: Radio<String>(
                    value: 'Male',
                    groupValue: gender,
                    onChanged: (value) {
                      setState(() {
                        gender = value!;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Female'),
                  leading: Radio<String>(
                    value: 'Female',
                    groupValue: gender,
                    onChanged: (value) {
                      setState(() {
                        gender = value!;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Others'),
                  leading: Radio<String>(
                    value: 'Others',
                    groupValue: gender,
                    onChanged: (value) {
                      setState(() {
                        gender = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        );
      case 3:
        return _buildBodyPartSelection();
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "New Patient",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress Bar
            LinearProgressIndicator(
              value: (_currentStep + 1) / _totalSteps,
              backgroundColor: Colors.grey[300],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.black),
            ),
            const SizedBox(height: 24),

            // Form Fields
            Expanded(
              child: Form(
                key: _formKey,
                child: _buildFormFields(), // Show form fields based on the current step
              ),
            ),

            // Custom controls at the bottom right
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (_currentStep > 0) // Show Back button from the second step onward
                  ElevatedButton(
                    onPressed: _previousStep,
                    child: const Text('Back'),
                  ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _nextStep,
                  child: _currentStep == _totalSteps - 1
                      ? const Text('Submit')
                      : const Text('Next'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
