import 'package:flutter/material.dart';
import 'package:prescription_decoder/ui/scan.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          // Buttons: History and Medication
          const SizedBox(
            height:30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0), // Add padding here
                child: ElevatedButton(
                  onPressed: () {
                    // Handle history button press
                  },
                  child: const Text('History'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0), // Add padding here
                child: ElevatedButton(
                  onPressed: () {
                    // Handle history button press
                  },
                  child: const Text('Current Medication'),
                ),
              ),
            ],
          ),
          // List of rows
          // Image capture/upload button
          const SizedBox(
            height:100,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: 200, // Adjust width as needed
                height: 50, // Adjust height as needed
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const CameraPage()));
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0), // Rounded edges
                    ), 
                    backgroundColor: Colors.teal, // Teal color
                    
                    elevation: 4, // Elevation
                  ),
                  child: const Text(
                    'Capture/Upload Image',
                    style: TextStyle(
                      color: Colors.white, // Text color
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
