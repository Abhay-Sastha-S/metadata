import 'package:flutter/material.dart';
import 'new_record_page.dart'; // Import the live graph page

class DurationSelectionPage extends StatefulWidget {
  @override
  _DurationSelectionPageState createState() => _DurationSelectionPageState();
}

class _DurationSelectionPageState extends State<DurationSelectionPage> {
  int? _selectedDuration; // Holds the selected duration in minutes
  int _customDuration = 0; // Holds the custom duration value

  void _navigateToGraphPage() {
    if (_selectedDuration != null) {
      int duration = _selectedDuration == 0 ? _customDuration : _selectedDuration!;
      if (duration > 0) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LiveGraphPage(duration: duration),
          ),
        );
      }
    }
  }

  Widget _buildDurationOption(String title, int value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: _selectedDuration == value ? Colors.black : Colors.white, // Black if selected, white otherwise
        borderRadius: BorderRadius.circular(20), // Curved edges
        border: Border.all(color: Colors.black), // Black border for the container
      ),
      child: ListTile(
        title: Text(
          value == 0 && _selectedDuration == 0 ? "Custom Duration: $_customDuration minutes" : title,
          style: TextStyle(color: _selectedDuration == value ? Colors.white : Colors.black), // Change text color based on selection
        ),
        leading: Radio<int>(
          value: value,
          groupValue: _selectedDuration,
          onChanged: (int? newValue) {
            setState(() {
              _selectedDuration = newValue;
              // Reset custom duration when selecting other options
              if (newValue != 0) {
                _customDuration = 0;
              }
            });
            if (value == 0) {
              _showCustomDurationDialog(); // Show dialog for custom duration
            }
          },
          activeColor: Colors.white, // White color for the radio button
        ),
      ),
    );
  }

  void _showCustomDurationDialog() {
    final TextEditingController _durationController = TextEditingController(text: '$_customDuration');

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            "Custom Duration",
            style: TextStyle(fontSize: 18), // Reduced font size
          ),
          titlePadding: EdgeInsets.symmetric(vertical: 10, horizontal: 65),
          content: Column(
            mainAxisSize: MainAxisSize.min, // Ensure the dialog doesn't take too much space
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        if (_customDuration > 0) {
                          _customDuration--;
                          _durationController.text = '$_customDuration'; // Update the text field
                        }
                      });
                    },
                  ),
                  Container(
                    width: 80, // Fixed width to make it smaller
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10), // Smaller padding
                      ),
                      keyboardType: TextInputType.number,
                      controller: _durationController,
                      onChanged: (value) {
                        final intValue = int.tryParse(value);
                        if (intValue != null) {
                          setState(() {
                            _customDuration = intValue;
                          });
                        }
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        _customDuration++;
                        _durationController.text = '$_customDuration'; // Update the text field
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          actions: [
  Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween, // Aligns buttons to the edges
    children: [
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text(
          "Cancel",
          style: TextStyle(color: Colors.black, fontSize: 16), // Black font color
        ),
      ),
      TextButton(
        onPressed: () {
          setState(() {
            _selectedDuration = 0; // Set to custom duration option
          });
          Navigator.of(context).pop();
        },
        child: Text(
          "Ok",
          style: TextStyle(color: Colors.black, fontSize: 16), // Black font color
        ),
      ),
    ],
  ),
],

        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Session Duration"),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        surfaceTintColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Choose a session duration:",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            // Duration Options
            _buildDurationOption("15 Minutes", 15),
            _buildDurationOption("30 Minutes", 30),
            _buildDurationOption("Custom Duration", 0),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _navigateToGraphPage,
              child: Text("Show Graph"),
            ),
          ],
        ),
      ),
    );
  }
}
