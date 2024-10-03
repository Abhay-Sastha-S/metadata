import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class LiveGraphPage extends StatefulWidget {
  final int duration; // Duration in minutes

  LiveGraphPage({required this.duration});

  @override
  _LiveGraphPageState createState() => _LiveGraphPageState();
}

class _LiveGraphPageState extends State<LiveGraphPage> {
  final List<FlSpot> _dataPoints = [];
  final Random _random = Random();
  Timer? _timer;
  double _time = 0.0; // Tracks the time (x-axis)

  @override
  void initState() {
    super.initState();
    _startGeneratingData(); // Start data generation when the page is loaded
  }

  // Generate EMG data simulating the wrist movement
  double _generateEmgValue(double time) {
    double frequency = 0.5; // Frequency for the muscle opening-closing cycle (in Hz)
    double amplitude = 5.0; // Amplitude of the sine wave
    double noise = (_random.nextDouble() - 0.5) * 2; // Random noise added to the signal

    // Calculate the EMG signal as a sine wave
    double emgSignal = amplitude * sin(2 * pi * frequency * time) + noise;
    
    // Clamp the values between 0 and 10
    return emgSignal.clamp(0, 10);
  }

  // Start generating data at regular intervals
  void _startGeneratingData() {
    int interval = 1; // Interval in seconds for generating data points
    int totalDurationInSeconds = widget.duration * 60;

    // Timer to update the data every second
    _timer = Timer.periodic(Duration(seconds: interval), (timer) {
      setState(() {
        // Stop when the total duration is reached
        if (_time >= totalDurationInSeconds) {
          _timer?.cancel();
        } else {
          // Generate new data point and update the time
          double yValue = _generateEmgValue(_time);
          _dataPoints.add(FlSpot(_time, yValue));
          _time += interval.toDouble();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Live EMG Data Graph"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LineChart(
          LineChartData(
            titlesData: FlTitlesData(show: true),
            borderData: FlBorderData(show: true),
            gridData: FlGridData(show: true),
            // axisTitleData: FlAxisTitleData(
            //   leftTitle: AxisTitle(showTitle: true, titleText: 'EMG Signal'),
            //   bottomTitle: AxisTitle(showTitle: true, titleText: 'Time (seconds)'),
            // ),
            minX: 0,
            maxX: _dataPoints.isNotEmpty ? _dataPoints.last.x + 10 : 10, // Dynamically adjust maxX based on data points
            minY: 0,
            maxY: 10, // EMG signal range (0 to 10)
            lineBarsData: [
              LineChartBarData(
                spots: _dataPoints,
                isCurved: true, // Make the graph line curved to simulate smooth movement
                color: Colors.black,
                barWidth: 2,
                belowBarData: BarAreaData(show: false), // Hide the shaded area below the line
                dotData: FlDotData(show: false), // Hide the dots on the line
              ),
            ],
          ),
        ),
      ),
    );
  }
}
